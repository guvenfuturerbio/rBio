//
//  OmronPeripheralManagerConfig.h
//  OmronConnectivityLibrary
//
//  Created by Praveen Rajan on 6/17/16.
//  Copyright © 2016 Omron HealthCare Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OmronPeripheralManagerConfig : NSObject

/*!
 *  @property   OAuthDetails
 *
 *  @discussion OmronPeripheralManager OAuth Details of User
 *
 */
@property (nonatomic, strong) id OAuthDetails;

/*!
 *  @property   timeoutInterval
 *
 *  @discussion Timeout Interval to Scan for OmronPeripherals
 *
 */
@property (nonatomic) NSTimeInterval timeoutInterval;

/*!
 *  @property   deviceFilters
 *
 *  @discussion Device Filter to scan Omron Peripherals
 *
 */
@property (nonatomic, strong) NSMutableArray *deviceFilters;

/*!
 *  @property   userHashId
 *
 *  @discussion User Unique Identifier for Device Encryption
 *
 */
@property (nonatomic, strong) NSString *userHashId;

/*!
 *  @property   deviceSettings
 *
 *  @discussion Device Settings for BLE Communication. This includes details like User Height, Weight, Stride, Alarm settings and Time Settings.
 *
 */
@property (nonatomic, strong) NSMutableArray *deviceSettings;

/*!
 *  @property   libraryIdentifier
 *
 *  @discussion Unique Identifier for library instance
 *
 */
@property (nonatomic, strong, readonly) NSString *libraryIdentifier;

/*!
 *  @property   enableAllDataRead
 *
 *  @discussion Read all data from device for the specific user number when transferring data
 *  @discussion Disclaimer: Guest readings from device will also get transferred by enabling this. Application need to handle user data properly to handle privacy.
 *  @discussion Not supported for activity devices
 *
 */
@property (nonatomic) BOOL enableAllDataRead;


/*!
 *  @property   enableiBeaconWithTransfer
 *
 *  @discussion Read iBeacon details during data tranfer
 *  @discussion Disclaimer: Reduce the amount of communication data each time
 *
 */
@property (nonatomic) BOOL enableiBeaconWithTransfer;


/*!
 *  @property   sequenceNumbersForTransfer
 *
 *  @discussion Sequence number mapped to user number in device to start data transfer from memory location in device
 *  @discussion Disclaimer: App integrating library to track this sequence number for future data transfers
 *
*/
@property (nonatomic) NSDictionary *sequenceNumbersForTransfer;

/*!
 *  @method retrievePeripheralConfigurationWithGroupId
 *
 *  @param groupId              Group Id of Device
 *  @param groupIncludedId      Group Included Id of Device
 *  @discussion                 Returns Omron Peripheral Device configuration for a particular Group Id and Group Included Id
 *
 */
- (NSMutableDictionary *)retrievePeripheralConfigurationWithGroupId:(NSString *)groupId andGroupIncludedId:(NSString *)groupIncludedId;

@end
