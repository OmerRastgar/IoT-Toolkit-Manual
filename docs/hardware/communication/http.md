# HTTP Protocol

HTTP (Hypertext Transfer Protocol) is the foundation of web communication. Use HTTP when integrating with REST APIs or web services.

## Overview

HTTP uses a request/response model:
- **Client** (ESP32) sends requests
- **Server** responds with data
- Stateless protocol (each request is independent)

### HTTP Methods

| Method | Use Case |
|--------|----------|
| GET | Retrieve sensor data, fetch configuration |
| POST | Send sensor data, create resources |
| PUT | Update configuration |
| DELETE | Remove resources |

## ESP32 HTTP Setup

### Required Library

Use **HTTPClient** (built-in with ESP32 board support).

### Basic GET Request

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
    
    // Configure request
    http.begin("http://api.example.com/sensors/data");
    http.addHeader("Content-Type", "application/json");
    http.addHeader("Authorization", "Bearer YOUR_API_KEY");
    
    // Send GET request
    int httpCode = http.GET();
    
    if (httpCode > 0) {
      String payload = http.getString();
      Serial.println(httpCode);
      Serial.println(payload);
    } else {
      Serial.printf("Error: %s\n", http.errorToString(httpCode).c_str());
    }
    
    http.end();
  }
  
  delay(10000);  // Wait 10 seconds
}
```

### POST Request with Sensor Data

```cpp
void sendSensorData() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    http.begin("http://api.example.com/sensors/data");
    http.addHeader("Content-Type", "application/json");
    
    // TODO: Replace with actual sensor readings
    float temperature = 25.5;
    float humidity = 60.0;
    
    // Create JSON payload
    String jsonPayload = "{";
    jsonPayload += "\"device_id\":\"esp32-001\",";
    jsonPayload += "\"temperature\":" + String(temperature, 1) + ",";
    jsonPayload += "\"humidity\":" + String(humidity, 1) + ",";
    jsonPayload += "\"timestamp\":" + String(millis());
    jsonPayload += "}";
    
    int httpCode = http.POST(jsonPayload);
    
    if (httpCode == 200) {
      String response = http.getString();
      Serial.println("Data sent successfully");
      Serial.println(response);
    } else {
      Serial.printf("POST failed: %d\n", httpCode);
    }
    
    http.end();
  }
}
```

## HTTPS (Encrypted)

For secure connections:

```cpp
void sendSecureData() {
  HTTPClient http;
  
  // HTTPS URL
  http.begin("https://api.example.com/sensors/data");
  
  // Skip certificate validation (development only!)
  // http.setInsecure();
  
  // Or use certificate
  // http.setCACert(root_ca);
  
  http.addHeader("Content-Type", "application/json");
  
  int httpCode = http.POST(jsonPayload);
  // ... handle response
  
  http.end();
}
```

!!! warning "Certificate Validation"
    In production, always validate server certificates. `setInsecure()` should only be used for testing.

## REST API Best Practices

### Endpoint Structure

```
GET  /api/v1/sensors           # List all sensors
GET  /api/v1/sensors/{id}      # Get specific sensor
POST /api/v1/sensors/data      # Submit sensor data
PUT  /api/v1/sensors/{id}      # Update sensor config
```

### Response Codes

| Code | Meaning | Action |
|------|---------|--------|
| 200 | OK | Request successful |
| 201 | Created | Resource created |
| 400 | Bad Request | Check request format |
| 401 | Unauthorized | Check authentication |
| 403 | Forbidden | Check permissions |
| 404 | Not Found | Check endpoint URL |
| 500 | Server Error | Retry or contact admin |

### Authentication

Common methods:
- **API Key**: Header `Authorization: Bearer <key>`
- **Basic Auth**: Base64 encoded username:password
- **Token**: OAuth 2.0 or JWT tokens

```cpp
// API Key authentication
http.addHeader("Authorization", "Bearer YOUR_API_KEY");

// Basic authentication
String auth = base64::encode("username:password");
http.addHeader("Authorization", "Basic " + auth);
```

## Testing Endpoints

Use curl or Postman to test before implementing:

```bash
# Test GET endpoint
curl -X GET "http://api.example.com/sensors/data"

# Test POST endpoint
curl -X POST "http://api.example.com/sensors/data" \
  -H "Content-Type: application/json" \
  -d '{"temperature": 25.5, "humidity": 60.0}'

# With authentication
curl -X GET "http://api.example.com/sensors/data" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

## Error Handling

```cpp
void sendDataWithRetry() {
  int maxRetries = 3;
  int retryCount = 0;
  bool success = false;
  
  while (!success && retryCount < maxRetries) {
    HTTPClient http;
    http.begin(serverUrl);
    http.setTimeout(5000);  // 5 second timeout
    
    int httpCode = http.POST(data);
    
    if (httpCode == 200) {
      success = true;
      Serial.println("Success");
    } else {
      retryCount++;
      Serial.printf("Retry %d/%d\n", retryCount, maxRetries);
      delay(1000);
    }
    
    http.end();
  }
  
  if (!success) {
    Serial.println("Failed after all retries");
    // Store data locally for later transmission
  }
}
```

## Comparison with MQTT

| Feature | HTTP | MQTT |
|---------|------|------|
| Protocol | TCP request/response | TCP publish/subscribe |
| Overhead | Higher (headers) | Lower (binary) |
| Real-time | Polling required | Push notifications |
| Direction | Client always initiates | Bidirectional |
| Use case | Web APIs, REST services | IoT telemetry, events |

## When to Use HTTP

- Integrating with existing REST APIs
- Web dashboard integration
- Request/response patterns
- Simple data submission
- When MQTT broker is unavailable

## Cloud Integration

### AWS
- AWS API Gateway for REST endpoints
- AWS Lambda for serverless processing
- DynamoDB for data storage

See [AWS setup](../../cloud/aws.md) for configuration.

### Self-Hosted
- Custom REST API server (Node.js, Python Flask, etc.)
- Traditional web hosting
- Local network servers

See [Self-hosted setup](../../cloud/self-hosted.md) for details.

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Connection failed | Check URL, verify DNS, check firewall |
| 404 error | Verify endpoint path |
| 401/403 error | Check authentication credentials |
| Timeout | Increase timeout, check server response time |
| Memory errors | Reduce payload size, use streaming for large data |

## Next Steps

- Configure your [cloud endpoint](../../cloud/index.md)
- Implement [complete integration](../../integration/index.md)
- Consider [MQTT](mqtt.md) for real-time features
