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

## Next Steps

- [Software Issues](software-issues.md)
- [Wiring Diagrams](../hardware/wiring-diagrams.md)
- [Code Examples](../software/code-examples.md)
