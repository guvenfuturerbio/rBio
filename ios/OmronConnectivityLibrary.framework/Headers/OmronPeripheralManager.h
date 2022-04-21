//
//  OmronPeripheralManager.h
//  OmronConnectivityLibrary
//
//  Created by Praveen Rajan on 6/17/16.
//  Copyright © 2016 Omron HealthCare Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OmronPeripheralManagerConfig.h"
#import "OmronPeripheral.h"

@interface OmronPeripheralManager : NSObject

- (id)init NS_UNAVAILABLE;

/*!
 *  @method sharedManager
 *
 *  @discussion     Initializes a shared instance of Omron Peripheral Manager
 *
 */
+ (id)sharedManager;

/*!
 *  @method libVersion
 *
 *  @discussion     Omron Connect Library Version
 *	@return         Returns Current Omron Library Version Number
 */
- (NSString *)libVersion;

/*!
 *  @method startManager
 *
 *  @discussion     Starts Omron Peripheral Manager for Connectivity
 *
 */
- (void)startManager;

/*!
 *  @method stopManager
 *
 *  @discussion     Stops Omron Peripheral Manager for Connectivity
 *
 */
- (void)stopManager;

/*!
 *  @method retrieveManagerConfiguration
 *
 *  @discussion     Omron Peripheral Manager Configurations
 *	@return         Returns Omron Peripheral Manager Configurations like Omron Connected Devices
 */
- (id)retrieveManagerConfiguration;

/*!
 *  @method setConfiguration:
 *
 *  @param config	Omron Peripheral Manager Configuration <code>OmronPeripheralManagerConfig</code> object.
 *
 *  @discussion     Sets Omron Peripheral Manager Configurations like Device Filter, Device Settings, Timeout, UserHashId
 *
 */
- (void)setConfiguration:(OmronPeripheralManagerConfig *)config;

/*!
 *  @method getConfiguration
 *
 *
 *  @discussion     Omron Peripheral Manager Configurations like Device Filter, Timeout, etc.
 *	@return         Returns an object of <code>OmronPeripheralManagerConfig</code> Omron Peripheral Manager Configurations
 *                  like Device Filter, Timeout, etc.
 */
- (OmronPeripheralManagerConfig *)getConfiguration;

/*!
 *  @method setAPIKey:options:
 *
 *  @param APIKey	Partner API Key
 *  @param options	Partner Additional Options
 *
 *  @discussion     Omron Peripheral Manager Partner Authorization
 *
 */
- (void)setAPIKey:(NSString *)APIKey options:(NSDictionary *)options;

/*!
 *  @method getAPIKey
 *
 *  @return Returns Partner API Key
 *  @discussion     Omron Peripheral Manager Partner Authorization
 *
 */
- (NSString *)getAPIKey;

/*!
 *  @method getBluetoothState
 *
 *  @discussion     Helps to retrieve current bluetooth state of smartphone
 *  @return         Returns Bluetooth state
 */
- (OMRONBLEBluetoothState)getBluetoothState;

/*!
 *  @method startScanPeripheralsWithCompletionBlock:
 *
 *  @param completionBlock	Completion block returning scanned Omron Peripherals and Error object if any
 *
 *  @discussion             Omron Peripheral Manager starts scanning for Omron Peripherals and returns them.
 *                          If an error occurs it will be returned in completion block.
 *
 */
- (void)startScanPeripheralsWithCompletionBlock:(void (^)(NSArray *retrievedPeripherals, NSError *error))completionBlock;

/*!
 *  @method stopScanPeripherals:
 *
 *
 *  @discussion             Omron Peripheral Manager stops scanning for Omron Peripherals
 *
 */
- (void)stopScanPeripherals;

/*!
 *  @method stopScanPeripheralsWithCompletionBlock:
 *
 *  @param completionBlock	Completion block returning an error object
 *  @discussion             Omron Peripheral Manager stops scanning for Omron Peripherals and provides completion block
 *
 */
- (void)stopScanPeripheralsWithCompletionBlock:(void (^)(NSError *error))completionBlock;

