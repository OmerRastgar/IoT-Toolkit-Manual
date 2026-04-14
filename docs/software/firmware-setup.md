# Firmware Setup

Setting up Arduino IDE for ESP32 development.

## Install Arduino IDE

### Download
- **Website**: [arduino.cc/en/software](https://www.arduino.cc/en/software)
- **Version**: 2.0 or later recommended
- **Platforms**: Windows, macOS, Linux

### Installation
1. Download installer for your OS
2. Run installer and follow prompts
3. Launch Arduino IDE

## Add ESP32 Board Support

### Step 1: Add Board Manager URL

1. Open Arduino IDE
2. Go to **File** > **Preferences** (or **Arduino** > **Preferences** on macOS)
3. Find "Additional Boards Manager URLs" field
4. Add this URL:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
5. Click **OK**

### Step 2: Install ESP32 Package

1. Go to **Tools** > **Board** > **Boards Manager**
2. Search for "ESP32"
3. Find "ESP32 by Espressif Systems"
4. Click **Install**
5. Wait for installation to complete

## Configure Board Settings

### Select Board

1. Go to **Tools** > **Board** > **ESP32 Arduino**
2. Select **ESP32 Dev Module**
   
   Alternative options:
   - ESP32 Wrover Module
   - ESP32S2 Dev Module
   - NodeMCU-32S

### Port Selection

1. Connect ESP32 via USB
2. Install drivers if needed (see below)
3. Go to **Tools** > **Port**
4. Select the COM port (Windows) or /dev/ttyUSB0 (Linux)

### Upload Settings

Configure these settings for optimal performance:

| Setting | Recommended Value | Description |
|---------|------------------|-------------|
| Upload Speed | 921600 | Maximum upload speed |
| CPU Frequency | 240MHz | Maximum performance |
| Flash Frequency | 80MHz | Fast flash access |
| Flash Mode | QIO | Quad I/O mode |
| Flash Size | 4MB | Standard flash |
| Partition Scheme | Default 4MB | Standard partition |

## Install USB Drivers

### Windows

#### CP210x (Silicon Labs)
1. Download from [Silicon Labs](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers)
2. Run installer
3. Restart if prompted

#### CH340
- Usually auto-installs
- If not, download from manufacturer website

### macOS
- Drivers usually not required for macOS 10.15+
- May need to approve in **System Preferences** > **Security & Privacy**

### Linux

Add user to `dialout` group:
```bash
sudo usermod -a -G dialout $USER
```

Log out and back in for changes to take effect.

## Test Upload

### Blink Sketch

1. Open example: **File** > **Examples** > **01.Basics** > **Blink**
2. Modify LED pin (ESP32 uses GPIO2 for built-in LED):
   ```cpp
   #define LED_BUILTIN 2
   ```
3. Click **Upload** button (→)
4. Wait for "Done uploading" message

### Serial Monitor Test

1. Open **Tools** > **Serial Monitor**
2. Set baud rate to **115200**
3. Press **Reset** button on ESP32
4. Should see boot messages:
   ```
   rst:0x1 (POWERON_RESET),boot:0x13 (SPI_FAST_FLASH_BOOT)
   ...
   ```

## Troubleshooting

### Upload Failed

| Error | Solution |
|-------|----------|
| "Failed to connect" | Hold BOOT button, press RESET, release BOOT |
| "Wrong boot mode" | GPIO0 must be LOW during upload |
| "A fatal error occurred" | Check USB cable, try different port |
| "Permission denied" | Check drivers (Linux: add to dialout group) |

### Port Not Found

1. Check USB cable (must be data cable, not charge-only)
2. Try different USB port
3. Install/update drivers
4. Restart computer

### Compilation Errors

1. Update ESP32 board package
2. Check library compatibility
3. Verify correct board selected

## Arduino IDE 2.x Features

### Useful Features
- **Serial Monitor**: Built-in with timestamp option
- **Board Manager**: Easier library management
- **Debugger**: Advanced debugging (select boards)
- **Auto-complete**: Code suggestions

### Recommended Settings

**File** > **Preferences**:
- Show verbose output during: ☐ compilation ☐ upload
- Editor language: English
- Editor font size: 12
- Interface scale: Auto

## Next Steps

1. Install [required libraries](libraries.md)
2. Upload [test code](code-examples.md)
3. Proceed to [hardware setup](../hardware/index.md)
