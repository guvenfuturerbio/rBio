//
//  OmronPeripheral.h
//  OmronConnectivityLibrary
//
//  Created by Praveen Rajan on 6/17/16.
//  Copyright © 2016 Omron HealthCare Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OmronPeripheral : NSObject

/*!
 *  @property   name
 *
 *  @discussion The current OmronPeripheral name
 *
 */
@property (nonatomic, strong) NSString *name;

/*!
 *  @property   UUID
 *
 *  @discussion The current OmronPeripheral UUID
 *
 */
@property (nonatomic, strong) NSString *UUID;

/*!
 *  @property   RSSI
 *
 *  @discussion The current OmronPeripheral RSSI Strength
 *
 */
@property (nonatomic, strong) NSNumber *RSSI;

/*!
 *  @property   localName
 *
 *  @discussion The current OmronPeripheral Local Name
 *
 */
@property (nonatomic, strong) NSString *localName;

/*!
 *  @property   serialId
 *
 *  @discussion The current OmronPeripheral Serial ID. This is available after successful connection.
 *
 */
@property (nonatomic, strong) NSString *serialId;


/*!
 *  @property   peripheral
 *
 *  @discussion The current OmronPeripheral peripheral CBPeripheral details
 *
 */
@property (nonatomic, strong) CBPeripheral *peripheral;

/*!
 *  @property   protocol
 *
 *  @discussion The current OmronPeripheral peripheral protocol to connect <code>OMRONDeviceProtocol</code>
 *
 */
@property (nonatomic) OMRONDeviceProtocol protocol;

- (id)init NS_UNAVAILABLE;

/*!
 *  @method initWithLocalName:andUUID
 *
 *  @param localName	BLE Local Name of Omron Peripheral
 *  @param UUID         UUID of Omron Peripheral
 *
 *  @discussion         Initialize an object of Omron Peripheral with BLE Local Name and BLE UUID of Omron Peripheral
 *
 */
- (id)initWithLocalName:(NSString *)localName andUUID:(NSString *)UUID;

/*!
 *  @method initWithPeripheral:
 *
 *  @param peripheral	An object of <code>CBPeripheral</code>
 *
 *  @discussion         Initialize an object of Omron Peripheral with CBPeripheral
 *
 */
- (id)initWithPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method initWithDictionary:
 *
 *  @param aDict        A dictionary of Peripheral key/value data points provided by OmronPeripheralManager
 *
 *  @discussion         Initialize an object of Omron Peripheral with dictionary
 *
 */
- (id)initWithDictionary:(NSDictionary *)aDict;

/*!
 *  @method getVitalDataWithUser:withCompletionBlock
 *
 *  @param user             Current selected User to retrieve Vital Data
 *  @param completionBlock	Completion block returning OmronPeripheral Vital Data
 *
 *  @discussion             Omron Peripheral uses this to return Vital data transferred from connected Omron Peripheral using OmronPeripheralManager
 *
 */
- (void)getVitalDataWithUser:(int)user
         withCompletionBlock:(void (^)(NSMutableDictionary *vitalData, NSError *error))completionBlock;

- (id)getVitalDataWithUser:(int)user;

/*!
*  @method getVitalDataWithCompletionBlock
*
*  @param completionBlock    Completion block returning OmronPeripheral Vital Data for all users
*
*  @discussion             Omron Peripheral uses this to return Vital data transferred from connected Omron Peripheral using OmronPeripheralManager
*
*/
- (void)getVitalDataWithCompletionBlock:(void (^)(NSMutableDictionary *vitalData, NSError *error))completionBlock;

- (id)getVitalData;

/*!
 *  @method getDeviceInformationWithCompletionBlock
 *
 *  @param completionBlock	Completion block returning OmronPeripheral Device Information
 *
 *  @discussion             Omron Peripheral uses this to return Peripheral Information like Battery Percentage, Device Local Name, Device UUID from connected Omron Peripheral using OmronPeripheralManager
 *
 */
- (void)getDeviceInformationWithCompletionBlock:(void (^)(NSMutableDictionary *deviceInfo, NSError *error))completionBlock;

- (NSMutableDictionary *)getDeviceInformation;


/*!
 *  @method getDeviceSettingsWithCompletionBlock
 *
 *  @param completionBlock  Completion block returning OmronPeripheral Device Settings (Device + User settings)
 *
 *  @discussion             Omron Peripheral uses this to return device settings from connected Omron Peripheral using OmronPeripheralManager
 *
 */
- (void)getDeviceSettingsWithCompletionBlock:(void (^)(NSMutableArray *deviceSettings, NSError *error))completionBlock;

- (id)getDeviceSettings;

/*!
 *  @method getDeviceSettingsWithUser:withCompletionBlock
 *
 *  @param user             Current selected User to retrieve Device Settings
 *  @param completionBlock  Completion block returning OmronPeripheral Device Settings
 *
 *  @discussion             Omron Peripheral uses this to return device settings from connected Omron Peripheral using OmronPeripheralManager
 *
 */
- (void)getDeviceSettingsWithUser:(int)user
         withCompletionBlock:(void (^)(id deviceSettings, NSError *error))completionBlock;

- (id)getDeviceSettingsWithUser:(int)user;

@end
