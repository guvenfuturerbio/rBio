//
//  OmronDefines.h
//  OmronConnectivityLibrary
//
//  Created by Praveen Rajan on 6/21/16.
//  Copyright © 2016 Omron HealthCare Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSNotification

/******************************************************************************************************/
/*************************************** NSNOTIFICATION LISTENERS **********************/
/******************************************************************************************************/

// CBCentralManager Notification Listener Key for State Changes
UIKIT_EXTERN NSNotificationName const OMRONBLECentralManagerDidUpdateStateNotification;

// CBCentralManager Notification Listener Key for Device Disconnect
UIKIT_EXTERN NSNotificationName const OMRONBLECentralManagerDidDisconnectNotification;

// Device Configuration Notification Listener Key
UIKIT_EXTERN NSNotificationName const OMRONBLEConfigDeviceAvailabilityNotification;

#pragma mark - Vital Data

/******************************************************************************************************/
/*************************************** VITAL DATA ***************************************************/
/******************************************************************************************************/

#pragma mark - Blood Pressure Data Keys

/* OMRON Connectivity Library Blood Pressure Data Keys */
extern NSString * const OMRONVitalDataBloodPressureKey;                     // Blood Pressure Key

extern NSString * const OMRONVitalDataSystolicKey;                          // Systolic Key
extern NSString * const OMRONVitalDataDiastolicKey;                         // Diastolic Key
extern NSString * const OMRONVitalDataPulseKey;                             // Pulse Key
extern NSString * const OMRONVitalDataPositioningIndicatorKey;              // Positioning Indicator Key
extern NSString * const OMRONVitalDataRoomTemperatureKey;                   // Room Temperature Key
extern NSString * const OMRONVitalDataIrregularFlagKey;                     // Irregular HeartBeat Display Key
extern NSString * const OMRONVitalDataMovementFlagKey;                      // Movement Error Display Key
extern NSString * const OMRONVitalDataCuffFlagKey;                          // Cuff Wrap Guide Display Key
extern NSString * const OMRONVitalDataConsecutiveMeasurementKey;            // Consecutive Measurement Key
extern NSString * const OMRONVitalDataArtifactDetectionKey;                 // No of Detected Artifact
extern NSString * const OMRONVitalDataIHBDetectionKey;                      // No of IHB Detection Key
extern NSString * const OMRONVitalDataIrregularPulseDetectionFlagKey;       // Irregular Pulse Detection Flag Key
extern NSString * const OMRONVitalDataMovementDetectionFlagKey;             // Movement Detection Flag Key
extern NSString * const OMRONVitalDataCuffWrapDetectionFlagKey;             // Cuff Wrap Detection Flag Key
extern NSString * const OMRONVitalDataMeanArterialPressureKey;              // Mean Arterial Pressure Key
extern NSString * const OMRONVitalDataPulseRateDetectionFlagKey;            // Pulse Rate Detection Flag
extern NSString * const OMRONVitalDataPositionDetectionFlagKey;             // Measurement Position Detection Flag
extern NSString * const OMRONVitalDataInternalTemperatureKey;               // Internal Temperature of Device
extern NSString * const OMRONVitalDataMeasurementStartingMethodKey;         // Measurement Starting Method
extern NSString * const OMRONVitalDataMeasurementMETsKey;                   // METs before measurement
extern NSString * const OMRONVitalDataDateEnableKey;                        // Date Enable Key
extern NSString * const OMRONVitalDataErrorDetailsKey;                      // Error Details during measurement
extern NSString * const OMRONVitalDataErrorCodeKey;                         // Error Code during measurement
extern NSString * const OMRONVitalDataAtrialFibrillationDetectionFlagKey;   // Atrial Fibrillation Detection Flag
extern NSString * const OMRONVitalDataTimeDifferenceKey;                    // Time difference
extern NSString * const OMRONVitalDataIrregularHeartBeatCountKey;           // Irregular HeartBeat Count Key
extern NSString * const OMRONVitalDataMeasurementModeKey;                   // Blood Pressure Measurement Mode
extern NSString * const OMRONVitalDataAtrialFibrillationModeKey;            // Atrial Fibrillation Mode
extern NSString * const OMRONVitalDataMeasurementKindNightModeKey;          // Measurement kind Night mode
extern NSString * const OMRONVitalDataErrorCodeNightModeKey;                // Measurement Error Code Night mode
extern NSString * const OMRONVitalDataCountMeasurementSuccessNightModeKey;  // Measurement Success Count Night mode
extern NSString * const OMRONVitalDataCountMeasurementErrorNightModeKey;    // Measurement Error Count Night mode
extern NSString * const OMRONVitalDataMeasurementStartDateNightModeKey;     // Measurement Start Date Night mode
extern NSString * const OMRONVitalDataDisplayedErrorCodeNightModeKey;       // Measurement Displayed Error Code Night mode

extern NSString * const OMRONVitalDataMeasurementDateKey;                   // Measurement Date Key
extern NSString * const OMRONVitalDataMeasurementStartDateKey;              // Measurement Start Date Key (UTC Time)
extern NSString * const OMRONVitalDataSequenceKey;                          // Sequence Number Key
extern NSString * const OMRONVitalDataUserIdKey;                            // User Id Key

