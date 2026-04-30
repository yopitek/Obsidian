# YPB05

## Page 1

C3 USB Beacon
Datasheet V2.2

| Model | Description |
| --- | --- |
| C3-B | Black casing, micro USB Bluetooth® 5.0 Beacon, advertises iBeacon & Eddystone simultaneously, CE &FCC, RoHS |
| C3-W | White casing, micro USB Bluetooth® 5.0 Beacon, advertises iBeacon & Eddystone simultaneously, CE&FCC, RoHS |

## Page 2

The Micro USB Beacon C3 is a Bluetooth® LE 5.0 beacon device which advertises iBeacon and Eddystone
simultaneously; it is powered by the micro USB slot, accurate hardware and robust firmware. It is designed
for the commercial advertising and indoor location-based service.
Minew Beacons broadcast 2.4GHz radio signals at regular and adjustable intervals. MiniBeacon can be
heard and interpreted by iOS and Android Bluetooth® LE-enabled devices that are equipped with many
mobileapps.
FEATURES
- Programmed MiniBeacon Plus standardfirmware
- Micro USB;
- The max. 50 meters advertisingdistance
- Ultra-low power consumption chipset nRF52series
- Plug and play;
C3 Micro USB Beacon
CERTIFICATIONS
Image 1
- iBeacon MFi License (iBC-14-00582)
- Bluetooth® EPL Certification
- FCC Regulation (FCC Part 15.)
- CE Regulations (Included EN300328/301489/60950/62479)
SPECIFICATION
Compatibility Configurable Parameters
- Supported iOS 9.0+ and Android5.0+; - UUID, Major, Minor, Passwordetc.
- Compatible with Apple iBeaconTMstandard; - Configuration APP BeaconSET+;
- Compatible with all Bluetooth® LE 5.0 devices;
Transmission Power Levels
No Battery Needed
- 8 adjustable levels, range from 0 to7
- No battery needed, powered by USBslot; - Transmission power range: -40dBm to +4dBm;
Soft Reboot Long Range
- Reboot the device via command without anytools; - The max. Range 50 meters in the openspace;
- The range depends on the physicalenvironment;
OTA and J-Link
Security
- Supported upgrade via Over-The-Air;
- Reserved J-Link port on theboard forprogramming; - 8 characters password (Lock/Unlockparameters);
- Broadcast the encrypted data if needed;
Connection Mode
- AES HW encryption
- Advertising mode, non-connectable;
Easy to Deployment
- Configuration mode, connectable;
- Plug and play;

## Page 3

CONFIGURABLE PARAMETERS
ELECTRONIC PARAMETERS
TECHNICAL SUPPORT
* Minew sales team will send you these documents after the sample arrived.

### Table 1

| Type | Item | Default Settings |
| --- | --- | --- |
| iBeacon | UUID (16 bytes) | E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 (Proximity) |
|  | Major (2 bytes) | 0 |
|  | Minor (2 bytes) | 0 |
| Eddystone | Instance ID @UID | random (10 bytes) |
|  | Namespace ID @UID | random (6 bytes) |
|  | URL | https://www.minew.com |
| Base Parameters | Measured Power | -59 (0xC5) |
|  | Radio Tx power | 7 (4dBm) |
|  | Adv. Interval | 9(900mS) |
|  | Beacon ID | random, it is the MAC address of beacon. |
|  | Beacon Name | C3 |
|  | Connectable | yes (it is configuration mode) |
|  | Password | minew123 (8 characters only) |
| Extra Function | Reset factory | Available |
|  | Modify password | available |
|  | Remove password | available |
|  | Update firmware | available |

### Table 2

| Item | Value | Remarks |
| --- | --- | --- |
| Case Color | White, Black | Other colors can be customized |
| Battery Model | Null | Powered by USB slot |
| Operation Voltage | 4.5-5.5V | DC |
| Transmission Circuit | 5.3mA (Max.) | Tested at 0dBm transmission power |
| Transmission Range | 50 meters | Maximum |
| Antenna | 50ohm | On board / PCB Antenna |
| Net Weight | 2.0g | With battery but without package |
| Size | 18 x 14 x 6 mm | Null |

### Table 3

| Item | Version | File Name | Date |
| --- | --- | --- | --- |
| Datasheet | V2.0 | Micro USB Beacon Datasheet | 30thMay, 2019 |
| Instruction | V1.0 | MiniBeacon Plus Configuration Instruction | 5thMarch, 2018 |
| SDK | V2.0 | Both iOS and Android | 18thMay, 2018 |
