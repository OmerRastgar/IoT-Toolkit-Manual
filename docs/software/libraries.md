# Required Libraries

Libraries required for the IoT Toolkit.

## Core Libraries

### WiFi (Built-in)
```cpp
#include <WiFi.h>
```
- **Source**: Included with ESP32 board support
- **Purpose**: WiFi connectivity
- **Required**: Yes

### Wire (Built-in)
```cpp
#include <Wire.h>
```
- **Source**: Arduino core
- **Purpose**: I2C communication
- **Required**: Yes

### SPI (Built-in)
```cpp
#include <SPI.h>
```
- **Source**: Arduino core
- **Purpose**: SPI communication
- **Required**: Yes (for TFT display)

## Sensor Libraries

<!-- TODO: Extract specific libraries from source file -->

### Temperature Sensor
```cpp
// TODO: Add library name
#include <???.h>
```
- **Install**: Arduino Library Manager
- **Search**: <!-- TODO: Add -->

### Humidity Sensor
```cpp
// TODO: Add library name
#include <???.h>
```
- **Install**: Arduino Library Manager
- **Search**: <!-- TODO: Add -->

### Vibration/Accelerometer
```cpp
// TODO: Add library name
#include <???.h>
```
- **Install**: Arduino Library Manager
- **Search**: <!-- TODO: Add -->

### Acoustic Sensor
```cpp
// TODO: Add library name
#include <???.h>
```
- **Install**: Arduino Library Manager
- **Search**: <!-- TODO: Add -->

## Display Libraries

### LCD (I2C)
```cpp
#include <LiquidCrystal_I2C.h>
```
- **Install**: Arduino Library Manager
- **Search**: "LiquidCrystal I2C"
- **Author**: Frank de Brabander
- **Purpose**: I2C LCD control

### TFT Display
```cpp
// TODO: Add specific library
#include <???.h>
```
Options:
- `Adafruit_ST7735` - for ST7735-based displays
- `Adafruit_ILI9341` - for ILI9341-based displays
- `TFT_eSPI` - Universal TFT library (recommended)

**Install TFT_eSPI**:
1. Arduino Library Manager
2. Search: "TFT_eSPI"
3. Author: Bodmer
4. Click Install

## Communication Libraries

### MQTT
```cpp
#include <PubSubClient.h>
```
- **Install**: Arduino Library Manager
- **Search**: "PubSubClient"
- **Author**: Nick O'Leary
- **Purpose**: MQTT client

### HTTP
Built-in with ESP32:
```cpp
#include <HTTPClient.h>
```

### CoAP
```cpp
#include <coap-simple.h>
```
- **Install**: Arduino Library Manager
- **Search**: "coap-simple"
- **Purpose**: CoAP client

### WiFiClientSecure (for TLS)
```cpp
#include <WiFiClientSecure.h>
```
- **Source**: Built-in with ESP32

## JSON Processing

### ArduinoJson
```cpp
#include <ArduinoJson.h>
```
- **Install**: Arduino Library Manager
- **Search**: "ArduinoJson"
- **Author**: Benoit Blanchon
- **Version**: 6.x recommended
- **Purpose**: JSON encoding/decoding

## Installation Guide

### Method 1: Library Manager (Recommended)

1. Open Arduino IDE
2. Go to **Sketch** > **Include Library** > **Manage Libraries**
3. Search for library name
4. Select library and version
5. Click **Install**

### Method 2: ZIP File

1. Download library as ZIP
2. Arduino IDE: **Sketch** > **Include Library** > **Add .ZIP Library**
3. Select downloaded ZIP file

### Method 3: Manual Installation

1. Download and extract library
2. Copy to Arduino libraries folder:
   - Windows: `Documents\Arduino\libraries\`
   - macOS: `~/Documents/Arduino/libraries/`
   - Linux: `~/Arduino/libraries/`
3. Restart Arduino IDE

## Library Verification

### Check Installed Libraries

Arduino IDE: **Sketch** > **Include Library**

Or check libraries folder:
```
Documents/Arduino/libraries/
├── Adafruit_GFX_Library
├── ArduinoJson
├── LiquidCrystal_I2C
├── PubSubClient
├── TFT_eSPI
└── ...
```

### Test Include

Create a test sketch:

```cpp
// Test all includes
#include <WiFi.h>
#include <Wire.h>
#include <SPI.h>
#include <LiquidCrystal_I2C.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>

void setup() {
  Serial.begin(115200);
  Serial.println("All libraries loaded successfully!");
}

void loop() {
  // Empty
}
```

Compile (Ctrl+R) to verify all libraries are found.

## Complete Library List

| Library | Version | Required | Install Source |
|---------|---------|----------|----------------|
| WiFi | Built-in | Yes | ESP32 core |
| Wire | Built-in | Yes | ESP32 core |
| SPI | Built-in | Yes | ESP32 core |
| HTTPClient | Built-in | Yes | ESP32 core |
| WiFiClientSecure | Built-in | Optional | ESP32 core |
| LiquidCrystal_I2C | Latest | Yes | Library Manager |
| TFT_eSPI | Latest | Yes | Library Manager |
| PubSubClient | Latest | Yes (MQTT) | Library Manager |
| ArduinoJson | 6.x | Recommended | Library Manager |
| <!-- TODO: Add --> | <!-- TODO: Add --> | <!-- TODO: Add --> | <!-- TODO: Add --> |

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Library not found | Verify correct name, check installation |
| Version conflict | Install specific version via Library Manager |
| Multiple versions | Remove old versions from libraries folder |
| Compilation errors | Update to latest library version |

## Library Updates

### Check for Updates

1. **Tools** > **Manage Libraries**
2. Look for "Updateable" filter
3. Select libraries to update
4. Click **Update**

### Keep Updated

Regularly update libraries for:
- Bug fixes
- New features
- Security patches

## Next Steps

- View [code examples](code-examples.md)
- Set up [hardware components](../hardware/index.md)
- Proceed to [integration](../integration/index.md)
