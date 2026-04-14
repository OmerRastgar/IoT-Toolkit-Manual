# Hardware Troubleshooting

Solutions for hardware-related issues.

## I2C Issues

### Sensor Not Detected

**Symptoms**: I2C scanner shows no devices or wrong addresses

**Checks**:
1. Wiring
   ```
   Verify: SDA → GPIO21
           SCL → GPIO22
           VCC → 3.3V
           GND → GND
   ```

2. Pull-up resistors
   - I2C requires 4.7kΩ pull-up resistors on SDA and SCL
   - Many modules include them, but not all
   - Add external resistors if needed:
   ```
   3.3V ─[4.7kΩ]─┬── SDA (GPIO21)
                 │
   3.3V ─[4.7kΩ]─┴── SCL (GPIO22)
   ```

3. Power
   - Measure voltage at sensor VCC (should be 3.3V)
   - Check for loose breadboard connections
   - Try different breadboard rows

4. I2C Address
   - Some sensors have configurable addresses
   - Check datasheet for address pins
   - Try scanning all addresses (0x01-0x77)

**Solutions**:
- Rewire with shorter wires
- Add pull-up resistors
- Power cycle everything
- Try different I2C address

### Intermittent I2C Communication

**Symptoms**: Sometimes works, sometimes fails

**Causes**:
- Long wires (keep under 30cm for I2C)
- Noisy power supply
- Signal degradation

**Solutions**:
1. Shorten wires
2. Add 100nF capacitor near sensor VCC/GND
3. Lower I2C speed:
   ```cpp
   Wire.setClock(100000);  // 100kHz instead of 400kHz
   ```
4. Check for interference sources (motors, RF)

## Display Issues

### LCD Blank or Garbled

**Symptoms**: Nothing displays or characters are wrong

**Checks**:
1. Contrast potentiometer
   - Adjust the blue pot on I2C backpack
   - Turn slowly while watching display

2. I2C Address
   - Common: 0x27 or 0x3F
   - Run I2C scanner to verify

3. Backlight
   - Should light up if powered
   - If not: check power connections

4. Initialization
   ```cpp
   lcd.init();        // Don't forget this
   lcd.backlight();   // And this
   ```

**Solutions**:
- Adjust contrast potentiometer
- Verify I2C address (0x27 vs 0x3F)
- Check for solder bridges on backpack
- Try different initialization sequence

### TFT Display Blank

**Symptoms**: Screen doesn't light up

**Checks**:
1. Pin connections
   - SPI: SCK, MISO, MOSI, CS, DC, RST
   - Verify each pin matches code

2. Driver chip
   - ST7735, ILI9341, etc.
   - Must match library initialization

3. Backlight LED
   - Check LED pin connection
   - May need PWM control

**Solutions**:
- Double-check all SPI connections
- Verify correct driver in code
- Check LED pin voltage (should be 3.3V)

## Power Issues

### Brownout Errors

**Symptoms**: `Brownout detector was triggered` in Serial Monitor

**Causes**:
- Insufficient power supply
- USB cable too thin/long
- Too many peripherals

**Solutions**:
1. Use better power supply
   - Minimum 500mA for ESP32 alone
   - 1A+ recommended with sensors

2. Add capacitor
   ```
   100μF electrolytic capacitor:
   + → 3.3V rail
   - → GND rail
   ```

3. Shorten USB cable
4. Power ESP32 separately from sensors

### ESP32 Resets Randomly

**Causes**:
- Watchdog timeout
- Power supply issues
- GPIO conflicts

**Solutions**:
- Add `delay()` or `yield()` in long loops
- Check power supply (see brownout above)
- Don't use GPIO 6-11 (reserved for flash)
- Check for short circuits

## Sensor-Specific Issues

### Temperature Sensor Wrong Readings

**Symptoms**: Impossible values (e.g., -999°C, 1000°C)

**Solutions**:
- Verify I2C address
- Check sensor initialization
- Allow warmup time (30 seconds)
- Check for self-heating (power cycling)

### Humidity Sensor Stuck at 0% or 100%

**Symptoms**: Always same value

**Solutions**:
- Sensor needs calibration
- Check for contamination
- Verify sensor not damaged
- Allow 24 hours to stabilize

### Vibration Sensor Not Responding

**Symptoms**: No change when moving sensor

**Solutions**:
- Check sensitivity settings
- Verify initialization complete
- Test with known-good accelerometer library
- Check for I2C communication

### Acoustic Sensor No Reading

**Symptoms**: Always 0 or constant value

**Solutions**:
- Verify analog vs digital connection
- Check if module requires amplification
- Test with different sound sources
- Check sampling rate

## WiFi Issues

### ESP32 Won't Connect to WiFi

**Symptoms**: Stuck at "Connecting..." or returns error

