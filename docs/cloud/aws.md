# AWS IoT Core Setup

Connect your IoT Toolkit to AWS IoT Core for managed cloud service.

## Prerequisites

- AWS account (free tier eligible)
- ESP32 with WiFi
- Completed [integration testing](../integration/testing.md)

## Step 1: Create AWS Account

1. Go to [aws.amazon.com](https://aws.amazon.com)
2. Click "Create AWS Account"
3. Follow registration process
4. Complete identity verification

!!! tip "Free Tier"
    AWS IoT Core has a free tier: 250,000 messages/month for first 12 months.

## Step 2: Navigate to IoT Core

1. Log in to AWS Console
2. Search for "IoT Core" in services
3. Click on AWS IoT Core
4. Select your region (e.g., us-east-1)

## Step 3: Create a Thing

### 3.1 Register Device

1. In IoT Core, go to **Manage** > **Things**
2. Click **Create things**
3. Select "Create single thing"
4. Click **Next**

### 3.2 Configure Thing

1. **Name**: `iot-toolkit-001`
2. **Type**: (optional) Create type "ESP32-Sensor"
3. **Group**: (optional) Create group "IoT-Toolkits"
4. Click **Next**

### 3.3 Generate Certificates

1. Select **Auto-generate a new certificate**
2. Click **Next**
3. **Attach policies**: Create new policy
   - **Name**: `IoT-Toolkit-Policy`
   - **Policy document**:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": "iot:*",
         "Resource": "*"
       }
     ]
   }
   ```
   !!! warning "Security Note"
       This policy allows all actions. For production, restrict to specific topics and actions.

4. Click **Create policy**
5. Select the new policy
6. Click **Create thing**

### 3.4 Download Certificates

Download all files:
- `xxx-certificate.pem.crt` → Save as `certificate.pem`
- `xxx-private.pem.key` → Save as `private.key`
- `AmazonRootCA1.pem` → Save as `ca.crt`

!!! important "Keep Private Key Secure"
    The private key should never be shared or committed to public repositories.

## Step 4: Configure ESP32

### 4.1 Upload Certificates

Convert certificates to Arduino strings:

1. Open each certificate file in text editor
2. Copy entire content (including BEGIN/END lines)
3. Create Arduino sketch with certificates:

```cpp
// certificates.h
#ifndef CERTIFICATES_H
#define CERTIFICATES_H

const char* ca_cert = R"EOF(
-----BEGIN CERTIFICATE-----
[Amazon Root CA 1 certificate content]
-----END CERTIFICATE-----
)EOF";

const char* client_cert = R"EOF(
-----BEGIN CERTIFICATE-----
[Your device certificate content]
-----END CERTIFICATE-----
)EOF";

const char* private_key = R"EOF(
-----BEGIN RSA PRIVATE KEY-----
[Your private key content]
-----END RSA PRIVATE KEY-----
)EOF";

#endif
```

### 4.2 Update ESP32 Code

Modify the integration code:

```cpp
#include <WiFiClientSecure.h>
#include <PubSubClient.h>
#include "certificates.h"

// WiFi credentials
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// AWS IoT Core endpoint
const char* mqtt_server = "xxxxxxxxxxxxxx-ats.iot.us-east-1.amazonaws.com";
const int mqtt_port = 8883;
const char* mqtt_client_id = "iot-toolkit-001";

WiFiClientSecure wifiClient;
PubSubClient client(wifiClient);

void setup() {
  Serial.begin(115200);
  
  // Configure TLS
  wifiClient.setCACert(ca_cert);
  wifiClient.setCertificate(client_cert);
  wifiClient.setPrivateKey(private_key);
  
  // Connect WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
  
  // Setup MQTT
  client.setServer(mqtt_server, mqtt_port);
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Connecting to AWS IoT...");
    
    if (client.connect(mqtt_client_id)) {
      Serial.println("connected");
    } else {
      Serial.print("failed, rc=");
      Serial.println(client.state());
      delay(5000);
    }
  }
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  
  // Publish sensor data
  static unsigned long lastMsg = 0;
  if (millis() - lastMsg > 10000) {
    lastMsg = millis();
    
    String payload = "{\"temperature\":25.5,\"humidity\":60.0}";
    client.publish("iot-toolkit/data", payload.c_str());
    Serial.println("Published to AWS IoT");
  }
}
```

### 4.3 Get AWS IoT Endpoint

1. In AWS IoT Core, go to **Settings**
2. Copy the **Endpoint** address
3. Replace `xxxxxxxxxxxxxx-ats.iot.us-east-1.amazonaws.com` in code

## Step 5: Create Rules (Optional)

Route data to storage or other services:

1. Go to **Message routing** > **Rules**
2. Click **Create rule**
3. **Name**: `SaveSensorData`
4. **SQL statement**:
   ```sql
   SELECT * FROM 'iot-toolkit/data'
   ```
5. **Actions**: Add action
   - **DynamoDB**: Store in database
   - **S3**: Store as files
   - **Lambda**: Process data
   - **CloudWatch**: Monitor metrics

## Step 6: Test Connection

### 6.1 MQTT Test Client

1. In AWS IoT Core, go to **Test** > **MQTT test client**
2. Subscribe to topic: `iot-toolkit/#`
3. Run ESP32 code
4. Verify messages appear

### 6.2 Monitor Device

1. Go to **Monitor** > **Things**
2. Select your device
3. View connection status and metrics

## Troubleshooting

### Connection Failed (-2)

**Cause**: TLS certificate issue

**Solutions**:
- Verify certificates are correct
- Check endpoint address
- Ensure private key is not corrupted

### Connection Failed (-4)

**Cause**: Network timeout

**Solutions**:
- Check WiFi connection
- Verify firewall allows port 8883
- Check AWS IoT endpoint is correct

### TLS Handshake Failed

**Cause**: Certificate mismatch

**Solutions**:
- Verify CA certificate is AmazonRootCA1.pem
- Check device certificate matches private key
- Regenerate certificates if needed

## Security Best Practices

1. **Rotate Certificates**: Regularly update device certificates
2. **Least Privilege Policy**: Restrict MQTT topic permissions
3. **Enable CloudWatch Logs**: Monitor connection attempts
4. **Use Device Shadows**: For device state management
5. **Enable Audit**: Regular security audits

## Cost Management

### Free Tier Limits
- 250,000 messages/month
- 500 things
- 1,000,000 device shadow updates

### Cost Optimization
- Batch sensor readings
- Use device shadows sparingly
- Monitor with CloudWatch (not too frequently)

## Next Steps

- Set up [data storage rules](https://docs.aws.amazon.com/iot/latest/developerguide/iot-ddb-rule.html)
- Create [dashboards with CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Console.html)
- Configure [alerts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
- Review [security best practices](https://docs.aws.amazon.com/iot/latest/developerguide/security-best-practices.html)
