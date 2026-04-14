# CoAP Protocol

CoAP (Constrained Application Protocol) is designed for constrained devices and low-power networks. Use CoAP when working with UDP-based networks or CoAP-specific infrastructure.

## Overview

CoAP features:
- **UDP-based**: Lower overhead than TCP
- **REST-like**: Similar to HTTP methods
- **Lightweight**: Smaller message size
- **Multicast**: One-to-many communication
- **Observing**: Subscribe to resource changes

### CoAP Methods

| Method | HTTP Equivalent | Use Case |
|--------|-----------------|----------|
| GET | GET | Retrieve data |
| POST | POST | Create resource |
| PUT | PUT | Update resource |
| DELETE | DELETE | Remove resource |

## ESP32 CoAP Setup

### Required Library

Install **CoAP simple library** via Arduino IDE Library Manager.

### Basic Client

```cpp
#include <WiFi.h>
#include <WiFiUdp.h>
#include <coap_simple.h>

const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

WiFiUDP udp;
Coap coap(udp);

void callback_response(CoapPacket &packet, IPAddress ip, int port) {
  Serial.println("[Coap Response got]");
  
  char p[packet.payloadlen + 1];
  memcpy(p, packet.payload, packet.payloadlen);
  p[packet.payloadlen] = NULL;
  
  Serial.println(p);
}

void setup() {
  Serial.begin(115200);
  
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
  
  coap.response(callback_response);
  coap.start();
}

void loop() {
  // Send sensor data every 10 seconds
  static unsigned long lastSend = 0;
  if (millis() - lastSend > 10000) {
    lastSend = millis();
    
    // TODO: Replace with actual sensor readings
    float temperature = 25.5;
    float humidity = 60.0;
    
    String payload = "temp=" + String(temperature) + "&hum=" + String(humidity);
    
    Serial.println("Sending CoAP message...");
    coap.put(IPAddress(192, 168, 1, 100), 5683, "sensors", payload.c_str());
  }
  
  coap.loop();
  delay(100);
}
```

### CoAP Observing (Subscriptions)

```cpp
// Subscribe to resource changes
void callback_observe(CoapPacket &packet, IPAddress ip, int port) {
  Serial.println("[Coap Observer got]");
  
  char p[packet.payloadlen + 1];
  memcpy(p, packet.payload, packet.payloadlen);
  p[packet.payloadlen] = NULL;
  
  Serial.println(p);
}

void setup() {
  // ... WiFi setup
  
  coap.observe(IPAddress(192, 168, 1, 100), 5683, "sensors/temperature", callback_observe);
  coap.start();
}
```

## CoAP Message Format

### Request

```
CON [Message ID]
  GET
  Uri-Path: sensors/temperature
```

### Response

```
ACK [Message ID]
  2.05 Content
  Payload: 25.5
```

## CoAP Response Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 2.01 | Created | Resource created successfully |
| 2.02 | Deleted | Resource deleted |
| 2.03 | Valid | Response from cache |
| 2.04 | Changed | Resource changed |
| 2.05 | Content | Response to GET |
| 4.00 | Bad Request | Invalid request |
| 4.01 | Unauthorized | Authentication required |
| 4.04 | Not Found | Resource not found |
| 5.00 | Internal Error | Server error |

## CoAP vs HTTP

| Feature | CoAP | HTTP |
|---------|------|------|
| Transport | UDP | TCP |
| Overhead | ~10 bytes | ~800 bytes |
| Multicast | Yes | No |
| Battery use | Lower | Higher |
| Proxy support | Yes | Yes |

## When to Use CoAP

- **UDP networks**: NAT traversal, no TCP overhead
- **Multicast**: One-to-many communication
- **Low power**: Battery-constrained devices
- **CoAP infrastructure**: Existing CoAP brokers/proxies

## CoAP Server Setup

For testing, set up a CoAP server:

### Using Python (aiocoap)

```bash
pip install aiocoap
```

```python
from aiocoap import Context, Message
from aiocoap.resource import Resource, Site
import asyncio

class SensorResource(Resource):
    async def render_get(self, request):
        payload = b'{"temperature": 25.5, "humidity": 60.0}'
        return Message(payload=payload, content_format=0)
    
    async def render_put(self, request):
        print(f"Received: {request.payload}")
        return Message(code=Code.CHANGED)

# Setup server
site = Site()
site.add_resource(['sensors'], SensorResource())

asyncio.run(Context.create_server_context(site))
```

## Cloud Integration

### Self-Hosted CoAP

CoAP requires a CoAP broker or server:

- **Eclipse Californium**: Java CoAP framework
- **aiocoap**: Python CoAP library
- **node-coap**: Node.js CoAP library

!!! note "AWS IoT Core"
    AWS IoT Core does not natively support CoAP. Use MQTT or HTTP for AWS.

## Testing

### CoAP CLI Tools

```bash
# Install libcoap tools
# Ubuntu/Debian: apt-get install libcoap2-bin

# GET request
coap-client -m get coap://192.168.1.100/sensors

# POST request
coap-client -m post -e "temp=25.5" coap://192.168.1.100/sensors

# Observe (subscribe)
coap-client -m get -s 60 coap://192.168.1.100/sensors/temperature
```

## DTLS Security

CoAP supports Datagram TLS (DTLS) for encrypted UDP communication:

```cpp
// DTLS requires additional setup with certificates
// Implementation depends on specific CoAP library
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| No response | Check UDP port 5683, verify server is running |
| Message lost | Implement retry logic, check network quality |
| Observe not working | Verify server supports observing |
| Payload too large | CoAP max payload ~1024 bytes, fragment if needed |

## Comparison Summary

| Protocol | Best For | Complexity |
|----------|----------|------------|
| MQTT | Real-time IoT, pub/sub | Medium |
| HTTP | Web APIs, REST | Low |
| CoAP | UDP networks, low-power | Medium |

## Next Steps

- Set up [CoAP server](../../cloud/self-hosted.md)
- Implement [complete integration](../../integration/index.md)
- Review [MQTT](mqtt.md) as alternative
