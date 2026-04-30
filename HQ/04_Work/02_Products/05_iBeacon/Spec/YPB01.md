# YPB01

## Page 1

BeaconPlus
Model: E7
Datasheet V1.2

| Part # | Description |
| --- | --- |
| E7-6002A | 204760002, BeaconPlus with accelerometer, Bluetooth 5.0, pre-flashed MiniBeacon Plus software supports broadcasting iBeacon, Eddystone and sensor data simultaneously; |
| E7-6003A | 204760003, BeaconPlus without accelerometer, Bluetooth 5.0, pre-flashed MiniBeacon Plus software supports broadcasting iBeacon and Eddystone simultaneously; |

## Page 2

The BeaconPlus E7 is a new generation beacon that loaded Bluetooth 5.0 hardware platform and
MiniBeacon Plus intelligence software that advertises standard iBeacon, Eddystone (UID, URL, TLM)
simultaneously. E7 has a smart rotatable mechanical design for the housing that makes the coin battery
replaceable and IP67 waterproof grade combination perfectly.
It is attached to objects by double-sided adhesive for indoor location, activity monitoring, asset tracking etc.
so as to realize the remote data management. And it is able to configure the BeaconPlus E7 via
configuration app BeaconSET+ to different parameters so that to meet different applications.
Moreover, E7 BeaconPlus supports the accelerometer advertising sensor data ONLY when an object (E7
attached) is moving or after an object has fallen.
FEATURE
- IP67 waterproof;
- Replaceable coin battery 1000mAh
- Advertising iBeacon & Eddystone &Sensor data
- Unique MAC address (ITU)
- Bluetooth 5.0 chipset nRF52 series
- The max. 100 meters advertising distance
- Internal power ON/OFF push button
E7 BeaconPlus
APPLICATION
- Indoor location
- Retail promotion
- Activity monitoring
- Inventory tracking
ACCESSORY
- Double side adhesive tape
CONFIGURATION TOOL
- BeaconSET+ (IOS & Android)

## Page 3

ACTIVATE E7
- Clockwisely open the rotatable housing, press “push button” and keep holding on 3 seconds;
The blue LED lights on 5 seconds and then off, the BeaconPlus E7 has been activated on;
- Press “push button” and keep holding on 3 seconds; The blue LED blinks 5 seconds and then off, the
BeaconPlus E7 has been turned off;
CERTIFICATION
- iBeacon MFi License (iBC-14-00582)
- FCC Regulation (FCC Part 15.)
- CE Regulations (Included EN300328/301489/60950/62479)
ELECTRONIC PARAMETER
PARAMETER SETTING
Each E7 BeaconPlus has been pre-configured in the factory before the shipment. Here below is given the
main parameters and default settings.

### Table 1

| Item | Value | Remarks |
| --- | --- | --- |
| Case Color | white | Other colors can be customized |
| Battery Model | 1 x CR2477 | 3.0V, 1000mAh |
| Operation Voltage | 1.8-3.9V | DC |
| Transmission Current | 5.3mA (peak current) | Tested at 0dBm transmission power |
| Transmission Range | 100 meters | Maximum |
| Waterproof level | IP67 | Tested at 1 meter water |
| Antenna | 50ohm | On board / PCB Antenna |
| Size | Φ39 x 15.5mm | 39mm diameter, 15.5mm height |

### Table 2

| Type | Item | Default Settings |
| --- | --- | --- |
| iBeacon | UUID (16 bytes) | E2C56DB5-DFFB-48D2-B060-D0F5A71096E0 (Proximity) |
|  | Major (2 bytes) | 0 |
|  | Minor (2 bytes) | 0 |
| Eddystone | Instance ID @UID | Random (6 bytes) |
|  | Namespace ID @UID | Random (10 bytes) |
|  | URL | https://www.minewtech.com |
| Base Parameters | Measured Power | -59 (0xC5) |
|  | Radio Tx power | 6 (0dBm) |
|  | Adv. Interval | 9(900mS) |
|  | Beacon ID | Random(Usually will be the beacon’s MAC ID). |
|  | Beacon Name | PLUS |

## Page 4

TECHNICAL DOCUMENT
PACKING INFORMATION
Firmware Flash
1. J-LINK Programmer Kit;
2. Programming ports definition;
Please contact MINEW sales team to ask more related information if needed.
DECLARATION
The contents of this datasheet are subject to change without prior notice for further improvement. Minew
team reserves the right to explain all the terms of this datasheet.

### Table 1

| col1 | Connectable | Yes (it is configuration mode) |
| --- | --- | --- |
|  | Password | minew123 (Allowing only 8 characters) |
| Acc Sensor | x-axis | 1. It depends on beacon’s real status, static ormovement 2. Only working when beacon with accelerometersensor |
|  | y-axis |  |
|  | z-axis |  |
| Extra Function | Reset factory | Available |
|  | Power off | Available |
|  | Modify password | Available |
|  | Remove password | Available |
|  | Update firmware | Available |

### Table 2

| Item | Version | File Name | Date |
| --- | --- | --- | --- |
| Datasheet | V1.1 | E7 BeaconPlus Datasheet | 8th May, 2018 |
| Instruction | V1.1 | E7 BeaconPlus Configuration Instruction | 8th May, 2018 |
| SDK | V1.0 | Both iOS and Android | 28th December, 2017 |

### Table 3

| Details | Box | Carton |
| --- | --- | --- |
| Quantity (E7) | 20pcs | 200pcs |
| Net Weight | 0.4Kg | 4.0Kg |
| Gross Weight | 0.5Kg | 5.7Kg |
| Size | 31 x 11 x 8 cm | 32 x 23 x 40 cm |