// OMRONVitalDataMeasurementModeKey - types of measurement mode
typedef enum {
    OMRONVitalDataMeasurementModeTypeNormal = 0,                            // Normal Mode
    OMRONVitalDataMeasurementModeTypeAFib = 1,                              // Afib Mode
    OMRONVitalDataMeasurementModeTypeNightTimeDesignation = 2,              // Night + Time designation
    OMRONVitalDataMeasurementModeTypeNightElapsedTime = 3,                  // Night + Elapsed time
    OMRONVitalDataMeasurementModeTypeNightElapsedTimeTimeDesignation = 4,   // Night + Elapsed time + Time designation
    OMRONVitalDataMeasurementModeTypeTruRead  = 5                           // TruRead
} OMRONVitalDataMeasurementModeTypeKey;


#pragma mark - Activity Data Keys

/* OMRON Connectivity Library Activity Data Keys */
extern NSString * const OMRONVitalDataActivityKey;                          // Activity Data Key

// Date and Sequence no of Activity Data
extern NSString * const OMRONActivityStartDateKey;                          // Activity Start Date Key (UTC Time)
extern NSString * const OMRONActivityAchievementRateKey;                    // Activity Target Step Achievement Rate
extern NSString * const OMRONActivityTargetStepsKey;                        // Activity Target Steps
extern NSString * const OMRONActivityTimeDifferenceKey;                     // Time difference key
extern NSString * const OMRONActivitySequenceNumberKey;                     // Sequence Number Key
extern NSString * const OMRONActivityUserIdKey;                             // User Id Key

// Types of Activity Data
extern NSString * const OMRONActivityStepsPerDay;                           // Number of steps / day steps (time division)
extern NSString * const OMRONActivityAerobicStepsPerDay;                    // Steady steps / firmly step count (time division)
extern NSString * const OMRONActivityExStepsPerDay;                         // EX number/day EX number (divided)
extern NSString * const OMRONActivityBriskWalkingStepsPerDay;               // Early Walking Step / Day Walking Step Waiting Time (Time Sharing)
extern NSString * const OMRONActivityAscendingStairsStepsPerDay;            // Step up stairs / day stairs up step count (time division)
extern NSString * const OMRONActivityAscendingStairsStepsPerDayForSum;      // Step up stairs / day (for display summary processing
extern NSString * const OMRONActivityNormalStepsPerDay;                     // Normal steps / day steps (time division)
extern NSString * const OMRONActivityJoggingStepsPerDay;                    // Jogging steps / firmly step count (time division)
extern NSString * const OMRONActivityFastStepsPerDay;                       // Fast number/day EX number (divided)
extern NSString * const OMRONActivityCaloriesPerDay;                        // Calories burned / Calories burned day (time division)
extern NSString * const OMRONActivityWalkingCaloriesPerDay;                 // Calorie walk calories / day walk calories (time division)
extern NSString * const OMRONActivityActivityCaloriesPerDay;                // Activity calories / day activities calories (time division)
extern NSString * const OMRONActivityMediumAndHighActivityCaloriesPerDay;   // Middle / High Strength Activity Calorie / Japan / China High Strength Activity Calories (Time-Shaped)
extern NSString * const OMRONActivityTotalCaloriesPerDay;                   // Total calorie expenditure / day
extern NSString * const OMRONActivityTargetActivityCalories;                // Target activity calories
extern NSString * const OMRONActivityDistancePerDay;                        // Distance/day distance (divided)
extern NSString * const OMRONActivityEquippingFlag;                         // Wearing flag
extern NSString * const OMRONActivityNotRecordedFlag;                       // Unrecorded flag (time division)
extern NSString * const OMRONActivityAmountFatBurnedPerDay;                 // Fat burning amount / day fat burning amount (time division)
extern NSString * const OMRONActivityAmountExPerDay;                        // EX amount/day EX amount (time division)
extern NSString * const OMRONActivityAmountExWalkingPerDay;                 // EX amount (歩 line) / day EX amount (歩 line) (time division)
extern NSString * const OMRONActivityBasalMetabolism;                       // Basal metabolism
extern NSString * const OMRONActivityActivityTimeSedentary;                 // Active time (sedentary)
extern NSString * const OMRONActivityActivityTimeLowIntensity;              // Activity time (low intensity)
extern NSString * const OMRONActivityActivityTimeModerateIntensity;         // Activity time (medium intensity)
extern NSString * const OMRONActivityActivityTimeHighIntensity;             // Active time (high intensity)
extern NSString * const OMRONActivityExerciseIntensity;                     // Exercise intensity (time division)
extern NSString * const OMRONActivityKindOfExercises;                       // Exercise type (time division)

// Measurements for individual Activity data type
extern NSString * const OMRONActivityDataStartDateKey;                      // Measurement Start Date Key (UTC Time)
extern NSString * const OMRONActivityDataEndDateKey;                        // Measurement End Date Key (UTC Time)
extern NSString * const OMRONActivityDataMeasurementKey;                    // Measurement Key
extern NSString * const OMRONActivityDataSequenceKey;                       // Sequence Number Key
extern NSString * const OMRONActivityDataDividedDataKey;                    // Time Division Vital Data Key

// Details of Divided data in Activity types
extern NSString * const OMRONActivityDividedDataStartDateKey;               // Time Division Measurement Start Date Key (UTC Time)
extern NSString * const OMRONActivityDividedDataMeasurementKey;             // Time Division Measurement
extern NSString * const OMRONActivityDividedDataPeriodTimeKey;              // Time Division Measurement Time (period, second)
extern NSString * const OMRONActivityDividedDataMeasurementDetailsKey;      // Detailed Time Division Vital Data

#pragma mark - Sleep Data Keys

