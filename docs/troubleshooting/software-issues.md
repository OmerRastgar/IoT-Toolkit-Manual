# Software Troubleshooting

Solutions for software and code-related issues.

## Compilation Errors

### Library Not Found

**Error**: `fatal error: xxx.h: No such file or directory`

**Solutions**:
1. Install the library:
   ```
   Sketch → Include Library → Manage Libraries
   Search: "library-name"
   Install
   ```

2. Check library name spelling
   - Case-sensitive on Linux
   - Example: `LiquidCrystal_I2C` not `liquidcrystal_i2c`

3. Verify library installed:
   ```
   Sketch → Include Library
   (Should appear in list)
   ```

### Multiple Libraries Found

**Error**: `Multiple libraries were found for "xxx.h"`

**Solutions**:
1. Remove duplicate libraries
   - Check `Documents/Arduino/libraries/`
   - Delete old versions
   - Keep only latest version

2. Specify which library to use:
   ```cpp
   #include <LibraryName.h>  // Use specific library
   ```

### Redefinition Errors

**Error**: `redefinition of 'xxx'`

**Causes**:
- Variable defined in multiple files
- Function declared twice
- Header guard missing

**Solutions**:
```cpp
// In header files, use include guards
#ifndef MY_HEADER_H
#define MY_HEADER_H
// ... declarations ...
#endif

// Or use pragma once
#pragma once
// ... declarations ...
```

### Out of Memory

**Error**: `region dram0_1_seg' overflowed` or `Not enough memory`

**Solutions**:
1. Reduce buffer sizes
   ```cpp
   // Instead of:
   char buffer[10000];
   
   // Use:
   char buffer[1000];
   ```

2. Use PSRAM (if available)
   ```cpp
   // Check PSRAM
   if (psramFound()) {
     Serial.println("PSRAM found");
   }
   ```

3. Minimize string usage
   ```cpp
   // Use const char* instead of String
   const char* message = "Hello";  // Better
   String message = "Hello";       // Uses more memory
   ```

4. Enable memory optimization
   ```
   Tools → Partition Scheme → Huge APP
   ```

## Upload Errors

### Upload Failed

**Error**: `Failed to connect to ESP32`

**Solutions**:
1. Hold BOOT button, press RESET, release BOOT
2. Check USB cable (must be data cable)
3. Verify correct COM port selected
4. Install USB drivers
5. Try different USB port

### Wrong Boot Mode

**Error**: `Wrong boot mode detected` or `boot mode:(3,0)`

**Cause**: GPIO0 not LOW during upload

**Solutions**:
- Press and hold BOOT button during entire upload
- Or use auto-reset circuit

### Serial Port Not Found

**Error**: Port not in Tools → Port menu

**Solutions**:
1. Install drivers:
   - CP210x: [Download](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers)
   - CH340: Usually auto-installs

2. Check device manager (Windows)
   - Look for unknown devices
   - Update driver

3. Linux: Add user to dialout group
   ```bash
   sudo usermod -a -G dialout $USER
   # Logout and login again
   ```

## Runtime Errors

### Watchdog Timeout

**Error**: `Task watchdog got triggered` or `Guru Meditation Error`

**Solutions**:
1. Add yields in long loops
   ```cpp
   for (int i = 0; i < 10000; i++) {
     // Some work
     yield();  // Prevent watchdog
   }
   ```

2. Use delay() instead of busy-wait
   ```cpp
   // Bad:
   while (millis() - start < 1000);  // Busy wait
   
   // Good:
   delay(1000);  // Yields to system
   ```

3. Run heavy tasks on Core 0
   ```cpp
   xTaskCreatePinnedToCore(
     heavyTask,    // Function
     "HeavyTask",  // Name
     10000,        // Stack size
     NULL,         // Parameter
     1,            // Priority
     NULL,         // Task handle
     0             // Core 0
   );
   ```

### Null Pointer Exception

**Error**: `LoadProhibited` or crash at address 0x00000000

**Solutions**:
1. Check pointer initialization
   ```cpp
   // Bad:
   int* ptr;
   *ptr = 5;  // Crash!
   
   // Good:
   int* ptr = new int;
   *ptr = 5;
   ```

2. Verify object creation
   ```cpp
   // Check if sensor initialized
   if (!sensor.begin()) {
     Serial.println("Sensor init failed!");
     return;
   }
   ```

### Stack Overflow

**Error**: `Stack smashing protect failure!`

**Solutions**:
1. Reduce local variable sizes
2. Avoid recursion
3. Increase stack size (if needed)
   ```cpp
   // In setup, before creating tasks
   ```