**Checks**:
1. Credentials
   ```cpp
   // Verify these are correct
   const char* ssid = "YourNetworkName";  // Case sensitive!
   const char* password = "YourPassword"; // Include special chars
   ```

2. Network type
   - Must be 2.4GHz (not 5GHz)
   - ESP32 doesn't support 5GHz

3. Security type
   - WPA2 recommended
   - WEP and WPA may not work

4. Router settings
   - Check MAC filtering
   - Verify DHCP is enabled
   - Check if guest network has restrictions

**Solutions**:
- Double-check SSID and password
- Use 2.4GHz network
- Try different router channel (1, 6, or 11)
- Reset router
- Update ESP32 board support package

### Weak WiFi Signal

**Symptoms**: RSSI below -80 dBm, frequent disconnections

**Solutions**:
- Move ESP32 closer to router
- Use external antenna (if supported)
- Check for interference sources
- Try different WiFi channel

## Physical Connection Issues

### Loose Breadboard Connections

**Symptoms**: Intermittent problems, works when pressed

**Solutions**:
- Check wire seating
- Try different breadboard rows
- Use solid core wire (not stranded)
- Consider soldering for permanent builds

### Bent or Damaged Pins

**Symptoms**: No connection, wrong readings

**Solutions**:
- Check pins with multimeter
- Straighten bent pins carefully
- Use different pins on ESP32
- Replace damaged module

## Testing Tools

### Multimeter Tests

| Test | Setting | Expected | Action if Wrong |
|------|---------|----------|----------------|
| VCC | DCV | 3.3V | Check power supply |
| GND | Continuity | Beep | Find open connection |
| SDA/SCL | DCV | ~3.3V floating | Check pull-ups |

### Logic Analyzer

For advanced debugging:
- Check I2C signal quality
- Verify timing
- Detect noise/interference

## Quick Reference

| Problem | First Check |
|---------|-------------|
| No power | USB cable, power LED |
| I2C fails | Wiring, pull-ups, address |
| Display blank | Contrast, backlight, I2C |
| WiFi fails | Credentials, 2.4GHz, router |
| Brownouts | Power supply, capacitors |
| Random resets | Watchdog, GPIO usage |

## Real-World Troubleshooting Cases

### 1. The Data Interpretation Error (DHT22 vs DHT11)

**The Symptom**: Your temperature was stuck at exactly 1°C.

**The Cause**: You had a DHT22 (white sensor) but the code was configured for a DHT11 (blue sensor).

**The Logic**: Both sensors use a 1-wire protocol, but they format their data differently. The DHT22 sends data in a 16-bit format to allow for decimals (e.g., 25.6°C). When the library treated that high-resolution data as a low-resolution DHT11 signal, the math resulted in a tiny, garbage number like 1°C.

**Fix**: Change `DHT11` to `DHT22` in your code:
```cpp
#define DHTTYPE DHT22  // Was DHT11
```

---

### 2. The Documentation/Code Mismatch (GPIO Pins)

**The Symptom**: Confusion over which pin the DHT was actually on. LCD shows "Pin 12 Active" but sensor not responding.

**The Cause**: Your code comments and LCD print statements said GPIO 12, but your `#define` statement was set to GPIO 14.

**The Logic**: Microcontrollers are literal. Even if you write "Pin 12 Active" on a screen, the processor will only look at the physical pin defined in the code. If those don't match your physical jumper wire, you get NaN (Not a Number) errors because the ESP32 is essentially "listening to a wall."

**Fix**: Ensure all three match:
1. Physical wire connection
2. `#define DHTPIN` value in code
3. LCD display text

---

### 3. The Power & Address Struggle (MPU6050)

**The Symptom**: Frozen readings (x:0.0 y:-47.8) followed by "Failed to find" errors.

**The Cause**: Likely undervoltage or I2C address shifting.

**The Logic**:
- **Voltage**: Many MPU6050 modules have a 3.3V regulator that actually prefers a 5V input. Running them on 3.3V can "starve" the internal MEMS (the tiny mechanical parts), causing them to lock up at maximum values (like -47.8).
- **Address**: By grounding the AD0 pin, you correctly forced the address to 0x68. If that pin floats, the address can jump to 0x69, making the sensor "invisible" to code looking for 0x68.

**Fix**:
- Try 5V power input instead of 3.3V
- Connect AD0 to GND to force address 0x68
- Use I2C scanner to verify address

---

### 4. The Software Crash (Null Pointer / Guru Meditation)

**The Symptom**: The ESP32 rebooted in a loop with a "LoadProhibited" error.

**The Cause**: A Null Pointer Dereference in the loop().

**The Logic**: Your code was asking the MPU library for data (`mpu.getEvent`). However, because the MPU failed to initialize in the `setup()`, the library never created the "map" in memory to find that data. When the code tried to read a memory address that didn't exist, the ESP32 panicked and restarted to protect itself.