/*!
 *  @method connectPeripheral:withCompletionBlock:
 *
 *  @param peripheral       Omron Peripheral to Connect to using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param completionBlock	Completion block returning connected OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager starts connecting to specified Omron Peripheral
 *
 */
- (void)connectPeripheral:(OmronPeripheral *)peripheral
      withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method connectPeripheral:withWait:withCompletionBlock:
 *
 *  @param peripheral       Omron Peripheral to Connect to using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param isWait           Wait during connection for user selection to register device
 *  @param completionBlock  Completion block returning connected OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager starts connecting to specified Omron Peripheral and wait for user input
 *
 */
- (void)connectPeripheral:(OmronPeripheral *)peripheral
                 withWait:(BOOL)isWait
      withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method resumeConnectPeripheralWithUser:withCompletionBlock:
 *
 *  @param currentUser      Current selected User to begin pair
 *  @param completionBlock  Completion block returning connected OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager resumes connecting to specified Omron Peripheral with selected user
 *
 */
- (void)resumeConnectPeripheralWithUser:(int)currentUser
                    withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method resumeConnectPeripheralWithUsers:withCompletionBlock:
 *
 *  @param users      User list to connect
 *  @param completionBlock  Completion block returning connected OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager resumes connecting to specified Omron Peripheral with selected user
 *
 */
- (void)resumeConnectPeripheralWithUsers:(NSArray *)users
                     withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method endConnectPeripheralWithCompletionBlock:
 *
 *  @param completionBlock  Completion block returning connected OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager ends connection to specified Omron Peripheral which awaits resume connection
 *
 */
- (void)endConnectPeripheralWithCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method disconnectPeripheral:withCompletionBlock:
 *
 *  @param peripheral       Omron Peripheral to Disconnect to using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param completionBlock	Completion block returning disconnected OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager stops connecting to specified Omron Peripheral
 *
 */
- (void)disconnectPeripheral:(OmronPeripheral *)peripheral
         withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method onConnectStateChangeWithCompletionBlock:
 *
 *  @param completionBlock	Completion block returns connection state change as OMRONBLEConnectionState (defined in OmronDefines.h)
 *
 *  @discussion             Omron Peripheral Manager Listens to Connection State Changes
 *
 */
- (void)onConnectStateChangeWithCompletionBlock:(void (^)(int state))completionBlock;

/*!
 *  @method onPeriodicWithCompletionBlock:
 *
 *  @param completionBlock    Completion block returns periodic callback to app when Omron peripheral is connected
 *
 *  @discussion             Omron Peripheral Manager returns periodic callback to app
 *
 */
- (void)onPeriodicWithCompletionBlock:(void (^)())completionBlock;

/*!
 *  @method startDataTransferFromPeripheral:withUser:withWait:withCompletionBlock
 *
 *  @param peripheral       Omron Peripheral to Start Data Transfer using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param currentUser      Current selected User to begin data transfer
 *  @param isWait           Wait during data transfer to save transferred data
 *  @param completionBlock  Completion block returning OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager starts transferring data from connected Omron Peripheral
 *
 */
- (void)startDataTransferFromPeripheral:(OmronPeripheral *)peripheral
                               withUser:(int)currentUser
                               withWait:(BOOL)isWait
                    withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method startDataTransferFromPeripheral:withUsers:withWait:withCompletionBlock
 *
 *  @param peripheral       Omron Peripheral to Start Data Transfer using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param users              User list to perform data transfer
 *  @param isWait             Wait during data transfer to save transferred data
 *  @param completionBlock  Completion block returning OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager starts transferring data from connected Omron Peripheral
 *
 */
- (void)startDataTransferFromPeripheral:(OmronPeripheral *)peripheral
                              withUsers:(NSArray *)users
                               withWait:(BOOL)isWait
                    withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method startDataTransferFromPeripheral:withUser:withWait:withType:withCompletionBlock
 *
 *  @param peripheral       Omron Peripheral to Start Data Transfer using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param currentUser      Current selected User to begin data transfer
 *  @param isWait           Wait during data transfer to save transferred data
 *  @param type             Type of vital data category to transfer (OMRONVitalDataTransferCategoryAll or OMRONVitalDataTransferCategoryBloodPressure)
 *  @param completionBlock  Completion block returning OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager starts transferring data from connected Omron Peripheral
 *
 */