## WiFi Issues

### Won't Connect

**Symptoms**: `WiFi.status()` never returns `WL_CONNECTED`

**Solutions**:
1. Check credentials
   ```cpp
   // Verify exact SSID and password
   Serial.println(ssid);      // Should match router exactly
   Serial.println(password);  // Check special characters
   ```

2. Check 2.4GHz network
   ```cpp
   // ESP32 only supports 2.4GHz
   // Ensure router broadcasts 2.4GHz
   ```

3. Add connection retry
   ```cpp
   int attempts = 0;
   while (WiFi.status() != WL_CONNECTED && attempts < 20) {
     delay(500);
     Serial.print(".");
     attempts++;
   }
   ```

### Frequent Disconnections

**Symptoms**: WiFi connects but drops frequently

**Solutions**:
1. Set WiFi power saving mode
   ```cpp
   WiFi.setSleep(false);  // Disable power saving
   ```

2. Check RSSI
   ```cpp
   if (WiFi.RSSI() < -80) {
     Serial.println("Weak signal!");
   }
   ```

3. Add auto-reconnect
   ```cpp
   void loop() {
     if (WiFi.status() != WL_CONNECTED) {
       WiFi.reconnect();
     }
     // ... rest of code
   }
   ```

## MQTT Issues

### Connection Failed

**Error**: `failed, rc=-2` or `rc=-4`

**Solutions**:
1. Check WiFi first
   ```cpp
   if (WiFi.status() != WL_CONNECTED) {
     return;  // Don't try MQTT without WiFi
   }
   ```

2. Verify broker address
   ```cpp
   const char* mqtt_server = "192.168.1.100";  // Correct IP
   // NOT: mqtt_server = "broker.hivemq.com"  // Wrong if not using
   ```

3. Check port
   ```cpp
   client.setServer(mqtt_server, 1883);  // Standard MQTT
   // or
   client.setServer(mqtt_server, 8883);  // MQTT over TLS
   ```

### Authentication Failed

**Error**: `failed, rc=5`

**Solutions**:
1. Check credentials
   ```cpp
   client.connect(clientID, username, password)
   ```

2. Verify client ID is unique
   ```cpp
   String clientId = "ESP32-" + String(random(0xffff), HEX);
   ```

3. Check broker allows anonymous
   ```cpp
   // If no auth needed:
   client.connect(clientId.c_str())
   ```

### Messages Not Published

**Symptoms**: `client.publish()` returns false

**Solutions**:
1. Check connection first
   ```cpp
   if (!client.connected()) {
     reconnect();
   }
   ```

2. Verify topic format
   ```cpp
   // Valid topics:
   "home/sensors/temperature"
   "iot/device1/data"
   
   // Invalid:
   "#home"  // Can't start with wildcard
   ```

3. Check payload size
   ```cpp
   // MQTT max payload ~256MB, but ESP32 has limits
   // Keep under 1KB for ESP32
   ```

## I2C Issues

### Bus Lockup

**Symptoms**: I2C stops responding, devices not detected

**Solutions**:
1. Reset I2C bus
   ```cpp
   void resetI2C() {
     Wire.end();
     delay(100);
     Wire.begin();
   }
   ```

2. Check for stuck devices
3. Add timeout
   ```cpp
   // Some libraries support timeout
   Wire.setTimeOut(500);  // 500ms timeout
   ```

## Debugging Techniques

### Enable Verbose Output

```cpp
// In setup()
Serial.setDebugOutput(true);
```

### Add Debug Prints

```cpp
#define DEBUG 1

#if DEBUG
  #define DPRINT(x) Serial.println(x)
#else
  #define DPRINT(x)
#endif

// Usage:
DPRINT("Entering function X");
DPRINT(String("Value: ") + value);
```

### Stack Trace Decoding

For Guru Meditation errors:
1. Note the exception and address
2. Use ESP Exception Decoder tool
3. Or use `xtensa-esp32-elf-addr2line` command

## Common Mistakes

| Mistake | Correct |
|---------|---------|
| `String + int` | `String + String(int)` |
| Missing `yield()` | Add in long loops |
| GPIO 6-11 usage | Use GPIO 0-5, 12-15, 18-21, 25-27, 32-33 |
| String in loops | Use char[] or const char* |
| No null checks | Verify pointers before use |
| Deep sleep without wake source | Configure timer or GPIO |

## Next Steps

- [Hardware Issues](hardware-issues.md)
- [Integration Testing](../integration/testing.md)
- [Code Examples](../software/code-examples.md)
