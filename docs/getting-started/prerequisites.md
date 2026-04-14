# Prerequisites

Before you begin assembling the IoT Toolkit, ensure you have the following tools and software installed.

## Required Software

### Arduino IDE
The Arduino IDE is required for programming the ESP32.

- **Download**: [arduino.cc/en/software](https://www.arduino.cc/en/software)
- **Version**: 2.0 or later recommended
- **Installation**: Follow the installer instructions for your operating system

### ESP32 Board Support
After installing Arduino IDE, add ESP32 board support:

1. Open Arduino IDE
2. Go to **File** > **Preferences**
3. Add to Additional Boards Manager URLs:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
4. Go to **Tools** > **Board** > **Boards Manager**
5. Search for "ESP32" and install "ESP32 by Espressif Systems"

### USB Drivers

#### Windows
Install CP210x or CH340 drivers depending on your ESP32 board:
- CP210x: [Silicon Labs Drivers](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers)
- CH340: Usually auto-installs or available from manufacturer

#### macOS
Drivers are typically not required for macOS 10.15+, but may need to approve the device in Security settings.

#### Linux
Add your user to the `dialout` group:
```bash
sudo usermod -a -G dialout $USER
```

## Required Hardware Tools

### Basic Tools
- USB cable (USB-A to USB-C or USB-A to Micro-USB, depending on ESP32 board)
- Breadboard or prototyping board
- Jumper wires (male-to-male, male-to-female, female-to-female)
- Wire strippers (optional but helpful)
- Multimeter (for troubleshooting)

### Soldering (Optional)
For permanent installations:
- Soldering iron
- Solder wire (rosin-core, 0.8mm)
- Helping hands or PCB holder
- Desoldering wick (for corrections)

## Knowledge Prerequisites

### Recommended Skills
- Basic electronics concepts (voltage, current, circuits)
- Familiarity with programming concepts (variables, functions, loops)
- Understanding of serial communication basics
- Basic computer file management

### Helpful but Not Required
- Previous Arduino experience
- Knowledge of networking protocols (WiFi, TCP/IP)
- Database basics

## Verify Your Setup

### Test Arduino IDE
1. Open Arduino IDE
2. Select **Tools** > **Board** > **ESP32 Arduino** > **ESP32 Dev Module**
3. Select your COM port (Tools > Port)
4. Try uploading a simple example:
   - File > Examples > 01.Basics > Blink
   - Click Upload button

### Test ESP32 Connection
After uploading, open Serial Monitor (Tools > Serial Monitor) and set baud rate to 115200. You should see ESP32 boot messages.

!!! success "Ready to proceed?"
    If you can upload code to ESP32, you're ready to continue to the [Hardware List](hardware-list.md)!

!!! warning "Troubleshooting"
    If you encounter issues, check the [Troubleshooting](../troubleshooting/index.md) section.
