# Humidity Sensor

<!-- TODO: Extract all content from Copy of IoT Kit - Tehqiq.md -->

## Overview

The humidity and temperature sensors in this toolkit are combined into a single **DHT (Digital Humidity and Temperature)** sensor module. 

![DHT11 and DHT22 Sensors](../../assets/images/toolkit/DHT11-and-DHT22-Sensors.jpg)

## DHT Versions

The toolkit utilizes either the **DHT11** or **DHT22** sensor. While they look similar, they have different specifications:

| Feature | DHT11 (Blue) | DHT22 (White) |
|---------|--------------|---------------|
| **Humidity Range** | 20% to 80% | 0% to 100% |
| **Humidity Accuracy** | ±5% | ±2-5% |
| **Temperature Range** | 0°C to 50°C | -40°C to 80°C |
| **Sampling Rate** | 1 Hz | 0.5 Hz |

## Specifications

| Parameter | Value |
|-----------|-------|
| Model | DHT11 / DHT22 |
| Interface | Single-bus Digital |
| Operating Voltage | 3.3V - 5V |


## Pinout

<!-- TODO: Add pinout diagram from source -->

| Pin | Function | ESP32 Connection |
|-----|----------|-----------------|
| VCC | Power | 3.3V |
| GND | Ground | GND |
| SDA | I2C Data | GPIO21 |
| SCL | I2C Clock | GPIO22 |

## Wiring Diagram

<!-- TODO: Add wiring diagram -->

## Code Example

<!-- TODO: Extract test code from source file -->

```cpp
// Humidity Sensor Test Code
// TODO: Add actual code from source file

#include <Wire.h>

void setup() {
  Serial.begin(115200);
  Wire.begin();
  
  // TODO: Add sensor initialization
}

void loop() {
  // TODO: Add sensor reading code
  
  delay(1000);
}
```

## Required Libraries

<!-- TODO: Add library names from source -->

## Testing

### Verification Steps

1. Upload code to ESP32
2. Open Serial Monitor (115200 baud)
3. Expected output:
   ```
   <!-- TODO: Add expected output from source -->
   ```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Sensor not detected | Check I2C address, verify wiring |
| <!-- TODO: Add --> | <!-- TODO: Add --> |

## Next Steps

- Test [Vibration Sensor](vibration.md)
- Proceed to [full integration](../../integration/index.md)