/* OMRON Connectivity Library Sleep Data Keys */
extern NSString * const OMRONVitalDataSleepKey;                         // Sleep Data Key

// Measurements
extern NSString * const OMRONSleepDataStartDateKey;                     // Measurement Start Date Key (UTC Time)
extern NSString * const OMRONSleepDataEndDateKey;                       // Measurement End Date Key (UTC Time)
extern NSString * const OMRONSleepDataUserIdKey;                        // User Id Key

extern NSString * const OMRONSleepTimeInBedKey;                         // Sleep start time
extern NSString * const OMRONSleepSleepOnsetTimeKey;                    // Sleep time
extern NSString * const OMRONSleepWakeTimeKey;                          // Get up time
extern NSString * const OMRONSleepTotalSleepTimeKey;                    // Sleep time (minutes)
extern NSString * const OMRONSleepSleepEfficiencyKey;                   // Sleep efficiency (%)
extern NSString * const OMRONSleepArousalDuringSleepTimeKey;            // Middle awakening time (minutes)
extern NSString * const OMRONSleepBodyMotionLevelKey;                   // Body movement level
extern NSString * const OMRONSleepWakeupModeKey;                        // Sleep Wake up mode
extern NSString * const OMRONSleepAchievementRateKey;                   // Sleep Achievement Rate
extern NSString * const OMRONSleepTargetTimeKey;                        // Target Sleep Time
extern NSString * const OMRONSleepTimeDifferenceKey;                    // Time difference
extern NSString * const OMRONSleepDataSequenceKey;                      // Sequence Number

// Body movement level Detailed Item
typedef enum {
    OMRONSleepBodyMotionLevelDetailItemOffset = 0,          // OffSet (minutes)
    OMRONSleepBodyMotionLevelDetailItemPeriodTime = 1,      // Period (minutes)
    OMRONSleepBodyMotionLevelDetailItemMeasurement = 2      // Measurement 0 : Level 0, 1 : Level 1, 2 : Level 2, 3: Not measured
} OMRONSleepBodyMotionLevelDetailItem;

#pragma mark - Record Data Keys

/* OMRON Connectivity Library Records Data Keys */
extern NSString * const OMRONVitalDataRecordKey;            // Records Key

extern NSString * const OMRONRecordDataDateKey;             // Recorded Date
extern NSString * const OMRONRecordDataTimeDifferenceKey;   // Time difference
extern NSString * const OMRONRecordDataSequenceKey;         // Sequence Number
extern NSString * const OMRONRecordDataUserIdKey;         // User Id Key

#pragma mark - Weight Data Keys

/* OMRON Connectivity Library Weight Data Keys */
extern NSString * const OMRONVitalDataWeightKey;                               // Weight Key

// Measurements
extern NSString * const OMRONWeightDataStartDateKey;                           // Measurement Start Date Key (UTC Time)
extern NSString * const OMRONWeightDataSequenceKey;                            // Sequence Number
extern NSString * const OMRONWeightDataUserIdKey;                              // User Id Key

extern NSString * const OMRONWeightKey;                                        // Weight Key
extern NSString * const OMRONWeightLbsKey;                                     // Weight in Lbs
extern NSString * const OMRONWeightBodyFatLevelClassificationKey;              // Body Fat Level Classification Key
extern NSString * const OMRONWeightBodyFatPercentageKey;                       // Body Fat Percentage Key
extern NSString * const OMRONWeightRestingMetabolismKey;                       // Resting Metabolism Key
extern NSString * const OMRONWeightSkeletalMusclePercentageKey;                // Skeletal Muscle Percentage Key
extern NSString * const OMRONWeightBMIKey;                                     // BMI Key
extern NSString * const OMRONWeightBodyAgeKey;                                 // Body Age Key
extern NSString * const OMRONWeightVisceralFatLevelKey;                        // Visceral Fat Level Key
extern NSString * const OMRONWeightVisceralFatLevelClassificationKey;          // Visceral Fat Level Classification Key
extern NSString * const OMRONWeightSkeletalMuscleLevelClassificationKey;       // Skeletal Muscle Level Classification Key

#pragma mark - Wheeze Data Keys

/* OMRON Connectivity Library Wheeze Data Keys */
extern NSString * const OMRONVitalDataWheezeKey;                               // Wheeze Key

// Measurements
extern NSString * const OMRONWheezeDataStartDateKey;                           // Measurement Start Date Key (UTC Time)
extern NSString * const OMRONWheezeDataSequenceKey;                            // Sequence Number
extern NSString * const OMRONWheezeDataUserIdKey;                              // User Id Key

extern NSString * const OMRONWheezeKey;                                        // Wheeze Key [0: Detected, 1: Not detected, 2: Measurement error]
extern NSString * const OMRONWheezeErrorNoiseKey;                              // Wheeze Excessive Noise Error Key [0: Not Error, 1: Error]
extern NSString * const OMRONWheezeErrorDecreaseBreathingSoundLevelKey;        // Wheeze Decrease in breathing sound Error Key [0: Not Error, 1: Error]
extern NSString * const OMRONWheezeErrorSurroundingNoiseKey;                   // Wheeze Environmental Noise Error Key [0: Not Error, 1: Error]

// OMRONWheezeKey - Wheeze Reading Measurement
typedef enum {
    OMRONWheezeTypeDetected,                // Wheeze Detected
    OMRONWheezeTypeUndetected,              // Wheeze Not detected
    OMRONWheezeTypeError                    // Error
} OMRONWheezeTypeKey;

