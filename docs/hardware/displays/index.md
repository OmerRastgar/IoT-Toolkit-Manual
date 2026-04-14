# Displays Overview

The IoT Toolkit includes two display options for local data visualization.

## Display Types

| Display | Type | Resolution | Interface | Use Case |
|---------|------|------------|-----------|----------|
| [LCD](lcd.md) | Character | 16x2 or 20x4 | I2C | Simple text output |
| [TFT](tft.md) | Color Graphic | 128x160 or 240x320 | SPI | Visual data/charts |

## Comparison

| Feature | LCD | TFT |
|---------|-----|-----|
| Power | Low (~10mA) | Medium (~50mA) |
| Complexity | Simple | Advanced |
| Graphics | Text only | Colors, images, charts |
| Cost | Lower | Higher |
| Visibility | Good | Excellent |

## When to Use Each

### LCD Display
- Battery-powered projects
- Simple status messages
- Outdoor/bright environments
- Cost-sensitive applications

### TFT Display
- Data visualization
- Graphs and charts
- User interfaces
- Indoor monitoring stations

## Wiring

Both displays connect to ESP32:

### LCD (I2C)
```
LCD            ESP32
---            -----
VCC      -->   3.3V
GND      -->   GND
SDA      -->   GPIO21
SCL      -->   GPIO22
```

### TFT (SPI)
```
TFT            ESP32
---            -----
VCC      -->   3.3V
GND      -->   GND
SCK      -->   GPIO18
MISO     -->   GPIO19
MOSI     -->   GPIO23
CS       -->   GPIO5
DC       -->   <!-- TODO: Add -->
RST      -->   <!-- TODO: Add -->
```

## Quick Start

1. Set up [LCD Display](lcd.md)
2. Set up [TFT Display](tft.md)
3. Integrate with [sensors data](../sensors/index.md)

!!! tip "Using Both Displays"
    You can use both displays simultaneously - LCD for quick status and TFT for detailed visualization.
