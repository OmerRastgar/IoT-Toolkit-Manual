# Hardware List

Complete list of all components required for the IoT Toolkit.

## Core Components

### Microcontroller
| Component | Model/Type | Purpose | Qty |
|-----------|-----------|---------|-----|
| ESP32 DevKit | ESP32-WROOM-32 | Main WiFi-enabled microcontroller | 1 |

### Sensors
<!-- TODO: Extract specific sensor models from Copy of IoT Kit - Tehqiq.md -->

| Sensor Type | Model | Interface | Voltage | Qty |
|-------------|-------|-----------|---------|-----|
| Temperature | <!-- TODO: Add model --> | I2C/SPI | 3.3V/5V | 1 |
| Humidity | <!-- TODO: Add model --> | I2C/SPI | 3.3V/5V | 1 |
| Vibration/Accelerometer | <!-- TODO: Add model --> | I2C/SPI | 3.3V/5V | 1 |
| Acoustic/Sound | <!-- TODO: Add model --> | I2C/Analog | 3.3V/5V | 1 |

### Displays
<!-- TODO: Extract specific display models from source file -->

| Display Type | Model | Interface | Size | Qty |
|--------------|-------|-----------|------|-----|
| LCD | <!-- TODO: Add model --> | I2C/Parallel | 16x2 or 20x4 | 1 |
| TFT | <!-- TODO: Add model --> | SPI | 1.8" or 2.4" | 1 |

### Additional Modules
<!-- TODO: Extract specific module details from source file -->

| Module | Model | Interface | Purpose | Qty |
|--------|-------|-----------|---------|-----|
| I2C Multiplexer | TCA9548A or similar | I2C | Resolve address conflicts | 1 |
| Voice Module | <!-- TODO: Add model --> | I2C/UART | Audio output/alerts | 1 |
| Camera Module | OV2640 or ESP32-CAM | Specialized | Image capture | 1 |

## Connectivity

| Component | Type | Purpose | Qty |
|-----------|------|---------|-----|
| USB Cable | USB-A to USB-C/Micro | Power and programming | 1 |
| Breadboard | 830 tie points | Prototyping | 1-2 |
| Jumper Wires | M-M, M-F, F-F | Connections | Assorted pack |

## Power Supply

| Component | Specifications | Purpose | Qty |
|-----------|----------------|---------|-----|
| USB Power Adapter | 5V, 2A minimum | Power via USB | 1 |
| Power Bank | 5V, 2A output | Portable power (optional) | 1 |

## Optional Accessories

| Component | Purpose | Qty |
|-----------|---------|-----|
| Enclosure/Case | Protection and mounting | 1 |
| Mounting Screws | Hardware mounting | Assorted |
| Cable Ties | Cable management | Pack |

## Where to Buy

### Recommended Suppliers
- **Amazon**: General components, fast shipping
- **AliExpress**: Cost-effective for bulk orders
- **Adafruit**: Quality sensors and modules
- **SparkFun**: Educational components
- **Banggood**: Budget-friendly options

### ESP32 Variants
Common ESP32 boards that work with this toolkit:
- ESP32 DevKit V1 (30-pin)
- ESP32 DevKit C (38-pin)
- ESP32-WROOM-32 based boards

!!! tip "Choosing an ESP32"
    Any ESP32 with at least 30 pins should work. Boards with more pins (38-pin) offer more GPIO options for expansion.

!!! warning "Voltage Levels"
    ESP32 operates at 3.3V logic. Ensure sensors are 3.3V compatible or use level shifters.

## Checklist

Before starting assembly, verify you have:

- [ ] ESP32 DevKit
- [ ] Temperature sensor
- [ ] Humidity sensor
- [ ] Vibration sensor
- [ ] Acoustic sensor
- [ ] LCD display
- [ ] TFT display
- [ ] I2C multiplexer
- [ ] Voice module
- [ ] Camera module
- [ ] Breadboard
- [ ] Jumper wires (variety pack)
- [ ] USB cable

## Next Step

Once you have all components, proceed to the [Assembly Guide](assembly-guide.md).