// OMRONWheezeErrorNoiseKey/OMRONWheezeErrorDecreaseBreathingSoundLevelKey/OMRONWheezeErrorSurroundingNoiseKey - Error or No error measurement
typedef enum {
    OMRONWheezeErrorTypeNo,                 // Wheeze Error not found
    OMRONWheezeErrorTypeYes                 // Wheeze Error found
} OMRONWheezeErrorTypeKey;

#pragma mark - Pulse Oximeter Data Keys

/* OMRON Connectivity Library Pulse Oximeter Data Keys */
extern NSString * const OMRONVitalDataPulseOximeterKey;                        // Pulse Oximeter Key

// Measurements
extern NSString * const OMRONPulseOximeterDataStartDateKey;                    // Measurement Start Date Key (UTC Time)
extern NSString * const OMRONPulseOximeterDataSequenceKey;                     // Sequence Number
extern NSString * const OMRONPulseOximeterDataUserIdKey;                       // User Id Key

extern NSString * const OMRONPulseOximeterSPO2LevelKey;                        // Blood oxygen level
extern NSString * const OMRONPulseOximeterPulseRateKey;                        // Pulse rate
extern NSString * const OMRONPulseOximeterAmplitudeKey;                        // Pulse Amplitude Index
extern NSString * const OMRONPulseOximeterMeasurementSupportFieldKey;          // Measurement States Support field
extern NSString * const OMRONPulseOximeterSensorStatusKey;                     // Device and Sensor Status Support field

#pragma mark - Temperature Data Keys

/* OMRON Connectivity Library Temperature Data Keys */
extern NSString * const OMRONVitalDataTemperatureKey;                          // Temperature Key

// Measurements
extern NSString * const OMRONTemperatureDataStartDateKey;                      // Measurement Start Date Key (UTC Time)
extern NSString * const OMRONTemperatureDataSequenceKey;                       // Sequence Number
extern NSString * const OMRONTemperatureDataUserIdKey;                         // User Id Key

extern NSString * const OMRONTemperatureKey;                                   // Temperature value Key (LCD display accuracy)
extern NSString * const OMRONTemperatureCelsiusKey;                            // Temperature value in Celsius Key
extern NSString * const OMRONTemperatureUnitKey;                               // Temperature Unit Key
extern NSString * const OMRONTemperatureLevelKey;                              // Temperature Level Key [1 : High, 0 : Low]
extern NSString * const OMRONTemperatureDeviceModelKey;                        // Temperature Device model Key [1 : MC-280B]

// OMRONTemperatureUnitKey - Temperature Unit
typedef enum {
    OMRONTemperatureUnitTypeCelsius,             // Celsius
    OMRONTemperatureUnitTypeFahrenheit           // Fahrenheit
} OMRONTemperatureUnitTypeKey;

// OMRONTemperatureLevelKey - Temperature Level
typedef enum {
    OMRONTemperatureLevelTypeLow,                // Low Temperature
    OMRONTemperatureLevelTypeHigh                // High Temperature
} OMRONTemperatureLevelTypeKey;

// OMRONTemperatureDeviceModelKey - Device model
typedef enum {
    OMRONTemperatureDeviceModelTypeMC280B = 1    // MC-280B
} OMRONTemperatureDeviceModelTypeKey;

// Temperature Device Model Unique Identifiers
extern NSString * const OMRONThermometerMC280B;                                // MC-280B Device LocalName

#pragma mark - DEVICE UPDATING CONFIGURATIONS

/******************************************************************************************************/
/*************************************** PERSONAL SETTINGS ********************************************/
/******************************************************************************************************/

extern NSString * const OMRONDevicePersonalSettingsKey;
extern NSString * const OMRONDevicePersonalSettingsUserHeightKey;       // User Height
extern NSString * const OMRONDevicePersonalSettingsUserWeightKey;       // User Weight
extern NSString * const OMRONDevicePersonalSettingsUserStrideKey;       // User Stride
extern NSString * const OMRONDevicePersonalSettingsTargetStepsKey;      // User Target Number of Steps (1000～99999)
extern NSString * const OMRONDevicePersonalSettingsTargetSleepKey;      // User Target Sleep (0～1440)
extern NSString * const OMRONDevicePersonalSettingsUserDateOfBirthKey;  // User Date of birth (YYYYMMDD format)
extern NSString * const OMRONDevicePersonalSettingsUserGenderKey;       // User Gender

// Gender Types
typedef enum {
    OMRONDevicePersonalSettingsUserGenderTypeFemale = 0,             // Female
    OMRONDevicePersonalSettingsUserGenderTypeMale = 1,               // Male
} OMRONDevicePersonalSettingsUserGenderType;

/*********************************** PERSONAL SETTINGS (Blood Pressure) ****************************************/
extern NSString * const OMRONDevicePersonalSettingsBloodPressureKey;      // User Blood Pressure Settings

extern NSString * const OMRONDevicePersonalSettingsBloodPressureDCIKey;   // Blood Pressure settings increment key to determine device update required or not
extern int const OMRONDevicePersonalSettingsBloodPressureDCINotAvailable; // DCI value when not available (-1)

/*************************************** BLOOD PRESSURE MONITOR SETTINGS ***********************************************/

extern NSString * const OMRONDevicePersonalSettingsBloodPressureTruReadEnableKey;   // BloodPressure Device TruRead Enable Key
extern NSString * const OMRONDevicePersonalSettingsBloodPressureTruReadIntervalKey; // BloodPressure Device TruRead Interval Key (seconds)

