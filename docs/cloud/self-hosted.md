# Self-Hosted Server Setup

Set up your own MQTT broker, database, and dashboard.

## Architecture

```
┌─────────────┐
│   ESP32     │──WiFi──┐
└─────────────┘        │
                       ▼
              ┌─────────────────┐
              │  MQTT Broker    │
              │  (Mosquitto)    │
              │  Port 1883/8883 │
              └────────┬────────┘
                       │
         ┌─────────────┼─────────────┐
         ▼             ▼             ▼
    ┌────────┐   ┌────────┐   ┌──────────┐
    │InfluxDB│   │PostgreSQL│   │ Grafana  │
    │(TSDB)  │   │(Relational)│   │Dashboard │
    └────────┘   └────────┘   └──────────┘
```

## Option A: Raspberry Pi Setup

### Hardware Requirements
- Raspberry Pi 4 (2GB+ RAM recommended)
- MicroSD card (32GB+)
- Power supply
- Ethernet connection (recommended)

### Step 1: Install Raspberry Pi OS

1. Download [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
2. Flash Raspberry Pi OS Lite (64-bit)
3. Boot and configure:
   ```bash
   sudo raspi-config
   # Enable SSH
   # Set hostname: iot-server
   ```

### Step 2: Install Mosquitto MQTT Broker

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Mosquitto
sudo apt install -y mosquitto mosquitto-clients

# Enable and start service
sudo systemctl enable mosquitto
sudo systemctl start mosquitto

# Test installation
mosquitto_pub -t test -m "Hello MQTT"
mosquitto_sub -t test
```

### Step 3: Configure Mosquitto

Create configuration file:

```bash
sudo nano /etc/mosquitto/mosquitto.conf
```

Add configuration:

```
# Basic settings
listener 1883
protocol mqtt

# Persistence
persistence true
persistence_location /var/lib/mosquitto/

# Logging
log_dest file /var/log/mosquitto/mosquitto.log
log_type error
log_type warning
log_type information

# Security (basic)
allow_anonymous true  # Change to false for production

# For TLS (optional)
# listener 8883
# certfile /etc/mosquitto/certs/server.crt
# keyfile /etc/mosquitto/certs/server.key
# cafile /etc/mosquitto/certs/ca.crt
```

Restart Mosquitto:
```bash
sudo systemctl restart mosquitto
```

### Step 4: Install InfluxDB (Time Series Database)

```bash
# Add InfluxDB repository
curl -sL https://repos.influxdata.com/influxdb.key | gpg --dearmor | sudo tee /usr/share/keyrings/influxdb-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/influxdb-archive-keyring.gpg] https://repos.influxdata.com/debian stable main" | sudo tee /etc/apt/sources.list.d/influxdb.list

# Install
sudo apt update
sudo apt install -y influxdb2

# Start service
sudo systemctl enable influxdb
sudo systemctl start influxdb
```

Access InfluxDB web UI at `http://raspberry-pi-ip:8086`

### Step 5: Install Grafana

```bash
# Add Grafana repository
curl -sL https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

# Install
sudo apt update
sudo apt install -y grafana

# Start service
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
```

Access Grafana at `http://raspberry-pi-ip:3000`
- Default login: admin/admin

## Option B: Cloud VM Setup

Use a cloud provider (AWS, GCP, Azure, DigitalOcean) for always-online server.

### Recommended: DigitalOcean Droplet

1. Create Ubuntu 22.04 droplet ($5/month)
2. SSH into server
3. Follow Raspberry Pi steps above

### Option C: System Topology

The on-premise stack follows a centralized "Data Integration Hub" pattern, where Node-RED serves as the primary normalization layer for all incoming IoT data.

![System Architecture](../assets/images/toolkit/architecture.png)

This architecture allows you to test multiple protocols (MQTT, HTTP, CoAP) simultaneously and route them all into a single InfluxDB temporal database.

### Pre-Configured Infrastructure

For a fast and robust setup, we have provided a pre-configured Docker environment in the repo. This includes a synchronized MQTT Broker, Node-RED engine, and InfluxDB database.

### 📁 Stack Location
Everything you need is located in the root of this repository:
[**onprem-docker/**](../../onprem-docker/)

### 📊 Supported Communication Methods
This stack is designed to handle multiple IoT protocols simultaneously, making it ideal for testing different ESP32 configurations:

| Method | Protocol | Port | Description |
| :--- | :--- | :--- | :--- |
| **MQTT (Local)** | MQTT | `1883` | Standard, non-encrypted communication for local labs. |
| **MQTT (Secure)** | MQTT/SSL | `8883` | Encrypted communication for VPS/Cloud deployments. |
| **HTTP REST** | HTTP | `1880` | Use Node-RED as a web server to receive POST data. |
| **CoAP** | CoAP/UDP | `5683` | Low-power, UDP-based transfers for constrained devices. |

### 🚀 Launch Instructions

1.  Navigate to the `onprem-docker/` folder.
2.  Start the services:
    ```bash
    docker-compose up -d
    ```
3.  Access the dashboards:
    - **Node-RED**: [http://localhost:1880](http://localhost:1880) (Central Logic Hub)
    - **InfluxDB**: [http://localhost:8086](http://localhost:8086) (Time-Series Data)

### 🔐 Security for VPS
If you are deploying this on a VPS, use the provided certificate generator:
1.  Run `.\generate_certs.ps1` (Windows) inside the `onprem-docker` folder.
2.  Enable the secure listener in `mosquitto/config/mosquitto.conf`.

---

## Configure ESP32

### Update MQTT Settings

```cpp
const char* mqtt_server = "raspberry-pi-ip-or-hostname";  // Or cloud VM IP
const int mqtt_port = 1883;
const char* mqtt_client_id = "iot-toolkit-001";

// Optional: Add authentication
const char* mqtt_user = "your-username";
const char* mqtt_pass = "your-password";

// In connection:
client.connect(mqtt_client_id, mqtt_user, mqtt_pass)
```

### Topic Structure

```
iot-toolkit/
├── data/           # Sensor readings
│   ├── temperature
│   ├── humidity
│   ├── vibration
│   └── acoustic
├── status/         # Device status
│   └── connection
└── commands/       # Remote commands
    └── config
```

## Data Pipeline

### Bridge MQTT to InfluxDB

Option 1: Telegraf
```bash
sudo apt install telegraf
```

Configure `/etc/telegraf/telegraf.conf`:
```toml
[[inputs.mqtt_consumer]]
  servers = ["tcp://localhost:1883"]
  topics = ["iot-toolkit/data"]
  data_format = "json"

[[outputs.influxdb_v2]]
  urls = ["http://localhost:8086"]
  token = "your-influxdb-token"
  organization = "iot-toolkit"
  bucket = "sensor-data"
```

Option 2: Python script
```python
import paho.mqtt.client as mqtt
from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS

# InfluxDB setup
client = InfluxDBClient(url="http://localhost:8086", token="token")
write_api = client.write_api(write_options=SYNCHRONOUS)

# MQTT callback
def on_message(client, userdata, msg):
    data = json.loads(msg.payload)
    point = Point("sensors") \
        .tag("device", "iot-toolkit-001") \
        .field("temperature", data["temperature"]) \
        .field("humidity", data["humidity"])
    write_api.write(bucket="sensor-data", record=point)

mqtt_client = mqtt.Client()
mqtt_client.on_message = on_message
mqtt_client.connect("localhost", 1883)
mqtt_client.subscribe("iot-toolkit/data")
mqtt_client.loop_forever()
```

## Grafana Dashboard

### 1. Add InfluxDB Data Source

1. Login to Grafana
2. Configuration > Data Sources > Add
3. Select InfluxDB
4. URL: `http://influxdb:8086`
5. Organization: `iot-toolkit`
6. Token: Your InfluxDB token
7. Bucket: `sensor-data`

### 2. Create Dashboard

1. Create > Dashboard
2. Add Panel
3. Query: `from(bucket: "sensor-data") |> range(start: -1h) |> filter(fn: (r) => r._measurement == "sensors")`
4. Choose visualization (Graph, Gauge, etc.)
5. Save dashboard

### Sample Panels

- Temperature graph (time series)
- Humidity gauge (current value)
- Vibration heatmap
- Acoustic level bar chart
- Device status table

## Security

### Basic Authentication

```bash
# Create password file
sudo mosquitto_passwd -c /etc/mosquitto/passwd username

# Update config
sudo nano /etc/mosquitto/mosquitto.conf
# Add:
allow_anonymous false
password_file /etc/mosquitto/passwd

sudo systemctl restart mosquitto
```

### Firewall

```bash
# Allow MQTT
sudo ufw allow 1883/tcp
sudo ufw allow 8883/tcp  # For TLS

# Allow web interfaces
sudo ufw allow 8086/tcp  # InfluxDB
sudo ufw allow 3000/tcp  # Grafana

# Deny everything else
sudo ufw enable
```

### TLS/SSL (Production)

Use Let's Encrypt or self-signed certificates:

```bash
# Generate self-signed cert
openssl req -new -x509 -days 365 -nodes -out mosquitto.crt -keyout mosquitto.key

# Configure Mosquitto for TLS
listener 8883
certfile /etc/mosquitto/certs/mosquitto.crt
keyfile /etc/mosquitto/certs/mosquitto.key
```

## Maintenance

### Regular Tasks

| Task | Frequency | Command |
|------|-----------|---------|
| Update packages | Weekly | `sudo apt update && sudo apt upgrade` |
| Backup database | Daily | `influx backup` |
| Check logs | Daily | `sudo journalctl -u mosquitto` |
| Clean old data | Monthly | InfluxDB retention policy |

### Monitoring

Check services:
```bash
sudo systemctl status mosquitto
sudo systemctl status influxdb
sudo systemctl status grafana-server
```

## Troubleshooting

### Mosquitto Won't Start

```bash
# Check config
sudo mosquitto -c /etc/mosquitto/mosquitto.conf -v

# Check logs
sudo tail -f /var/log/mosquitto/mosquitto.log
```

### Can't Connect from ESP32

- Check firewall rules
- Verify port 1883 is open
- Check Mosquitto is listening: `sudo netstat -tlnp | grep 1883`

### No Data in InfluxDB

- Check Telegraf logs: `sudo journalctl -u telegraf`
- Verify MQTT topic subscription
- Check InfluxDB token

## Next Steps

- Configure [alerting in Grafana](https://grafana.com/docs/grafana/latest/alerting/)
- Set up [data retention policies](https://docs.influxdata.com/influxdb/v2.0/reference/influxql/retention-policies/)
- Add [more sensors](../hardware/sensors/index.md)
- Review [troubleshooting guide](../troubleshooting/index.md)
