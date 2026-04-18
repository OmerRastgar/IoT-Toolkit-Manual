# Troubleshooting Guide

Solutions to common issues with the IoT Toolkit.

## Quick Diagnostics

### Check Serial Monitor
Always start by checking the Serial Monitor (115200 baud) for error messages.

### Use the I2C Scanner
Upload the I2C scanner to verify all devices are detected:

```cpp
#include <Wire.h>

void setup() {
  Wire.begin();
  Serial.begin(115200);
  Serial.println("I2C Scanner");
}

void loop() {
  for (byte address = 1; address < 127; address++) {
    Wire.beginTransmission(address);
    if (Wire.endTransmission() == 0) {
      Serial.print("Found: 0x");
      Serial.println(address, HEX);
    }
  }
  delay(5000);
}
```

## Common Issues

### Hardware Issues
- [Sensor not detected](hardware-issues.md)
- [WiFi Connection Problems](#wifi-connection-problems)
- [MQTT Connection Issues](#mqtt-broker-issues)
- [InfluxDB & Authentication Errors](#influxdb-authentication-errors)
- [ESP32 Stability (CoAP/Crashes)](#esp32-stability-crashes)
- [Hardware Errors](#hardware-errors)

## InfluxDB & Authentication Errors

### "Failed to load keys" in InfluxDB UI
- **Cause**: This happens if you have wiped the database but your browser is still using an old session cookie. 
- **Solution**: Logout of the InfluxDB UI and log back in, or open the page in an **Incognito/Private window**.

### "Unauthorized access" in Node-RED
- **Cause**: On Windows, the internal database (BoltDB) can get "locked" by the host filesystem, preventing tokens from working correctly.
- **Solution**: Ensure your `docker-compose.yml` uses **Named Volumes** (e.g., `influxdb_data`) instead of folder bind-mounts. Wiping the internal volumes via `docker volume rm` is sometimes required for a clean reset.

### "Unable to create token"
- **Cause**: Filesystem permissions or corruption in the InfluxDB config volume.
- **Solution**: Follow the **Zero-Touch Docker Setup** in the [Self-Hosted Guide](../cloud/self-hosted.md) to ensure a clean, automated initialization.

## ESP32 Stability (CoAP/Crashes)

### ESP32 reboots or panics during CoAP
- **Cause**: Using CoAP `PUT` or `POST` without a registered response callback. The device "waits" for an ACK and may overflow if the server responds unexpectedly.
- **Solution**: 
    1. Register a `coap.response(coapResponseCallback)` in your `setup()`.
    2. Ensure the callback is valid (even if it just prints a message).
    3. Verify the CoAP server port is moved to `5685` if using Docker on Windows.

### Software Issues
- [Code won't compile](software-issues.md)
- [Code won't upload](software-issues.md)
- [Library not found](software-issues.md)
- [MQTT connection fails](software-issues.md)

## Diagnostic Flowchart

```
Problem Occurs
      │
      ▼
Check Serial Monitor
      │
      ├── Error message? ──▶ [Search error below]
      │
      └── No output? ──▶ [Check power/connections]
      │
      ▼
I2C Devices detected?
      │
      ├── Yes ──▶ [Check sensor initialization]
      │
      └── No ──▶ [Check wiring/pull-ups]
      │
      ▼
WiFi connected?
      │
      ├── Yes ──▶ [Check cloud connection]
      │
      └── No ──▶ [Check WiFi credentials]
      │
      ▼
MQTT connected?
      │
      ├── Yes ──▶ [Check topic/subscription]
      │
      └── No ──▶ [Check broker/credentials]
```

## Error Messages

### ESP32 Errors

#### `rst:0x1 (POWERON_RESET)`
**Normal**: Just indicates reboot, not an error.

#### `rst:0x8 (TG1WDT_SYS_RESET)`
**Watchdog timeout**: Code stuck in infinite loop
- Add `yield()` or `delay()` in long loops
- Check for blocking operations

#### `Brownout detector was triggered`
**Power issue**: Insufficient power supply
- Use better power supply (2A+ recommended)
- Add capacitor (100μF) near ESP32
- Check USB cable quality

#### `Guru Meditation Error`
**Memory issue**: Stack overflow or null pointer
- Reduce memory usage
- Check for buffer overflows
- Increase stack size if needed

#### `LoadProhibited`
**Memory access error**: Accessing invalid memory
- Check array bounds
- Verify pointer initialization
- Don't use GPIO 6-11 (reserved)

### MQTT Errors

#### `failed, rc=-2`
**Network connection failed**
- Check WiFi connection
- Verify MQTT broker address
- Check firewall settings

#### `failed, rc=-4`
**Connection timeout**
- Broker not reachable
- Port blocked
- Network latency too high

#### `failed, rc=5`
**Connection refused (MQTT)**
- Bad username/password
- Client ID in use
- Not authorized

### WiFi Errors

#### `WL_DISCONNECTED` (Status 6)
- Check WiFi credentials
- Verify 2.4GHz network (not 5GHz)
- Check router is working

#### `WL_CONNECT_FAILED` (Status 4)
- Wrong password
- Network security issue
- MAC filtering enabled

## Getting Help

If you can't resolve the issue:

1. **Search this guide** for your specific error
2. **Check detailed sections**: [Hardware](hardware-issues.md) | [Software](software-issues.md)
3. **Review wiring**: [Wiring Diagrams](../hardware/wiring-diagrams.md)
4. **Test components**: [Code Examples](../software/code-examples.md)
5. **Community resources**: [References](../resources/references.md)

## Before Asking for Help

When seeking assistance, provide:

1. **Serial Monitor output** (full log)
2. **Code snippet** (minimal reproducible example)
3. **Hardware list** (specific models)
4. **What you tried** (steps taken)
5. **Expected vs actual** behavior

## Next Steps

- [Hardware Issues](hardware-issues.md)
- [Software Issues](software-issues.md)
- [Resources](../resources/index.md)
