package com.guvenfuture.onedosehealth

import android.Manifest
import android.content.Context
import android.os.Build
import com.polidea.rxandroidble2.exceptions.BleException
import android.os.Bundle
import androidx.lifecycle.LifecycleOwner
import com.guvenfuture.onedosehealth.omron.PluginController
import com.guvenfuture.onedosehealth.omron.constants.ChannelConstant
import io.reactivex.exceptions.UndeliverableException
import io.reactivex.plugins.RxJavaPlugins
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class MainActivity: FlutterActivity(), FlutterPlugin, MethodChannel.MethodCallHandler {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        RxJavaPlugins.setErrorHandler { throwable ->
            if (throwable is UndeliverableException && throwable.cause is BleException) {
                return@setErrorHandler // ignore BleExceptions since we do not have subscriber
            } else {
                throw throwable
            }
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        initalizePlugin(binding.binaryMessenger, binding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        //TODO("Not yet implemented")
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        pluginController.execute(call, result)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                1
            )
        }

        owner = this
        initalizePlugin(flutterEngine.dartExecutor.binaryMessenger, context)
    }


    companion object{
        lateinit var owner: LifecycleOwner

        private lateinit var pluginController: PluginController

        // this enables support for apps that are using the legacy implementation of the app
        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            initalizePlugin(registrar.messenger(), registrar.activeContext())
        }

        @JvmStatic
        private fun initalizePlugin(messenger: BinaryMessenger, context: Context) {
            val channel = MethodChannel(messenger, ChannelConstant.MethodeChannel)
            channel.setMethodCallHandler(MainActivity())
            pluginController = PluginController()
            pluginController.initialize(messenger, context,owner)

        }
    }



}

