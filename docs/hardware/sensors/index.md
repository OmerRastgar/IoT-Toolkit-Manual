# Sensors Overview

The IoT Toolkit includes four environmental sensors for comprehensive data collection.

## Sensor Types

| Sensor | Measures | Application |
|--------|----------|-------------|
| [Temperature](temperature.md) | Ambient temperature | Environmental monitoring |
| [Humidity](humidity.md) | Relative humidity | Climate analysis |
| [Vibration](vibration.md) | Motion/Acceleration | Machine health monitoring |
| [Acoustic](acoustic.md) | Sound levels | Noise monitoring |

## Common Characteristics

<!-- TODO: Extract common sensor specs from source file -->

| Feature | Typical Spec |
|---------|-------------|
| Interface | I2C |
| Voltage | 3.3V |
| Current | <10mA |
| Sampling Rate | 1-10 Hz |

## I2C Addressing

Multiple sensors share the I2C bus. Check each sensor's default address:

| Sensor | Default I2C Address |
|--------|-------------------|
| Temperature | <!-- TODO: Add --> |
| Humidity | <!-- TODO: Add --> |
| Vibration | <!-- TODO: Add --> |
| Acoustic | <!-- TODO: Add --> |

!!! tip "Address Conflicts"
    If sensors share the same I2C address, use the [I2C multiplexer](../modules/i2c-multiplexer.md) to resolve conflicts.

## Wiring

All I2C sensors connect to ESP32:

```
ESP32          Sensor(s)
-----          --------
3.3V    ---->  VCC
GND     ---->  GND
GPIO21  ---->  SDA (I2C Data)
GPIO22  ---->  SCL (I2C Clock)
```

## Quick Start

Start with individual sensor guides:

1. [Temperature Sensor](temperature.md)
2. [Humidity Sensor](humidity.md)
3. [Vibration Sensor](vibration.md)
4. [Acoustic Sensor](acoustic.md)

Then proceed to [integration](../../integration/index.md) for combined operation.
