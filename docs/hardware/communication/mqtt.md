# MQTT Protocol

MQTT (Message Queuing Telemetry Transport) is the recommended protocol for IoT applications - lightweight, efficient, and perfect for real-time sensor data.

## Overview

MQTT uses a publish/subscribe model where:
- **Publishers** send data to topics
- **Subscribers** receive data from topics
- **Broker** routes messages between them

### Key Features
- Lightweight binary protocol
- Low bandwidth usage
- Bidirectional communication
- Quality of Service (QoS) levels
- Retained messages
- Last Will and Testament

## ESP32 MQTT Setup

### Required Library

Install **PubSubClient** via Arduino IDE Library Manager.

### Basic Connection

```cpp
#include <WiFi.h>
#include <PubSubClient.h>

// WiFi credentials
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// MQTT broker
const char* mqtt_server = "broker.hivemq.com";  // Public test broker
const int mqtt_port = 1883;

WiFiClient espClient;
PubSubClient client(espClient);

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    String clientId = "ESP32Client-" + String(random(0xffff), HEX);
    
    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
      client.subscribe("iot-toolkit/commands");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

void setup() {
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // Publish sensor data every 5 seconds
  static unsigned long lastMsg = 0;
  unsigned long now = millis();
  if (now - lastMsg > 5000) {
    lastMsg = now;
    
    // TODO: Replace with actual sensor readings
    float temperature = 25.5;
    float humidity = 60.0;
    
    String payload = "{";
    payload += "\"temperature\":" + String(temperature, 1) + ",";
    payload += "\"humidity\":" + String(humidity, 1);
    payload += "}";
    
    Serial.print("Publishing: ");
    Serial.println(payload);
    client.publish("iot-toolkit/sensors", payload.c_str());
  }
}
```

## Topic Structure

Recommended topic hierarchy:

```
iot-toolkit/
├── sensors/
│   ├── temperature
│   ├── humidity
│   ├── vibration
│   └── acoustic
├── status/
│   ├── connection
│   └── battery
└── commands/
    ├── config
    └── control
```

### Example Topics

| Topic | Direction | Purpose |
|-------|-----------|---------|
| `iot-toolkit/sensors/temperature` | Device → Cloud | Temperature readings |
| `iot-toolkit/sensors/humidity` | Device → Cloud | Humidity readings |
| `iot-toolkit/commands/config` | Cloud → Device | Configuration updates |
| `iot-toolkit/status/connection` | Device → Cloud | Online/offline status |

## Quality of Service (QoS)

| QoS | Meaning | Use Case |
|-----|---------|----------|
| 0 | At most once | High frequency, loss-tolerant data |
| 1 | At least once | Important data, allow duplicates |
| 2 | Exactly once | Critical commands, no duplicates |

```cpp
// Publish with QoS 1
client.publish("topic", "message", true);  // retained=true
```

## TLS/SSL Encryption

For secure connections:

```cpp
#include <WiFiClientSecure.h>

WiFiClientSecure espClient;
PubSubClient client(espClient);

void setup() {
  // Load certificate (for AWS IoT Core or custom broker)
  espClient.setCACert(root_ca);
  espClient.setCertificate(client_cert);
  espClient.setPrivateKey(client_key);
  
  client.setServer(mqtt_server, 8883);  // TLS port
}
```

## Testing with Public Broker

Test your setup without a private broker:

**Broker**: `broker.hivemq.com`  
**Port**: `1883` (unencrypted) or `8883` (TLS)

Or use MQTT CLI tools:
```bash
# Subscribe to topics
mosquitto_sub -h broker.hivemq.com -t "iot-toolkit/#" -v

# Publish test message
mosquitto_pub -h broker.hivemq.com -t "iot-toolkit/sensors" -m '{"test": true}'
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Connection refused | Check broker address and port |
| Authentication failed | Verify credentials/certificate |
| Frequent disconnections | Check keepalive settings, network stability |
| Message not received | Verify topic subscription, check QoS |
| Connection timeout | Check firewall, verify broker is reachable |

## Cloud Integration

### AWS IoT Core
- Use AWS IoT MQTT broker endpoint
- Authenticate with X.509 certificates
- Port: 8883 (TLS required)

See [AWS IoT Core setup](../../cloud/aws.md) for details.

### Self-Hosted
- Use Mosquitto broker
- Configure authentication
- Port: 1883 or 8883

See [Self-hosted setup](../../cloud/self-hosted.md) for details.

## Next Steps

- Configure [AWS IoT Core](../../cloud/aws.md) or [self-hosted broker](../../cloud/self-hosted.md)
- Set up [complete integration](../../integration/index.md)
- Explore [HTTP protocol](http.md) as alternative
