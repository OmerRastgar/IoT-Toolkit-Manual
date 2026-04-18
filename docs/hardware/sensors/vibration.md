# Vibration/Accelerometer Sensor

<!-- TODO: Extract all content from Copy of IoT Kit - Tehqiq.md -->

## Overview

Vibration is detected using either an **ADXL335** (analog) or **MPU6050** (I2C) accelerometer. The toolkit measures rapid changes in acceleration to identify vibration events.

![Vibration Sensor](../../assets/images/toolkit/adxl-vibration sensor.jpg)

## Sensors Options

- **ADXL335**: Analog 3-axis accelerometer (requires ADC pins).
- **MPU6050**: Digital I2C 3-axis accelerometer and gyroscope (highly recommended).

## Specifications (MPU6050)

| Parameter | Value |
|-----------|-------|
| Model | MPU6050 |
| Interface | I2C |
| Voltage | 3V - 5V |
| Range | ±2g, ±4g, ±8g, ±16g |


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
// Vibration Sensor Test Code
// TODO: Add actual code from source file

#include <Wire.h>

void setup() {
  Serial.begin(115200);
  Wire.begin();
  
  // TODO: Add sensor initialization
}

void loop() {
  // TODO: Add sensor reading code
  
  delay(100);
}
```

## Required Libraries

<!-- TODO: Add library names from source -->

## Testing

### Verification Steps

1. Upload code to ESP32
2. Open Serial Monitor (115200 baud)
3. Shake the sensor gently
4. Expected output:
   ```
   <!-- TODO: Add expected output from source -->
   ```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Sensor not detected | Check I2C address, verify wiring |
| No change when moving | Verify proper initialization |
| <!-- TODO: Add --> | <!-- TODO: Add --> |

## Next Steps

- Test [Acoustic Sensor](acoustic.md)
- Proceed to [full integration](../../integration/index.md)