- (void)startDataTransferFromPeripheral:(OmronPeripheral *)peripheral
                               withUser:(int)currentUser
                               withWait:(BOOL)isWait
                               withType:(OMRONVitalDataTransferCategory)type
                    withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method startDataTransferFromPeripheral:withUsers:withWait:withType:withCompletionBlock
 *
 *  @param peripheral       Omron Peripheral to Start Data Transfer using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param users             User list to perform data transfer
 *  @param isWait           Wait during data transfer to save transferred data
 *  @param type             Type of vital data category to transfer (OMRONVitalDataTransferCategoryAll or OMRONVitalDataTransferCategoryBloodPressure)
 *  @param completionBlock  Completion block returning OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager starts transferring data from connected Omron Peripheral
 *
 */
- (void)startDataTransferFromPeripheral:(OmronPeripheral *)peripheral
                              withUsers:(NSArray *)users
                               withWait:(BOOL)isWait
                               withType:(OMRONVitalDataTransferCategory)type
                    withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method endDataTransferFromPeripheralWithCompletionBlock
 *
 *  @param completionBlock  Completion block returning OmronPeripheral Details. Used with startDataTransferFromPeripheral:withUser:withWait:withCompletionBlock
 *
 *  @discussion             Omron Peripheral Manager ends transferring data from connected Omron Peripheral
 *
 */
- (void)endDataTransferFromPeripheralWithCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method onDataProgressChangeWithCompletionBlock:
 *
 *  @param completionBlock    Completion block returning Details like - progress, total unsend data, remaining data to transfer
 *
 *  @discussion             Omron Peripheral Manager Returns Progress of Data Transfer
 *
 */
- (void)onDataProgressChangeWithCompletionBlock:(void (^)(float progress, int total, int remaining))completionBlock;

/*!
 *  @method updatePeripheral:withCompletionBlock
 *
 *  @param peripheral       Omron Peripheral to update settings using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param completionBlock	Completion block returning OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager updates settings of device like time settings, alarm, user settings.
 *
 */
- (void)updatePeripheral:(OmronPeripheral *)peripheral
     withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method updatePeripheral:withUser:withCompletionBlock
 *
 *  @param peripheral       Omron Peripheral to update settings using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param currentUser      Current selected User to update device settings
 *  @param completionBlock    Completion block returning OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager updates settings of device like time settings, alarm, user settings.
 *
 */
- (void)updatePeripheral:(OmronPeripheral *)peripheral
                withUser:(int)currentUser
     withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method updatePeripheral:withUsers:withCompletionBlock
 *
 *  @param peripheral              Omron Peripheral to update settings using Manager. Object of <code>OmronPeripheral</code> is passed
 *  @param users                     User list to perform data transfer
 *  @param completionBlock   Completion block returning OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager updates settings of device like time settings, alarm, user settings.
 *
 */
- (void)updatePeripheral:(OmronPeripheral *)peripheral
               withUsers:(NSArray *)users
     withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method startRecording:onSignalStrength:withCompletionBlock:
 *
 *  @param peripheral                      Omron Peripheral to start recording temperature from Thermometer. Object of <code>OmronPeripheral</code> is passed
 *  @param onSignalStrength         Signal Level in dB is returned periodically
 *  @param completionBlock           Completion block returning connected OmronPeripheral Details including vital data transferred
 *
 *  @discussion             Omron Peripheral Manager starts recording data from specified Omron Peripheral
 *
 */
- (void)startRecording:(OmronPeripheral *)peripheral
      onSignalStrength:(void (^)(double signal))signalStrengthBlock
   withCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

/*!
 *  @method stopRecordingWithCompletionBlock:
 *
 *  @param completionBlock           Completion block returning connected OmronPeripheral Details
 *
 *  @discussion             Omron Peripheral Manager stops recording data from specified Omron Peripheral
 *
 */
- (void)stopRecordingWithCompletionBlock:(void (^)(OmronPeripheral *peripheral, NSError *error))completionBlock;

@end
