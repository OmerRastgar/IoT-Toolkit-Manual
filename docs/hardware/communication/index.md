# Communication Protocols Overview

The IoT Toolkit supports three communication protocols over WiFi for cloud connectivity.

## Protocol Comparison

| Protocol | Transport | Use Case | Best For |
|----------|-----------|----------|----------|
| [MQTT](mqtt.md) | TCP | IoT messaging | Real-time telemetry, pub/sub |
| [HTTP](http.md) | TCP | REST APIs | Request/response, web services |
| [CoAP](coap.md) | UDP | Constrained IoT | Low-power, UDP networks |

## When to Use Each

### MQTT (Recommended)
- **Real-time monitoring**: Continuous sensor streams
- **Event-driven**: Alerts and notifications
- **Low bandwidth**: Efficient binary protocol
- **Bidirectional**: Device commands and telemetry

### HTTP
- **Web integration**: REST APIs, web services
- **Simplicity**: Widely understood, easy debugging
- **Compatibility**: Works with any web server
- **Request-based**: On-demand data fetching

### CoAP
- **Constrained environments**: Low-power devices
- **UDP networks**: NAT traversal, multicast
- **Efficiency**: Smaller overhead than HTTP
- **Proxy support**: HTTP/CoAP translation

## Protocol Selection Guide

```
Real-time monitoring?     --> MQTT
Web API integration?      --> HTTP
Low-power/UDP network?   --> CoAP
Unsure?                  --> Start with MQTT
```

## Quick Start

1. [MQTT Setup](mqtt.md) - Primary recommendation
2. [HTTP Setup](http.md) - For web service integration
3. [CoAP Setup](coap.md) - For specialized use cases

## Security Considerations

All protocols support:
- TLS/SSL encryption (MQTT over TLS, HTTPS)
- Authentication (username/password, certificates)
- Access control (topic permissions, API keys)

!!! tip "Security Best Practice"
    Always use encryption (TLS/SSL) for production deployments, even on local networks.

## Cloud Compatibility

| Protocol | AWS IoT Core | Self-Hosted |
|----------|--------------|-------------|
| MQTT | ✓ Native | ✓ Mosquitto |
| HTTP | ✓ API Gateway | ✓ Custom server |
| CoAP | ✗ Not supported | ✓ Custom broker |

## Next Steps

Choose your protocol and proceed to [cloud setup](../../cloud/index.md).
