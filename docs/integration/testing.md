# Testing Procedures

Verify your complete IoT Toolkit setup.

## Test Checklist

### Hardware Tests
- [ ] ESP32 powers on
- [ ] All sensors detected via I2C
- [ ] LCD display works
- [ ] TFT display works (if connected)
- [ ] WiFi connects successfully
- [ ] MQTT connects successfully

### Software Tests
- [ ] Code compiles without errors
- [ ] Code uploads successfully
- [ ] Serial Monitor shows data
- [ ] Sensors read correctly
- [ ] Display updates correctly
- [ ] MQTT publishes successfully

## Step-by-Step Testing

### Phase 1: Hardware Verification

#### 1.1 Power Test
1. Connect ESP32 via USB
2. Check power LED lights up
3. Open Serial Monitor (115200 baud)
4. Verify boot messages appear

Expected output:
```
rst:0x1 (POWERON_RESET),boot:0x13 (SPI_FAST_FLASH_BOOT)
...
WiFi connected
IP address: 192.168.1.xxx
```

#### 1.2 I2C Scanner Test
Upload I2C scanner sketch:

```cpp
#include <Wire.h>

void setup() {
  Wire.begin();
  Serial.begin(115200);
  Serial.println("I2C Scanner");
}

void loop() {
  Serial.println("Scanning...");
  for (byte i = 1; i < 127; i++) {
    Wire.beginTransmission(i);
    if (Wire.endTransmission() == 0) {
      Serial.print("Found: 0x");
      Serial.println(i, HEX);
    }
  }
  Serial.println("Done\n");
  delay(5000);
}
```

Verify all sensors are detected.

#### 1.3 Individual Sensor Tests

Test each sensor with standalone sketch from [code examples](../software/code-examples.md).

| Sensor | Expected Result |
|--------|----------------|
| Temperature | Reading in °C, varies with environment |
| Humidity | Reading in %, varies with environment |
| Vibration | Changes when sensor is moved |
| Acoustic | Changes when sound is made |

#### 1.4 Display Tests

LCD Test:
- Text appears on display
- Backlight works
- Text updates

TFT Test:
- Screen initializes
- Colors display correctly
- Graphics render

### Phase 2: Integration Test

#### 2.1 Upload Complete Code

Upload the [complete integration code](complete-code.md).

#### 2.2 Serial Monitor Check

Look for these messages:

```
========================================
IoT Toolkit - Complete Integration
========================================

I2C initialized
WiFi connected!
IP: 192.168.1.xxx
MQTT connected
Setup complete. Starting main loop...

Reading sensors...
Temp: 25.5C, Hum: 60%, Vib: 45, Acoustic: 72dB
Sending MQTT: {"device_id":"iot-toolkit-001",...}
MQTT publish successful
```

#### 2.3 LCD Display Check

Display should cycle through:
1. Temperature and Humidity
2. Vibration and Acoustic
3. WiFi RSSI and Read Count

### Phase 3: Cloud Test

#### 3.1 MQTT Test

##### Using mosquitto_sub

```bash
mosquitto_sub -h broker.hivemq.com -t "iot-toolkit/#" -v
```

Expected output:
```
iot-toolkit/data {"device_id":"iot-toolkit-001","timestamp":12345,"sensors":{"temperature":25.5,...}}
```

##### Using MQTT.fx or similar GUI tool

1. Connect to broker.hivemq.com:1883
2. Subscribe to topic: `iot-toolkit/#`
3. Verify messages appear every 10 seconds

#### 3.2 HTTP Test (if using HTTP)

```bash
curl -X POST http://your-server/api/data \
  -H "Content-Type: application/json" \
  -d '{"temperature": 25.5, "humidity": 60.0}'
```

### Phase 4: Long-Term Test

#### 4.1 Stability Test

Run system for 24 hours and verify:
- No crashes
- Consistent data transmission
- No memory leaks (free heap stable)

#### 4.2 Reconnection Test

1. Turn off WiFi router
2. Wait 1 minute
3. Turn on WiFi router
4. Verify ESP32 reconnects automatically

## Common Issues

### No I2C Devices Found

**Symptoms**: I2C scanner shows no devices

**Solutions**:
- Check wiring (SDA to GPIO21, SCL to GPIO22)
- Verify 3.3V power
- Check for bent pins on breadboard
- Add 4.7kΩ pull-up resistors

### WiFi Won't Connect

**Symptoms**: Serial shows connection failed

**Solutions**:
- Verify WiFi credentials
- Check 2.4GHz network (not 5GHz)
- Move closer to router
- Check if MAC filtering is enabled

### MQTT Connection Fails

**Symptoms**: MQTT connect returns error code

**Solutions**:
- Check broker address and port
- Verify firewall allows outbound connections
- Try different broker (test with hivemq)
- Check client ID is unique

### Sensor Readings Wrong

**Symptoms**: Impossible values (negative, zero, max)

**Solutions**:
- Verify sensor initialization
- Check I2C address
- Verify sensor is powered
- Check library compatibility

## Debug Mode

Enable verbose logging:

```cpp
#define DEBUG_MODE true

#if DEBUG_MODE
  #define DEBUG_PRINT(x) Serial.print(x)
  #define DEBUG_PRINTLN(x) Serial.println(x)
#else
  #define DEBUG_PRINT(x)
  #define DEBUG_PRINTLN(x)
#endif
```

## Test Report Template

```
IoT Toolkit Test Report
Date: ___________
Tested by: ___________

Hardware Status:
[ ] ESP32 DevKit V1
[ ] Temperature sensor detected at 0x__
[ ] Humidity sensor detected at 0x__
[ ] Vibration sensor detected at 0x__
[ ] Acoustic sensor detected at 0x__
[ ] LCD Display working
[ ] TFT Display working (optional)

Software Status:
[ ] Code compiles
[ ] Code uploads
[ ] WiFi connects
[ ] MQTT connects
[ ] Sensors read data
[ ] LCD updates
[ ] MQTT publishes

Cloud Status:
[ ] MQTT messages received
[ ] Data format correct
[ ] Timestamp accurate

Notes:
_________________________________
_________________________________
_________________________________

Signature: ___________
```

## Next Steps

After passing all tests:

1. Deploy to permanent location
2. Configure [cloud services](../cloud/index.md)
3. Set up [monitoring dashboard](../cloud/self-hosted.md)
4. Review [troubleshooting guide](../troubleshooting/index.md)

## Getting Help

If tests fail:

1. Check [Troubleshooting](../troubleshooting/index.md)
2. Verify wiring against [diagrams](../hardware/wiring-diagrams.md)
3. Test with minimal code (individual components)
4. Check Serial Monitor for error messages
