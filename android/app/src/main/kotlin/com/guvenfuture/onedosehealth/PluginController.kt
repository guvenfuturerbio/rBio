package com.guvenfuture.onedosehealth

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.google.gson.Gson
import com.guvenfuture.onedosehealth.constants.ChannelConstant
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.LibraryManager.OmronPeripheralManager
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.Model.OmronPeripheral
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.OmronUtility.OmronConstants
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PluginController {

    private lateinit var owner: androidx.lifecycle.LifecycleOwner

    val TAG: String = "PluginController"
    private val uiThreadHandler: Handler = Handler(Looper.getMainLooper())

    private lateinit var context: Context

    private lateinit var omronOperators: OmronOperators
    private var connectionState: MutableLiveData<Int> = MutableLiveData<Int>()

    private val pluginMethods =
        mapOf<String, (call: MethodCall, result: MethodChannel.Result) -> Unit>(
            ChannelConstant.StartTransferProcess to this::startTransferDataProcess,
            ChannelConstant.SetKey to this::setApiKey,
            ChannelConstant.ConnectDevice to this::connectDevice,
            ChannelConstant.ContinueToConnection to this::continueConnection,

        )

    internal fun initialize(
        messenger: BinaryMessenger,
        context: Context,
        owner: androidx.lifecycle.LifecycleOwner
    ) {
        this.context = context
        omronOperators = OmronOperators(context)
        this.owner = owner

        LocalBroadcastManager.getInstance(context).registerReceiver(
            mMessageReceiver,
            IntentFilter(OmronConstants.OMRONBLEConfigDeviceAvailabilityNotification)
        )
        LocalBroadcastManager.getInstance(context).registerReceiver(
            mMessageReceiver,
            IntentFilter(OmronConstants.OMRONBLECentralManagerDidUpdateStateNotification)
        )

        val scanSpecificOmronPeripheral = EventChannel(
            messenger,
            ChannelConstant.searchOmronPeripheral
        )

        scanSpecificOmronPeripheral.setStreamHandler(
            object : EventChannel.StreamHandler{
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    var categoryType = 0

                    if((arguments as HashMap<*, *>)["categoryType"] != null){
                        categoryType = (arguments as HashMap<*, *>)["categoryType"] as Int
                    }
                    omronOperators.startOmronPeripheralManager(
                        true,
                        (arguments as HashMap<*, *>)["hashId"] as String, categoryType
                    )

                    OmronPeripheralManager.sharedManager(context).startScanPeripherals{
                            peripheralList, omronErrorInfo ->
                        if(omronErrorInfo !=null&&peripheralList != null && peripheralList.isNotEmpty() ){
                            val list = ArrayList<java.util.HashMap<*, *>>()
                            for (item in peripheralList){
                                list.add(item.deviceInformation)
                            }
                            uiThreadHandler.post {  events?.success(list)}
                        }else{
                            val isNotNull = omronErrorInfo.messageInfo!=null
                            var errorInfo = ""
                            errorInfo = if(isNotNull){
                                omronErrorInfo.messageInfo
                            }else{
                                omronErrorInfo.toString()
                            }
                            uiThreadHandler.post {
                            events?.error(ChannelConstant.searchOmronPeripheral, errorInfo,"" )}
                        }
                    }
                }

                override fun onCancel(arguments: Any?) {
                    OmronPeripheralManager.sharedManager(context).stopScanPeripherals()
                }
            }
        )



        val transferChannel = EventChannel(
            messenger,
            ChannelConstant.TransferData
        )

        transferChannel.setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    Log.d("DATA_TRANSFER", "TRANSFER STARTED")
                    omronOperators.bloodPressureData.observe(owner, Observer { t ->
                        Log.d("Datas",t.toString())
                        t?.forEach { item ->
                            events?.success(item)
                        }
                    })
                }

                override fun onCancel(arguments: Any?) {
                    omronOperators.bloodPressureData =
                        MutableLiveData<ArrayList<HashMap<String, Any>>?>()
                }

            }
        )
        val connectionStatusChannel = EventChannel(messenger, ChannelConstant.ConnectionStatus)

        connectionStatusChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                Log.d("CONNECTION_STATUS", "CONNECTION_STATUS_LISTENING")
                connectionState.observe(owner, Observer { t -> events?.success(t) })
            }

            override fun onCancel(arguments: Any?) {
                connectionState.postValue(OmronConstants.OMRONBLEConnectionState.UNKNOWN)
            }

        })
    }


    internal fun execute(call: MethodCall, result: MethodChannel.Result) {
        pluginMethods[call.method]?.invoke(call, result) ?: result.notImplemented()
    }

    private fun startTransferDataProcess(call: MethodCall, result: MethodChannel.Result) {
        try {
            val connectDeviceMessage: OmronPeripheral =
                OmronPeripheral(
                    (call.arguments as HashMap<*, *>)["device"].toString(),
                    (call.arguments as HashMap<*, *>)["uuid"].toString()
                )
            var deviceType = 0

            if((call.arguments as HashMap<*, *>)["deviceType"] != null){
                deviceType = (call.arguments as HashMap<*, *>)["deviceType"] as Int
            }


            omronOperators.transferData(
                connectDeviceMessage,
                (call.arguments as HashMap<*, *>)["hashId"] as String,
                (call.arguments as HashMap<*, *>)["userType"] as Int,
                deviceType ,

            )

            // Listen to Device state changes using OmronPeripheralManager
            connectionState()
            result.success(null)
        } catch (e: Exception) {
            result.error("ConnectDevice", e.toString(), "unAuthorized")
        }
    }

    private fun connectionState() {
        // Listen to Device state changes using OmronPeripheralManager
        OmronPeripheralManager.sharedManager(context)
            .onConnectStateChange { state ->
                Log.d(TAG, "flow processs " + state)
                connectionState.postValue(state)
            }
    }





    private val mMessageReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            // Get extra data included in the Intent
            val status = intent.getIntExtra(OmronConstants.OMRONConfigurationStatusKey, 0)
            if (status == OmronConstants.OMRONConfigurationStatus.OMRONConfigurationFileSuccess) {
                Log.d(TAG, "Config File Extract Success")
            } else if (status == OmronConstants.OMRONConfigurationStatus.OMRONConfigurationFileError) {
                Log.d(TAG, "Config File Extract Failure")
            } else if (status == OmronConstants.OMRONConfigurationStatus.OMRONConfigurationFileUpdateError) {
                Log.d(TAG, "Config File Update Failure")
            }
            getDeviceList()
        }
    }

    private fun setApiKey(call: MethodCall, result: MethodChannel.Result) {
        val key: String = call.arguments<HashMap<*, *>>()["key"].toString()
        OmronPeripheralManager.sharedManager(context)?.setAPIKey(key, null)
        result.success(null)
    }

    // Get All Supported Omron BLE devices.
    fun getDeviceList() {
        if (OmronPeripheralManager.sharedManager(context)
                .retrieveManagerConfiguration(context) != null
        ) {
            val fullDeviceList =
                OmronPeripheralManager.sharedManager(context).retrieveManagerConfiguration(
                    context
                )[OmronConstants.OMRONBLEConfigDeviceKey] as List<HashMap<String?, String?>?>?
            if (fullDeviceList != null) {
                for (device in fullDeviceList) {
                    val gson = Gson()
                    val json: String = gson.toJson(device)
                    //Log.d(TAG, json)
                }
            }
        }
    }

    private fun connectDevice(call: MethodCall, result: MethodChannel.Result) {
        var deviceType = 0

        if((call.arguments as HashMap<*, *>)["deviceType"] != null){
            deviceType = (call.arguments as HashMap<*, *>)["deviceType"] as Int
        }

        omronOperators.startOmronPeripheralManager(
            true,
            (call.arguments as HashMap<*, *>)["hashId"] as String,deviceType
        )
        val connectDeviceMessage: OmronPeripheral =
            OmronPeripheral(
                (call.arguments as HashMap<*, *>)["device"].toString(),
                (call.arguments as HashMap<*, *>)["uuid"].toString()
            )

        OmronPeripheralManager.sharedManager(context).startScanPeripherals { arrayList, omronErrorInfo ->

            try {
                var data: OmronPeripheral? = null



                if(omronErrorInfo != null) {
                    Log.e("Error", omronErrorInfo.toString())
                }
                if (data == null && (arrayList != null && arrayList.isNotEmpty())) {
                    data = try {
                       arrayList.find { it.uuid == connectDeviceMessage.uuid }
                    }catch (e: NoSuchElementException){
                        null
                    }

                    if(data!=null){
                        OmronPeripheralManager.sharedManager(context)
                            .connectPeripheral(data, true) { perp, info ->
                                if (perp != null) {
                                    OmronPeripheralManager.sharedManager(context).stopScanPeripherals()
                                    result.success(null)
                                }
                            }
                    }else{
                        Log.d("ConnectDevice", "UUID e??le??mesi bulunamad??.")
                    }
                }
            } catch (event: IllegalStateException) {
                Log.d("Error","Hataburdaaaa")

                Log.e("Error", event.message.toString())
            }
        }
    }



    private fun continueConnection(call: MethodCall, result: MethodChannel.Result) {
        val connectDeviceMessage: OmronPeripheral =
            OmronPeripheral(
                (call.arguments as HashMap<*, *>)["device"].toString(),
                (call.arguments as HashMap<*, *>)["uuid"].toString()
            )
        OmronPeripheralManager.sharedManager(context).resumeConnectPeripheral(
            connectDeviceMessage,
            (call.arguments as HashMap<*, *>)["userType"] as Int
        ) { perp, data ->
            if (perp != null) {
                result.success(null)
            } else
                result.error("Cannot Connected", "device connection unsuccesfull", data.toString())
        }
    }
}