// TruRead OFF or ON
typedef enum {
    OMRONDevicePersonalSettingsBloodPressureTruReadOff,
    OMRONDevicePersonalSettingsBloodPressureTruReadOn
} OMRONDevicePersonalSettingsBloodPressureTruReadStatus;

// TruRead Interval
typedef enum {
    OMRONDevicePersonalSettingsBloodPressureTruReadInterval15,                      // 15 seconds interval
    OMRONDevicePersonalSettingsBloodPressureTruReadInterval30,                      // 30 seconds interval
    OMRONDevicePersonalSettingsBloodPressureTruReadInterval60,                      // 60 seconds interval
    OMRONDevicePersonalSettingsBloodPressureTruReadInterval120                      // 120 seconds interval
} OMRONDevicePersonalSettingsBloodPressureTruReadInterval;


/*********************************** PERSONAL SETTINGS (Weight) ****************************************/
extern NSString * const OMRONDevicePersonalSettingsWeightKey;                                   // User Weight Settings

extern NSString * const OMRONDevicePersonalSettingsWeightDCIKey;                                // Weight settings increment key to determine device update required or not
extern int const OMRONDevicePersonalSettingsWeightDCINotAvailable;                              // DCI value when not available (-1)

/*************************************** WEIGHT MONITOR SETTINGS (ready only) ***********************************************/

extern NSString * const OMRONDevicePersonalSettingsWeightDisplayPriorityBodyFatKey;             // Body Fat Percentage Display Priority
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayPriorityVisceralFatLevelKey;    // Visceral Fat Level Display Priority
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayPrioritySkeletalMuscleLevelKey; // Skeletal Muscle Level Display Priority
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayPriorityRestingMetabolismKey;   // Resting Metabolism Display Priority
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayPriorityBMIKey;                 // BMI Display Priority
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayPriorityBodyAgeKey;             // Body Age Display Priority

extern NSString * const OMRONDevicePersonalSettingsWeightDisplayEnableBodyFatKey;               // Body Fat Display Key
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayEnableVisceralFatLevelKey;      // Visceral Fat Level Display Key
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayEnableSkeletalMuscleLevelKey;   // Skeletal Muscle Level Display key
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayEnableRestingMetabolismKey;     // Resting Metabolism Display Key
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayEnableBMIKey;                   // BMI Display Key
extern NSString * const OMRONDevicePersonalSettingsWeightDisplayEnableBodyAgeKey;               // Body Age Display Key

// Display priority levels
typedef enum {
    OMRONDevicePersonalSettingsWeightDisplayPriorityOne = 1,             // One
    OMRONDevicePersonalSettingsWeightDisplayPriorityTwo = 2,             // Two
    OMRONDevicePersonalSettingsWeightDisplayPriorityThree = 3,           // Three
    OMRONDevicePersonalSettingsWeightDisplayPriorityFour = 4,            // Four
    OMRONDevicePersonalSettingsWeightDisplayPriorityFive = 5,            // Five
    OMRONDevicePersonalSettingsWeightDisplayPrioritySix  = 6             // Six
} OMRONDevicePersonalSettingsWeightDisplayPriority;

/******************************************************************************************************/
/*************************************** DEVICE SETTINGS **********************************************/
/******************************************************************************************************/

extern NSString * const OMRONDeviceSettingsKey;                     // Device Settings
extern NSString * const OMRONDeviceSettingsAvailableUsersKey;       // Available Users in Device Key
extern NSString * const OMRONDeviceSettingsRegisteredUsersKey;      // Registered Users in Device Key
extern NSString * const OMRONDeviceSettingsLastSequenceNumbersKey;  // Last data transfer sequence numbers for user numbers in device

/*************************************** ALARM SETTINGS ***********************************************/

extern NSString * const OMRONDeviceAlarmSettingsKey;                // Device Alarm Settings Key
extern NSString * const OMRONDeviceAlarmSettingsTimeKey;            // Device Alarm Time Key
extern NSString * const OMRONDeviceAlarmSettingsDaysKey;            // Device Alarm Day Key
extern NSString * const OMRONDeviceAlarmSettingsTypeKey;            // Device Alarm Type Key

extern NSString * const OMRONDeviceAlarmSettingsHourKey;            // Device Alarm Hour Key
extern NSString * const OMRONDeviceAlarmSettingsMinuteKey;          // Device Alarm Minute Key

extern NSString * const OMRONDeviceAlarmSettingsDaySundayKey;       // Device Alarm Sunday Key
extern NSString * const OMRONDeviceAlarmSettingsDayMondayKey;       // Device Alarm Monday Key
extern NSString * const OMRONDeviceAlarmSettingsDayTuesdayKey;      // Device Alarm Tuesday Key
extern NSString * const OMRONDeviceAlarmSettingsDayWednesdayKey;    // Device Alarm Wednesday Key
extern NSString * const OMRONDeviceAlarmSettingsDayThursdayKey;     // Device Alarm Thursday Key
extern NSString * const OMRONDeviceAlarmSettingsDayFridayKey;       // Device Alarm Friday Key
extern NSString * const OMRONDeviceAlarmSettingsDaySaturdayKey;     // Device Alarm Saturday Key

// Alarm setting OFF or ON
typedef enum {
    OMRONDeviceAlarmStatusOff,
    OMRONDeviceAlarmStatusOn
} OMRONDeviceAlarmStatus;

