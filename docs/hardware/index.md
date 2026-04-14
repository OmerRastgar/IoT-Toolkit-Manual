# Hardware Overview

This section covers all hardware components in the IoT Toolkit.

## Components

### Core
- [ESP32](esp32.md) - WiFi-enabled microcontroller

### Sensors
- [Temperature Sensor](sensors/temperature.md)
- [Humidity Sensor](sensors/humidity.md)
- [Vibration Sensor](sensors/vibration.md)
- [Acoustic Sensor](sensors/acoustic.md)

### Displays
- [LCD Display](displays/lcd.md)
- [TFT Display](displays/tft.md)

### Modules
- [I2C Multiplexer](modules/i2c-multiplexer.md)
- [Voice Module](modules/voice.md)
- [Camera Module](modules/camera.md)

### Communication
- [MQTT](communication/mqtt.md)
- [HTTP](communication/http.md)
- [CoAP](communication/coap.md)

### Connections
- [Wiring Diagrams](wiring-diagrams.md)

## Quick Reference

| Component | Interface | Voltage | Purpose |
|-----------|-----------|---------|---------|
| ESP32 | WiFi | 3.3V | Main controller |
| Temperature | I2C | 3.3V | Ambient temp |
| Humidity | I2C | 3.3V | Relative humidity |
| Vibration | I2C | 3.3V | Motion detection |
| Acoustic | I2C | 3.3V | Sound detection |
| LCD | I2C | 3.3V | Text display |
| TFT | SPI | 3.3V | Color display |
| I2C Multiplexer | I2C | 3.3V | Address management |
| Voice Module | I2C/UART | 3.3V | Audio output |
| Camera | Special | 3.3V | Image capture |

## Getting Started

New to the hardware? Start with the [ESP32 setup guide](esp32.md) before connecting other components.
