# Code Examples

Test code examples for individual components.

## ESP32 Basic Test

### WiFi Connection

```cpp
#include <WiFi.h>

const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

void setup() {
  Serial.begin(115200);
  
  WiFi.begin(ssid, password);
  Serial.print("Connecting");
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("\nWiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  // Connection maintained automatically
}
```

### I2C Scanner

```cpp
#include <Wire.h>

void setup() {
  Wire.begin();
  Serial.begin(115200);
  Serial.println("\nI2C Scanner");
}

void loop() {
  Serial.println("Scanning...");
  
  int deviceCount = 0;
  for (byte address = 1; address < 127; address++) {
    Wire.beginTransmission(address);
    if (Wire.endTransmission() == 0) {
      Serial.print("Device at 0x");
      if (address < 16) Serial.print("0");
      Serial.println(address, HEX);
      deviceCount++;
    }
  }
  
  if (deviceCount == 0) {
    Serial.println("No devices found");
  }
  
  Serial.println("Done\n");
  delay(5000);
}
```

## Sensor Examples

<!-- TODO: Extract specific sensor code from source file -->

### Temperature Sensor

```cpp
// TODO: Add temperature sensor test code
```

### Humidity Sensor

```cpp
// TODO: Add humidity sensor test code
```

### Vibration Sensor

```cpp
// TODO: Add vibration sensor test code
```

### Acoustic Sensor

```cpp
// TODO: Add acoustic sensor test code
```

## Display Examples

### LCD Display

```cpp
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// Set I2C address (0x27 or 0x3F)
LiquidCrystal_I2C lcd(0x27, 16, 2);

void setup() {
  lcd.init();
  lcd.backlight();
  
  lcd.setCursor(0, 0);
  lcd.print("IoT Toolkit");
  lcd.setCursor(0, 1);
  lcd.print("LCD Test OK");
}

void loop() {
  lcd.setCursor(0, 1);
  lcd.print("Time: ");
  lcd.print(millis() / 1000);
  lcd.print("s   ");
  delay(1000);
}
```

### TFT Display

```cpp
// TODO: Add TFT display test code
```

## Communication Examples

### MQTT Client

```cpp
#include <WiFi.h>
#include <PubSubClient.h>

const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
const char* mqtt_server = "broker.hivemq.com";

WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  Serial.begin(115200);
  
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  client.setServer(mqtt_server, 1883);
  
  Serial.println("\nWiFi connected");
  Serial.println("MQTT connecting...");
}

void reconnect() {
  while (!client.connected()) {
    String clientId = "ESP32-" + String(random(0xffff), HEX);
    if (client.connect(clientId.c_str())) {
      Serial.println("MQTT connected");
    } else {
      delay(5000);
    }
  }
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  
  // Publish every 5 seconds
  static unsigned long lastMsg = 0;
  if (millis() - lastMsg > 5000) {
    lastMsg = millis();
    
    String payload = "{\"test\": true, \"time\": " + String(millis()) + "}";
    client.publish("iot-toolkit/test", payload.c_str());
    Serial.println("Published: " + payload);
  }
}
```

### HTTP Client

```cpp
#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

void setup() {
  Serial.begin(115200);
  
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    
    http.begin("http://httpbin.org/get");
    int httpCode = http.GET();
    
    if (httpCode > 0) {
      String payload = http.getString();
      Serial.println(httpCode);
      Serial.println(payload);
    }
    
    http.end();
  }
  
  delay(10000);
}
```

## Module Examples

### I2C Multiplexer

See [I2C Multiplexer page](../hardware/modules/i2c-multiplexer.md) for complete example.

## Complete System Example

### All Sensors + MQTT

```cpp
#include <WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>

// TODO: Add sensor includes

const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
const char* mqtt_server = "broker.hivemq.com";

WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  Serial.begin(115200);
  
  // Connect WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
  
  // Setup MQTT
  client.setServer(mqtt_server, 1883);
  
  // TODO: Initialize sensors
}

void reconnect() {
  while (!client.connected()) {
    String clientId = "ESP32-" + String(random(0xffff), HEX);
    if (client.connect(clientId.c_str())) {
      Serial.println("MQTT connected");
    } else {
      delay(5000);
    }
  }
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  
  // Publish every 10 seconds
  static unsigned long lastMsg = 0;
  if (millis() - lastMsg > 10000) {
    lastMsg = millis();
    
    // Read sensors
    // TODO: Add actual sensor readings
    float temperature = 25.5;
    float humidity = 60.0;
    
    // Create JSON payload
    StaticJsonDocument<256> doc;
    doc["temperature"] = temperature;
    doc["humidity"] = humidity;
    doc["timestamp"] = millis();
    
    char payload[256];
    serializeJson(doc, payload);
    
    client.publish("iot-toolkit/sensors", payload);
    Serial.println(payload);
  }
}
```

## Next Steps

- Upload individual tests to verify each component
- Proceed to [complete integration](../integration/index.md)