// Type of Alarm setting in device
typedef enum {
    OMRONDeviceAlarmTypeNormal,
    OMRONDeviceAlarmTypeMeasure,
    OMRONDeviceAlarmTypeMedication,
    OMRONDeviceAlarmTypeNone
} OMRONDeviceAlarmType;

/*************************************** SLEEP SETTINGS *********************************************/

extern NSString * const OMRONDeviceSleepSettingsKey;                        // Device Sleep Settings Key
extern NSString * const OMRONDeviceSleepSettingsAutomaticKey;               // Device Sleep Automatic Settings Key
extern NSString * const OMRONDeviceSleepSettingsAutomaticStartTimeKey;      // Device Sleep Automatic Start Time Key
extern NSString * const OMRONDeviceSleepSettingsAutomaticStopTimeKey;       // Device Sleep Automatic Stop Time Key

// Automatic Sleep Settings
typedef enum {
    OMRONDeviceSleepAutomaticOff,                      // OFF
    OMRONDeviceSleepAutomaticOn                        // ON
} OMRONDeviceSleepAutomatic;


/*************************************** TIME SETTINGS *********************************************/

extern NSString * const OMRONDeviceTimeSettingsKey;
extern NSString * const OMRONDeviceTimeSettingsFormatKey;

// Time Format
typedef enum {
    OMRONDeviceTimeFormat24Hour,                      // 24 Hour Format
    OMRONDeviceTimeFormat12Hour                       // 12 Hour Fromat
} OMRONDeviceTimeFormat;

/*************************************** DATE SETTINGS *********************************************/

extern NSString * const OMRONDeviceDateSettingsKey;
extern NSString * const OMRONDeviceDateSettingsFormatKey;

// Date Format
typedef enum {
    OMRONDeviceDateFormatMonthDay,                    // MM/DD Date Format
    OMRONDeviceDateFormatDayMonth                     // DD/MM Date Format
} OMRONDeviceDateFormat;

/*************************************** DISTANCE SETTINGS ************************************************/

extern NSString * const OMRONDeviceDistanceSettingsKey;
extern NSString * const OMRONDeviceDistanceSettingsUnitKey;

// Distance Unit
typedef enum {
    OMRONDeviceDistanceUnitKilometer,               // In Kiometers
    OMRONDeviceDistanceUnitMile                     // In Miles
} OMRONDeviceDistanceUnit;


/*************************************** NOTIFICATION SETTINGS ***********************************************/

extern NSString * const OMRONDeviceNotificationSettingsKey;

extern NSString * const OMRONDeviceNotificationEnableSettingsKey; // Device Notification enable settings key
extern NSString * const OMRONDeviceNotificationStatusKey;         // Device Notification status key

// Notification Settings
typedef enum {
    OMRONDeviceNotificationStatusOff,                      // OFF
    OMRONDeviceNotificationStatusOn                        // ON
} OMRONDeviceNotificationStatus;


/*************************************** Weight SETTINGS *********************************************/

/* OMRON Connectivity Library Weight Data Keys */

extern NSString * const OMRONDeviceWeightSettingsKey;
extern NSString * const OMRONDeviceWeightSettingsUnitKey;
extern NSString * const OMRONDeviceWeightSettingsOneTimeMeasurementKey;
extern NSString * const OMRONDeviceWeightSettingsWeightOnlyKey;

// Weight settings display OFF or ON
typedef enum {
    OMRONDeviceWeightDisplayOff,
    OMRONDeviceWeightDisplayOn
} OMRONDeviceWeightDisplay;

// Weight Unit
typedef enum {
    OMRONDeviceWeightUnitKg,          // In Kilograms
    OMRONDeviceWeightUnitLbs,         // In Lbs
    OMRONDeviceWeightUnitSt           // In St
} OMRONDeviceWeightUnit;

// Weight Only setting for BCM
typedef enum {
    OMRONDeviceWeightOnlyOff,          // All BCM data settings
    OMRONDeviceWeightOnlyOn,           // Weight only settings
} OMRONDeviceWeightOnlyUnit;

// One time measurement setting for BCM device
typedef enum {
    OMRONDeviceWeightOneTimeMeasurementOff,          // One time measurement OFF
    OMRONDeviceWeightOneTimeMeasurementOn,           // One time measurement ON
} OMRONDeviceWeightOneTimeMeasurement;

/*************************************** iBEACON SETTINGS ************************************************/

extern NSString * const OMRONDeviceiBeaconSettingsKey;


/*************************************** DEVICE TRANSFER SETTINGS ***********************************/

extern NSString * const OMRONDeviceTransferSettingsKey;     // Device Transfer Settings

extern NSString * const OMRONDeviceTransferSettingsModeKey; // Device Transfer Mode

// Type of device transfer settings
typedef enum {
    OMRONDeviceTransferSettingsModePairing,             // Device transfer mode checking pairing state
    OMRONDeviceTransferSettingsModeMismatchSequence,    // Device transfer mode checking sequence number mismatch
    OMRONDeviceTransferSettingsModeInvalidTime          // Device transfer mode checking invalid time set
} OMRONDeviceTransferSettingsMode;

/******************************************************************************************************/
/*************************************** DEVICE INFORMATION *******************************************/
/******************************************************************************************************/

