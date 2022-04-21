import UIKit
import Flutter
import OmronConnectivityLibrary


let omronManager = OmronConnectivityLibrary.OmronPeripheralManager.self
var localPeripheral: OmronPeripheral?
var users: [Int]? = [1]
var deviceSettings: NSMutableArray = []

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let methodChannel = "com.guvenfuture.onedosehealth.customimplement.omron"
      let tmpOmronObj = OmronConnectivityLibrary.OmronPeripheralManager.sharedManager() as! OmronPeripheralManager
      
      let omronChannel = FlutterMethodChannel(
        name: methodChannel,
        binaryMessenger: controller.binaryMessenger)
      startOmronPeripheralManager(isHistoricDataRead: false, hashId: "eyc", tmpOmronObj: tmpOmronObj)
      
      omronChannel.setMethodCallHandler({
          (call, result) -> Void in
          switch call.method {
          case "ConnectDevice":
              guard let args = call.arguments as? [String: Any] else {return}
              //if connectOmron is never triggered, check 'if let' line - eyc
              if let tmpPeripheral = OmronPeripheral.init(localName: args["name"] as? String, andUUID: args["uuid"] as? String) {
                  connectOmron(peripheral: tmpPeripheral, tmpOmronObj: tmpOmronObj)
              }
              result(args)
          case "ContinueToConnection":
              guard let args = call.arguments as? [String: Any] else {return}
              var _: OmronPeripheral = OmronPeripheral(localName: (args["name"] as! String), andUUID: (args["uuid"] as! String))
              tmpOmronObj.resumeConnectPeripheral(withUser: args["userType"] as! Int32) { _, error in
                  if error == nil {
                      result(args)
                  }else{
                      result(error)
                  }
              }
          case "setKey":
              guard let args = call.arguments as? [String: Any] else {return}
              tmpOmronObj.setAPIKey((args["key"] as? String), options: nil)
              result(args)
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

private func connectOmron(peripheral: OmronPeripheral, tmpOmronObj: OmronPeripheralManager){
    
    tmpOmronObj.connect(peripheral, withWait: false) { peripheral, error in
        print("PERIPHERAL - \(String(describing: peripheral))")
        connectionUpdateWithPeripheral(peripheral: peripheral, error: error as? NSError, wait: false, tmpOmronObj: tmpOmronObj)
    }
}



private func connectionUpdateWithPeripheral(peripheral: OmronPeripheral?, error: NSError?, wait: Bool, tmpOmronObj: OmronPeripheralManager){
    DispatchQueue.main.async {
        if error == nil {
            print("CONNECTOMRON - connectionUpdateWithPeripheral")
            localPeripheral = peripheral
            let peripheralConfig = tmpOmronObj.getConfiguration()
            peripheralConfig?.enableiBeaconWithTransfer = true
        
            getBloodPressureSettings()
        
            peripheralConfig?.deviceSettings = deviceSettings
            peripheralConfig?.userHashId = "eyc"
            
            tmpOmronObj.setConfiguration(peripheralConfig)
            tmpOmronObj.start()
            
            print("PeripheralConfig - \(String(describing: peripheralConfig))")
            
            let deviceConfig = peripheralConfig?.retrievePeripheralConfiguration(withGroupId: peripheral?.value(forKey: OMRONBLEConfigDeviceGroupIDKey) as? String, andGroupIncludedId: peripheral?.value(forKey: OMRONBLEConfigDeviceGroupIncludedGroupIDKey) as? String)
            
            print("DeviceConfig - \(String(describing: deviceConfig))")
            
            if wait {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    resumeConnection(tmpOmronObj: tmpOmronObj)
                }
            } else {
                peripheral?.getVitalData { vitalData, error in
                    if error == nil {
                        if (vitalData?.allKeys.count)! > 0 {
                            print("Vital Data - \(String(describing: vitalData))")
                        }
                    }
                }
            }
            
        }else{
            print("Error - connectionUpdateWithPeripheral : \(String(describing: error))")
        }
    }
}

private func resumeConnection(tmpOmronObj: OmronPeripheralManager){
    if users?.count ?? 1 > 1 {
        tmpOmronObj.resumeConnectPeripheral(withUsers: users) { peripheral, error in
            if let peripheral = peripheral{
                connectionUpdateWithPeripheral(peripheral: peripheral, error: error as? NSError, wait: false, tmpOmronObj: tmpOmronObj)
            }
        }
    } else {
        tmpOmronObj.resumeConnectPeripheral(withUser: Int32(users?.first ?? 1)) { peripheral, error in
            if let peripheral = peripheral{
                connectionUpdateWithPeripheral(peripheral: peripheral, error: error as? NSError, wait: false, tmpOmronObj: tmpOmronObj)
            }
        }
    }
}

func getBloodPressureSettings(){
    let bloodPressurePersonalSettings = [OMRONDevicePersonalSettingsBloodPressureDCIKey: OMRONDevicePersonalSettingsBloodPressureDCINotAvailable, OMRONDevicePersonalSettingsBloodPressureTruReadEnableKey: OMRONDevicePersonalSettingsBloodPressureTruReadOn, OMRONDevicePersonalSettingsBloodPressureTruReadIntervalKey: OMRONDevicePersonalSettingsBloodPressureTruReadInterval30] as NSDictionary
    
    let settings = [OMRONDevicePersonalSettingsBloodPressureKey: bloodPressurePersonalSettings] as NSDictionary
    
    let personalSettings = NSMutableDictionary.init()
    
    personalSettings.setObject(settings, forKey: OMRONDevicePersonalSettingsKey as NSCopying)
    
    deviceSettings.add(personalSettings)
}

func startOmronPeripheralManagerWithHistoricRead(isHistoric: Bool, tmpOmronObj: OmronPeripheralManager){
    let peripheralConfig = tmpOmronObj.getConfiguration()
    peripheralConfig?.timeoutInterval = 60
    deviceSettings = NSMutableArray.init()
    peripheralConfig?.enableAllDataRead = isHistoric
    peripheralConfig?.enableiBeaconWithTransfer = true

    getBloodPressureSettings()

    peripheralConfig?.deviceSettings = deviceSettings
    peripheralConfig?.userHashId = "eyc"
    
    tmpOmronObj.setConfiguration(peripheralConfig)
    tmpOmronObj.start()
}

func startOmronPeripheralManager(isHistoricDataRead: Bool, hashId: String, tmpOmronObj: OmronPeripheralManager){
    getBloodPressureSettings()
    let tmpConfig = tmpOmronObj.getConfiguration()
    tmpConfig?.userHashId = hashId
    tmpConfig?.deviceSettings = deviceSettings
    tmpConfig?.timeoutInterval = 60
    tmpConfig?.enableAllDataRead = true
    //tmpConfig?.sequenceNumbersForTransfer
    getBloodPressureSettings()
    
    tmpOmronObj.setConfiguration(tmpConfig)
    tmpOmronObj.start()
}
