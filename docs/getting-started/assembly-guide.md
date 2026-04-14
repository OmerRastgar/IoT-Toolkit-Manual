# Assembly Guide

Step-by-step guide to assembling your IoT Toolkit hardware.

## Overview

This guide will walk you through connecting the ESP32 microcontroller with all sensors, displays, and modules. Follow the steps in order for best results.

## Prerequisites

Before starting assembly:
- Complete the [Hardware List](hardware-list.md) checklist
- Set up [Prerequisites](prerequisites.md) (software and drivers)
- Have a clean, static-free workspace
- Prepare your breadboard and jumper wires

## Step 1: ESP32 Basic Setup

### 1.1 Place ESP32 on Breadboard
1. Position the ESP32 across the center divider of the breadboard
2. Align pins so GND, 3.3V, and GPIO pins are accessible
3. Ensure the board is seated firmly

### 1.2 Power Connections
Connect ESP32 power rails to breadboard:

| ESP32 Pin | Breadboard Connection |
|-----------|---------------------|
| 3.3V | Red power rail (+) |
| GND | Blue power rail (-) |

!!! warning "Do NOT use 5V"
    ESP32 GPIO pins are 3.3V tolerant. Using 5V will damage the board.

### 1.3 Verify Power
1. Connect USB cable to ESP32
2. Check that power LED on ESP32 lights up
3. Open Arduino IDE Serial Monitor (115200 baud)
4. You should see boot messages

## Step 2: I2C Multiplexer Setup

The I2C multiplexer resolves address conflicts when multiple devices share the I2C bus.

### 2.1 I2C Multiplexer Wiring

<!-- TODO: Extract specific multiplexer wiring from source file -->

| Multiplexer Pin | ESP32 Pin | Connection |
|-----------------|-----------|------------|
| VCC | 3.3V | Power |
| GND | GND | Ground |
| SDA | GPIO21 | I2C Data |
| SCL | GPIO22 | I2C Clock |

### 2.2 Test Multiplexer
<!-- TODO: Add test code from source file -->

## Step 3: Sensor Connections

### 3.1 Temperature Sensor

<!-- TODO: Extract temperature sensor wiring from source file -->

| Sensor Pin | Connection | Notes |
|------------|-----------|-------|
| VCC | 3.3V | Power |
| GND | GND | Ground |
| SDA | <!-- TODO: Add --> | I2C Data |
| SCL | <!-- TODO: Add --> | I2C Clock |

### 3.2 Humidity Sensor

<!-- TODO: Extract humidity sensor wiring from source file -->

### 3.3 Vibration Sensor

<!-- TODO: Extract vibration sensor wiring from source file -->

### 3.4 Acoustic Sensor

<!-- TODO: Extract acoustic sensor wiring from source file -->

## Step 4: Display Connections

### 4.1 LCD Display

<!-- TODO: Extract LCD wiring from source file -->

### 4.2 TFT Display

<!-- TODO: Extract TFT wiring from source file -->

## Step 5: Module Connections

### 5.1 Voice Module

<!-- TODO: Extract voice module wiring from source file -->

### 5.2 Camera Module

<!-- TODO: Extract camera module wiring from source file -->

## Complete Wiring Diagram

<!-- TODO: Add complete wiring diagram when available -->

```
ESP32 DevKit
    |
    |-- 3.3V --> Power Rail (+)
    |-- GND  --> Power Rail (-)
    |
    |-- GPIO21 (SDA) --> I2C Bus
    |-- GPIO22 (SCL) --> I2C Bus
    |
    |-- [Sensor Connections]
    |-- [Display Connections]
    |-- [Module Connections]
```

## Testing the Assembly

### Test 1: Power-Up Test
1. Connect USB to ESP32
2. Verify all status LEDs on sensors/displays
3. Check for any burning smell or heat

### Test 2: I2C Scan
Upload I2C scanner sketch to detect connected devices:

```cpp
#include <Wire.h>

void setup() {
  Wire.begin();
  Serial.begin(115200);
  Serial.println("\nI2C Scanner");
}

void loop() {
  byte error, address;
  int nDevices = 0;
  
  Serial.println("Scanning...");
  
  for(address = 1; address < 127; address++) {
    Wire.beginTransmission(address);
    error = Wire.endTransmission();
    
    if (error == 0) {
      Serial.print("I2C device found at address 0x");
      if (address < 16) Serial.print("0");
      Serial.print(address, HEX);
      Serial.println();
      nDevices++;
    }
  }
  
  if (nDevices == 0) {
    Serial.println("No I2C devices found\n");
  } else {
    Serial.println("done\n");
  }
  
  delay(5000);
}
```

Expected output should show detected I2C addresses for your sensors.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| ESP32 not detected | Check USB cable and driver installation |
| No I2C devices found | Check SDA/SCL wiring, verify power to sensors |
| Sensor returns 0 or null | Verify correct I2C address, check library |
| Display blank | Check contrast/brightness, verify wiring |

## Next Steps

After successful assembly:

1. Test individual sensors: [Sensor Documentation](../hardware/sensors/index.md)
2. Set up displays: [Display Guide](../hardware/displays/index.md)
3. Configure cloud connection: [Cloud Setup](../cloud/index.md)

!!! success "Assembly Complete!"
    If all tests pass, you're ready to start programming!