/* OMRON Connectivity Library Device Information Keys */
extern NSString * const OMRONDeviceInformationIdentityNameKey;      // Device Identity
extern NSString * const OMRONDeviceInformationCategoryKey;          // Device Category
extern NSString * const OMRONDeviceInformationDisplayNameKey;       // Device Display Name
extern NSString * const OMRONDeviceInformationLocalNameKey;         // Device Local Name Key
extern NSString * const OMRONDeviceInformationUUIDKey;              // Device UUID Key
extern NSString * const OMRONDeviceInformationSerialIdKey;          // Device Serial Id
extern NSString * const OMRONDeviceInformationiBeaconProximityUUIDKey;          // Device iBeacon Proximity UUID
extern NSString * const OMRONDeviceInformationiBeaconMajorValueKey;              // Device iBeacon Major Value
extern NSString * const OMRONDeviceInformationiBeaconMinorValueKey;              // Device iBeacon Minor Value


#pragma mark - BLUETOOTH

/******************************************************************************************************/
/*************************************** BLUETOOTH DEVICE STATE ***************************************/
/******************************************************************************************************/

typedef NS_ENUM(NSUInteger, OMRONBLEConnectionState) {
    OMRONBLEConnectionStateUnknown,         // Connection Unknown State
    OMRONBLEConnectionStateScanning,        // Connection Scanning State
    OMRONBLEConnectionStateConnecting,      // Connection Connecting State
    OMRONBLEConnectionStateConnected,       // Connection Connected State
    OMRONBLEConnectionStateDisconnecting,   // Connection Disconnecting State
    OMRONBLEConnectionStateDisconnect       // Connection Disconnected State
};

/******************************************************************************************************/
/*************************************** BLUETOOTH CONNECTION STATE ***********************************/
/******************************************************************************************************/

typedef NS_ENUM(NSUInteger, OMRONBLEBluetoothState) {
    OMRONBLEBluetoothStateUnknown,      // Bluetooth Unknown State
    OMRONBLEBluetoothStateOff,          // Bluetooth OFF State
    OMRONBLEBluetoothStateOn,           // Bluetooth ON State
    OMRONBLEBluetoothStateUnauthorized  // Bluetooth Unauthorized State by the application
};

/******************************************************************************************************/
/*************************************** Bluetooth Error **********************************************/
/******************************************************************************************************/

enum OMRONBLEError {
    OMRONBLEErrorSuccess                    = 0,
    OMRONBLEErrorAddressTooLong             = 6003, // Address provisions bit more
    OMRONBLEErrorDataSizeTooLong            = 6004, // Data size is greater than or equal to the prescribed
    OMRONBLEErrorInvalidBCC                 = 6005, // Failure to error determination at BCC
    OMRONBLEErrorInvalidCommand             = 6006, // Command code error
    OMRONBLEErrorInvalidFrameLength         = 6007, // Actually differ FrameLength returned from the equipment
    OMRONBLEErrorInvalidAccess              = 6008, // And access to inaccessible memory of equipment
    OMRONBLEErrorCommunicationBusy          = 6009, // Errors for multiple concurrent request (block transfer can not be executed simultaneously)
    OMRONBLEErrorAuthenticationError        = 6012, // Authentication error (hardware error)
    OMRONBLEErrorErrorNotSupported          = 6015, // CoreBluetooth Not Compatible
    OMRONBLEErrorNoneAvailable              = 6016, // CoreBluetooth Not Available or Powered OFF
    OMRONBLEErrorUnauthorized               = 60161, // CoreBluetooth Unauthorized by the app
    OMRONBLEErrorIllegalCall                = 6017, // The occurrence of call of illegal methods in certain method execution
    OMRONBLEErrorIllegalArgument            = 6018, // Long user identification information, a long bit length, etc
    OMRONBLEErrorDisconnected               = 6019, // Unintentional disconnection occurs
    OMRONBLEErrorDuplicateCall              = 6020, // Duplication method invocation
    OMRONBLEErrorAuthenticationFailed       = 6021, // Authentication Error (Authentication Failure)
    OMRONBLEErrorAuthenticationRejected     = 6022, // User "Registration" error (not the first communication mode based; constant name because it may have been used in the upper layer does not change)
    OMRONBLEErrorEncryptionUserCancelled    = 6024, // Encryption failure due to user cancellation
    OMRONBLEErrorPlainDataCommunication     = 6025, // Communication error due to unencrypted
    OMRONBLEErrorTimeout                    = 6032, // Timeout
    OMRONBLEErrorDeviceUnreachable          = 6035, // There is no UUID equipment trying to connect
    OMRONBLEErrorDeviceBusy                 = 6036, // Task request busy
    OMRONBLEErrorUnknownTask                = 6037, // Task code that does not request arrives at the Finish
    OMRONBLEErrorInvalidParity              = 6038, // Parity check error (have done with the value of the memory rather than the communication)
    OMRONBLEErrorProtocol                   = 6039, // Protocol error
    OMRONBLEErrorDefinitionNotLoaded        = 6040, // Instrument definition file is not loaded
    OMRONBLEErrorDefinitionNotFound         = 6041, // We did not find the value of the specified key in the device definition file
    OMRONBLEErrorInvalidDefinitionDetected  = 6042, // Unintended information is detected by the device definition file
    OMRONBLEErrorDefinitionConflict         = 6043, // Contradiction has been detected in the device definition file
    OMRONBLEErrorUnknown                    = 6044, // Equipment error can not be determined in the library (if there is such as those of the model-dependent)
    OMRONBLEErrorDateTimeNotSet             = 6045, // Device date and time not set before taking reading. Pairing need to be performed first before taking reading. (STP Specific)
    OMRONBLEErrorParingFailedUnspecified    = 6082, // WL corresponding equipment side of the encrypted information loss (iPhone5)
    OMRONBLEErrorEncryptionKeyLost          = 6083, // WL corresponding equipment side of the encrypted information loss (iPhone4S)
    OMRONBLEErrorEncryptionTimeout          = 6086  // Encryption failure due to time-out
} DEPRECATED_ATTRIBUTE;

