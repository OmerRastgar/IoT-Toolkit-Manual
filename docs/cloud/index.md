# Cloud Setup Overview

Connect your IoT Toolkit to the cloud for remote monitoring and data storage.

## Cloud Options

Two deployment methods are supported:

<div class="grid cards" markdown>

-   :material-cloud: **AWS IoT Core**

    ---

    Managed cloud service with enterprise features
    
    - X.509 certificate authentication
    - Automatic scaling
    - Rules engine for data processing
    - Integration with AWS services
    
    [Setup Guide](aws.md)

-   :material-server: **Self-Hosted**

    ---

    Full control with open-source tools
    
    - MQTT broker (Mosquitto)
    - Database (InfluxDB/PostgreSQL)
    - Dashboard (Grafana)
    - No monthly fees
    
    [Setup Guide](self-hosted.md)

</div>

## Comparison

| Feature | AWS IoT Core | Self-Hosted |
|---------|--------------|-------------|
| Cost | Pay per use | Hardware/VM cost only |
| Maintenance | Managed by AWS | Self-maintained |
| Scalability | Automatic | Manual scaling |
| Security | Enterprise-grade | Depends on setup |
| Learning Curve | Medium | Higher |
| Data Control | AWS cloud | Your infrastructure |

## Which to Choose?

### Choose AWS IoT Core if:
- You want managed service
- You need enterprise security
- You're already using AWS
- You want to focus on application, not infrastructure

### Choose Self-Hosted if:
- You want full control
- You have privacy requirements
- You want to minimize ongoing costs
- You enjoy server administration

## Quick Start

### AWS IoT Core Path
1. [Create AWS Account](aws.md)
2. [Set up IoT Core](aws.md)
3. [Configure ESP32 certificates](aws.md)
4. [Create rules for data storage](aws.md)

### Self-Hosted Path
1. [Launch the IoT Toolkit Stack (Docker)](self-hosted.md#option-c-zero-touch-docker-setup-recommended)
2. [Verify Zero-Touch Authentication](self-hosted.md)
3. [Configure ESP32 Local Server IP](self-hosted.md)
4. [View data in InfluxDB](self-hosted.md)

## Protocol Support

| Protocol | AWS IoT Core | Self-Hosted |
|----------|--------------|-------------|
| MQTT | ✓ Native | ✓ Mosquitto |
| MQTT over TLS | ✓ Port 8883 | ✓ Configurable |
| HTTP | ✓ API Gateway | ✓ Custom |
| CoAP | ✗ Not supported | ✓ Custom broker |

## Security Considerations

### Always Use:
- TLS encryption (MQTT over TLS)
- Strong authentication (certificates or API keys)
- Unique client IDs
- Regular credential rotation

### Never:
- Send data unencrypted
- Use default passwords
- Expose MQTT broker to internet without authentication
- Hardcode credentials in code (use configuration files)

## Data Flow

```
ESP32 → WiFi → Internet → Cloud Service → Database → Dashboard
   ↓
Sensors → MQTT/HTTP → TLS Encryption → Storage → Visualization
```

## Monitoring

### Metrics to Track
- Connection status (online/offline)
- Message count
- Data latency
- Sensor battery (if applicable)
- Error rates

### Alerts
Set up notifications for:
- Device disconnection
- Sensor reading anomalies
- System errors
- Security events

## Cost Estimation

### AWS IoT Core (Estimated)
| Usage Level | Monthly Cost |
|-------------|--------------|
| Low (1 device, 1 msg/min) | $1-5 |
| Medium (5 devices, 1 msg/sec) | $10-20 |
| High (25 devices, 10 msg/sec) | $50-100 |

### Self-Hosted (Development)
For students and developers, you can run the entire IoT stack on your **Personal Computer** using **Docker**. This approach has **zero cost** and is ideal for learning, testing, and rapid development.

- [Docker Setup Guide](self-hosted.md#option-c-zero-touch-docker-setup-recommended)


## Next Steps

- [AWS IoT Core Setup](aws.md)
- [Self-Hosted Setup](self-hosted.md)
- [Troubleshooting](../troubleshooting/index.md)
