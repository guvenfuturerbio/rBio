package com.guvenfuture.onedosehealth

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.DeviceConfiguration.OmronPeripheralManagerConfig
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.Interface.OmronPeripheralManagerDataTransferListener
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.LibraryManager.OmronPeripheralManager
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.Model.OmronErrorInfo
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.Model.OmronPeripheral
import com.omronhealthcare.OmronConnectivityLibrary.OmronLibrary.OmronUtility.OmronConstants
import com.guvenfuture.onedosehealth.constants.Constants
import com.guvenfuture.onedosehealth.constants.OmronDevices
import java.lang.Exception
import java.util.*

class OmronOperators(private val context: Context) {
    private val TAG: String = "OmronOperators"
    var bloodPressureData = MutableLiveData<ArrayList<HashMap<String, Any>>?>()
    fun startOmronPeripheralManager(isHistoricDataRead: Boolean, hashId: String, type:Int) {


        var deviceSettings: ArrayList<HashMap<*, *>?>? = ArrayList()
        // Blood pressure settings (optional)
        deviceSettings = getBloodPressureSettings(deviceSettings ,type)

        OmronPeripheralManagerConfig.userHashId = hashId

        OmronPeripheralManagerConfig.deviceSettings = deviceSettings

        // Set Scan timeout interval (optional)
        OmronPeripheralManagerConfig.timeoutInterval = Constants.CONNECTION_TIMEOUT

        /// geçmişe dair bütün cihaz içerisindeki verileri almak için kullanılan parametre.
        OmronPeripheralManagerConfig.enableAllDataRead = isHistoricDataRead
        OmronPeripheralManagerConfig.sequenceNumbersForTransfer

        var peripheralConfig = OmronPeripheralManager.sharedManager(
            context
        ).configuration

        OmronPeripheralManager.sharedManager(context).configuration = peripheralConfig

        OmronPeripheralManager.sharedManager(context).startManager()
    }

    fun getBloodPressureSettings(deviceSettings: ArrayList<HashMap<*, *>?>?, type:Int): ArrayList<HashMap<*, *>?>? {

        // Blood Pressure
        if (type == OmronConstants.OMRONBLEDeviceCategory.BLOODPRESSURE
        ) {
            val bloodPressurePersonalSettings = HashMap<String, Any>()
            bloodPressurePersonalSettings[OmronConstants.OMRONDevicePersonalSettings.BloodPressureTruReadEnableKey] =
                OmronConstants.OMRONDevicePersonalSettingsBloodPressureTruReadStatus.On
            bloodPressurePersonalSettings[OmronConstants.OMRONDevicePersonalSettings.BloodPressureTruReadIntervalKey] =
                OmronConstants.OMRONDevicePersonalSettingsBloodPressureTruReadInterval.Interval30
            val settings = HashMap<String, Any>()
            settings[OmronConstants.OMRONDevicePersonalSettings.BloodPressureKey] =
                bloodPressurePersonalSettings
            val personalSettings = HashMap<String, HashMap<*, *>>()
            personalSettings[OmronConstants.OMRONDevicePersonalSettingsKey] = settings

            // Personal settings for device
            deviceSettings?.add(personalSettings)
        }
        return deviceSettings
    }


    private fun connectionUpdateWithDevice(
        device: OmronPeripheral,
        resultInfo: OmronErrorInfo,
        wait: Boolean
    ) {
        if (wait) {
            Handler(Looper.getMainLooper()).postDelayed({
                /* Create an Intent that will start the Menu-Activity. */
                resumeConnection(device)
            }, 5000)
        } else {
            Log.d(TAG, "Connection Succeed")
            if (device.vitalData != null) {
                Log.d(TAG, "Vital data - " + device.vitalData.toString())
            }
        }
    }

    private fun resumeConnection(device: OmronPeripheral) {
        OmronPeripheralManager.sharedManager(context)
            .resumeConnectPeripheral(
                device, ArrayList(Arrays.asList<Int>(1))
            ) { peripheral, resultInfo ->
                Log.d("DATA", peripheral.toString())
                Log.d("DATA", resultInfo.toString())
                connectionUpdateWithDevice(
                    peripheral,
                    resultInfo,
                    false
                )
            }
    }

    fun transferData(device: OmronPeripheral, hashId: String, selectedUser: Int,
     type:Int) {
        startOmronPeripheralManager(true, hashId ,type)
        performDataTransfer(device, selectedUser)
    }

    private fun performDataTransfer(device: OmronPeripheral, selectedUser: Int) {
        // Data Transfer from Device using OmronPeripheralManager
        OmronPeripheralManager.sharedManager(context)
            .startDataTransferFromPeripheral(device,
                selectedUser,
                true,
                OmronConstants.OMRONVitalDataTransferCategory.BloodPressure,
                OmronPeripheralManagerDataTransferListener { peripheral, resultInfo ->
                    if (resultInfo.resultCode == 0 && peripheral != null) {
                        val deviceInformation = peripheral.deviceInformation
                        val allSettings = peripheral.deviceSettings as ArrayList<HashMap<*, *>>

                        // Get vital data for previously selected user using OmronPeripheral
                        val output = peripheral.vitalData
                        if (output is OmronErrorInfo) {
                            val errorInfo = output as OmronErrorInfo
                            Log.e(
                                TAG,
                                errorInfo.resultCode.toString() + " / " + errorInfo.detailInfo + " / " + errorInfo.messageInfo
                            )
                        } else {
                            continueDataTransfer()
                        }
                    } else {
                        Log.e(
                            "$TAG perform",
                            resultInfo.resultCode.toString() + " / " + resultInfo.detailInfo + " / " + resultInfo.messageInfo
                        )
                        throw Exception(resultInfo.messageInfo)
                    }
                })
    }

    private fun continueDataTransfer() {
        OmronPeripheralManager.sharedManager(context)
            .endDataTransferFromPeripheral { peripheral, errorInfo ->
                if (errorInfo.resultCode == 0 && peripheral != null) {
                    // Get vital data for previously selected user using OmronPeripheral
                    val output = peripheral.vitalData
                    if (output is OmronErrorInfo) {
                        Log.e(
                            TAG,
                            output.resultCode.toString() + " / " + output.detailInfo + "/" + output.messageInfo
                        )
                    } else {
                        val vitalData =
                            output as HashMap<*, *>

                        // Blood Pressure Data
                        val bloodPressureItemList =
                            vitalData[OmronConstants.OMRONVitalDataBloodPressureKey] as ArrayList<HashMap<String, Any>>?
                        bloodPressureItemList?.let {
                            bloodPressureData.postValue(bloodPressureItemList)

                        }
                    }
                } else {
                    Log.e(
                        TAG,
                        errorInfo.resultCode.toString() + " / " + errorInfo.detailInfo + "/" + errorInfo.messageInfo
                    )
                    continueDataTransfer()
                }
            }
    }
}