**Fix**: Add a check before reading:
```cpp
bool mpuAlive = false;

void setup() {
  if (mpu.begin()) {
    mpuAlive = true;
  }
}

void loop() {
  if (mpuAlive) {
    // Only read if sensor initialized
    mpu.getEvent(&a, &g, &temp);
  }
}
```

---

### 5. The "Delay" Trap

**The Symptom**: Reset button not responding during `delay()` calls.

**The Cause**: `delay(2000)` stops all code execution, making the system "deaf" to button presses.

**Fix**: Use non-blocking timers with `millis()`:
```cpp
unsigned long lastRead = 0;
const unsigned long READ_INTERVAL = 2000;

void loop() {
  if (millis() - lastRead >= READ_INTERVAL) {
    lastRead = millis();
    readSensors();
  }
  // Button can be checked continuously here
  checkResetButton();
}
```

---

### 6. Library & Display Conflicts

**LCD Shows Scrambled Characters (? / < o)**

**The Symptom**: When the MPU was added, the LCD showed garbage characters.

**The Cause**: The MPU tried to run the I2C bus at 400kHz while the LCD could only handle 100kHz.

**Fix**: Force I2C speed before initializing devices:
```cpp
Wire.begin();
Wire.setClock(100000);  // 100kHz for compatibility
```

**Library Mismatch Error**

**The Symptom**: "undefined reference" error in Web Editor.

**The Cause**: IDE picked `LCDBigNumbers` instead of `LiquidCrystal_I2C`.

**Fix**: Explicitly include the correct library:
```cpp
#include <LiquidCrystal_I2C.h>
// Or try LiquidCrystal_PCF8574 as alternative
```

---

### 7. Pin Management & Flashing Errors

**Input-Only Pins (GPIO 35)**

**The Symptom**: DHT sensor not working on Pin 35.

**The Cause**: GPIO 34-39 are input-only pins. The DHT requires bidirectional communication ("handshake").

**Fix**: Use GPIO 0-33 for bidirectional sensors.

**Strapping Pin Conflict (GPIO 12)**

**The Symptom**: "Fatal Error: Status 2" during upload.

**The Cause**: Pin 12 controls the voltage of the internal Flash chip. Adding a pull-up resistor there "fooled" the ESP32 into using the wrong voltage, breaking the flash process.

**Fix**: Avoid using GPIO 12, 6, 7, 8, 9, 10, 11 (reserved for flash).

---

### 8. Serial Monitor Issues

**The "Mojibake" Symbols (garbage characters)**

**The Symptom**: Serial Monitor shows random symbols instead of text.

**The Cause**: Baud rate mismatch. ESP32 sending at 115200, but Serial Monitor listening at 9600.

**Fix**: Set Serial Monitor to match code:
```cpp
Serial.begin(115200);  // Code and Monitor must match!
```

---

### 9. WiFi Manager Blocking

**The Symptom**: LCD stays blank during WiFi setup.

**The Cause**: `wm.autoConnect()` is a "blocking" function that stops all other code execution while waiting for connection.

**Fix**: Use a callback to update the screen:
```cpp
wm.setAPCallback(configModeCallback);

void configModeCallback(WiFiManager *myWiFiManager) {
  lcd.clear();
  lcd.print("Connect to:");
  lcd.setCursor(0,1);
  lcd.print(myWiFiManager->getConfigPortalSSID());
}
```

---

### 10. Sensor Accuracy Issues

**The NaN (Not a Number) Error**

**Causes**:
1. Missing 4.7kΩ to 10kΩ pull-up resistor on DHT data pin
2. Wiring sensor to an input-only pin (GPIO 34-39)
3. Loose wire connection

**"Ghost" Values on MPU**

**The Symptom**: Values changing randomly that don't respond to tilt.

**The Cause**: Floating I2C bus or bad connection.

**Fix**:
- Ground the AD0 pin to lock I2C address at 0x68
- Ensure common ground across all components
- Keep I2C wires short to prevent antenna effect
- Add 100nF capacitor near sensor power pins

---

### Summary Table

| Component | Common Issue | Quick Fix |
|-----------|--------------|-----------|
| DHT22 | Reading stuck at 1°C | Change `DHT11` to `DHT22` in code |
| GPIO Pins | NaN errors | Match physical wire, `#define`, and display text |
| MPU6050 | Frozen readings (0, -47.8) | Try 5V power, ground AD0 pin |
| LCD | Scrambled characters | `Wire.setClock(100000)` for 100kHz |
| ESP32 | Guru Meditation crash | Check sensor initialized before reading |
| Serial | Mojibake symbols | Match baud rate (115200) |
| Flash | Fatal Error Status 2 | Don't use GPIO 12, 6-11 |
| WiFi | Blank LCD during setup | Use callback in WiFiManager |

## Next Steps

- [Software Issues](software-issues.md)
- [Wiring Diagrams](../hardware/wiring-diagrams.md)
- [Code Examples](../software/code-examples.md)