#pragma mark - DEVICE CONFIGURATION


/******************************************************************************************************/
/*************************************** DEVICE CATEGORY **********************************************/
/******************************************************************************************************/

typedef NS_ENUM(NSInteger, OMRONBLEDeviceCategory) {
    OMRONBLEDeviceCategoryBloodPressure = 0,        // Blood Pressure Category
    OMRONBLEDeviceCategoryBodyComposition = 1,      // Blood Composition Category
    OMRONBLEDeviceCategoryActivity = 2,             // Activity Category
    OMRONBLEDeviceCategorySleep = 4,                // Sleep Category
    OMRONBLEDeviceCategoryBasal = 5,                // Basal Category
    OMRONBLEDeviceCategoryPulseOximeter = 6,        // Pulse Oximeter Category
    OMRONBLEDeviceCategoryGlucose = 9,              // Glucose Category
    OMRONBLEDeviceCategoryWheeze = 14,              // Wheeze Category
    OMRONBLEDeviceCategoryTemperature = 19          // Temperature Category
};

/******************************************************************************************************/
/*********************************** VITAL DATA TRANSFER CATEGORY *************************************/
/******************************************************************************************************/

typedef NS_ENUM(NSInteger, OMRONVitalDataTransferCategory) {
    OMRONVitalDataTransferCategoryAll = -1,                 // All category
    OMRONVitalDataTransferCategoryBloodPressure = 0,        // Blood Pressure data only
};


/******************************************************************************************************/
/*************************************** DEVICE CONFIGURATION *****************************************/
/********************************** (OmronPeripheralManagerConfig) ************************************/
/******************************************************************************************************/

/* OMRON Connectivity Library Device Configuration Keys */
extern NSString * const OMRONBLEConfigDeviceKey;

extern NSString * const OMRONBLEConfigDeviceModelNameKey;                   // Device Model Name
extern NSString * const OMRONBLEConfigDeviceModelDisplayNameKey;            // Device Display Name
extern NSString * const OMRONBLEConfigDeviceModelSeriesKey;                 // Device Series
extern NSString * const OMRONBLEConfigDeviceUsersKey;                       // No of users available in device memory
extern NSString * const OMRONBLEConfigDeviceCategoryKey;                    // Device Category like Blood Pressure, Activity
extern NSString * const OMRONBLEConfigDeviceGroupIDKey;                     // Device Category Type
extern NSString * const OMRONBLEConfigDeviceGroupIncludedGroupIDKey;        // Device Model Type
extern NSString * const OMRONBLEConfigDeviceIdentifierKey;                  // Device Identifier / Product Code
extern NSString * const OMRONBLEConfigDeviceProtocolKey;                    // Device Communication Protocol Standard - OMRONDeviceProtocol
extern NSString * const OMRONBLEConfigDeviceImageKey;                       // Device image
extern NSString * const OMRONBLEConfigDeviceThumbnailKey;                   // Device thumbnail image

// DEVICE CONNECTION PROTOCOL
typedef enum {
    OMRONWLPProtocol = 0,       // Omron Proprietary BLE Protocol
    OMRONSTPProtocol,           // Bluetooth Standard BLP Protocol
    OMRONAudioProtocol          // Omron Audio Protocol
} OMRONDeviceProtocol;

/******************************************************************************************************/
/********************************* Configuration File Status ******************************************/
/******************************************************************************************************/

typedef enum {
    OMRONConfigurationPartnerAuthenticationError = 6000,    // Partner Not Authenticated
    OMRONConfigurationFileSuccess = 7000,                   // Configuration File Success
    OMRONConfigurationFileError = 7001,                     // Configuration File Error
    OMRONConfigurationFileUpdateError = 7002,               // Configuration File Update Failure
    OMRONConfigurationMissingParameterError = 8000,         // Setting Configuration Error
    OMRONConfigurationUnsupportedParameterError = 8001,     // Setting Parameter not supported
    OMRONConfigurationUserHashMissingParameterError = 8002, // User Hash Parameter Missing Error
    OMRONConfigurationUnsupportedDeviceError = 8003,        // Unsupported Device
    OMRONConfigurationUserMismatchError = 9000              // User Mismatch Error
} OMRONConfigurationStatus;

/******************************************************************************************************/
/*************************************** BLE Connection Keys ******************************************/
/******************************************************************************************************/

extern NSString * const OMRONBLEDevicePeripheralKey;                // Peripheral Key
extern NSString * const OMRONBLEDeviceGroupIDKey;                   // Equipment Classification ID Key
extern NSString * const OMRONBLEDeviceGroupIncludedGroupIDKey;      // Equipment within the Classification ID Key
extern NSString * const OMRONBLEDevicePeripheralUUIDKey;            // Peripheral UUID Key
extern NSString * const OMRONBLEDeviceLocalNameKey;                 // Local Name Key
extern NSString * const OMRONBLEDevicePeripheralRSSIKey;            // Peripheral RSSI Key
extern NSString * const OMRONBLEDevicePeripheralCommunicatorKey;    // Peripheral Communicatory Key
extern NSString * const OMRONBLEDevicePeripheralAdverisementDataKey;// Peripheral Advertisement Data Key


