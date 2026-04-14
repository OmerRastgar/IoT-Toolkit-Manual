# IoT Toolkit Manual - Project Specification

## Document Purpose
This specification defines the complete requirements for the IoT Toolkit Manual MkDocs documentation site. Any agent working on this project must follow these specifications exactly.

## 1. Project Goal
Create a **practical, hands-on guide** for undergraduate students to:
- Assemble IoT hardware components
- Configure ESP32 microcontroller
- Connect and test individual sensors
- Set up LCD/TFT displays
- Configure WiFi communication (MQTT/HTTP/CoAP)
- Deploy to cloud (AWS IoT Core OR self-hosted)
- Troubleshoot common issues

## 2. Target Audience
- Undergraduate students with basic electronics knowledge
- First-time IoT toolkit users
- Students who need step-by-step guidance

## 3. Hardware Inventory

### 3.1 Microcontroller
| Component | Details |
|-----------|---------|
| ESP32 | WiFi-enabled microcontroller |
| Purpose | Main controller for all components |

### 3.2 Sensors
| Sensor | Type | Purpose |
|--------|------|---------|
| Temperature | Environmental | Measure ambient temperature |
| Humidity | Environmental | Measure relative humidity |
| Vibration/Accelerometer | Motion | Detect vibration patterns |
| Acoustic | Audio | Capture sound/noise data |

### 3.3 Displays
| Display | Interface | Purpose |
|---------|-----------|---------|
| LCD | I2C or Parallel | Basic text display |
| TFT | SPI | Color display for data visualization |

### 3.4 Additional Modules
| Module | Purpose |
|--------|---------|
| I2C Multiplexer | Resolve I2C address conflicts |
| Voice Module | Audio output/voice alerts |
| Camera Module | Image capture for monitoring |

### 3.5 Communication
| Protocol | Transport | Use Case |
|----------|-----------|----------|
| MQTT | WiFi/TCP | Primary IoT messaging |
| HTTP | WiFi/TCP | REST API integration |
| CoAP | WiFi/UDP | Lightweight IoT protocol |

## 4. Cloud Configuration Options

### 4.1 Option A: AWS IoT Core
- **Service**: AWS IoT Core managed service
- **Authentication**: X.509 certificates
- **Protocol**: MQTT over TLS
- **Features**: Device management, rules engine, data storage

### 4.2 Option B: Self-Hosted
- **MQTT Broker**: Eclipse Mosquitto
- **Database**: InfluxDB or PostgreSQL
- **Dashboard**: Grafana
- **Hosting**: Raspberry Pi or cloud VM

## 5. Documentation Structure

### 5.1 Directory Layout
```
docs/
├── index.md                          # Landing page
├── getting-started/
│   ├── index.md                      # Quick start
│   ├── prerequisites.md              # Tools & software
│   ├── hardware-list.md               # Component list with links
│   └── assembly-guide.md             # Physical assembly
├── hardware/
│   ├── index.md                      # Hardware overview
│   ├── esp32.md                      # ESP32 setup
│   ├── sensors/
│   │   ├── index.md                  # Sensors overview
│   │   ├── temperature.md            # Temperature sensor
│   │   ├── humidity.md               # Humidity sensor
│   │   ├── vibration.md              # Vibration sensor
│   │   └── acoustic.md               # Acoustic sensor
│   ├── displays/
│   │   ├── index.md                  # Displays overview
│   │   ├── lcd.md                    # LCD setup
│   │   └── tft.md                    # TFT setup
│   ├── modules/
│   │   ├── index.md                  # Modules overview
│   │   ├── i2c-multiplexer.md        # I2C multiplexer
│   │   ├── voice.md                  # Voice module
│   │   └── camera.md                 # Camera module
│   ├── communication/
│   │   ├── index.md                  # Protocols overview
│   │   ├── mqtt.md                   # MQTT configuration
│   │   ├── http.md                   # HTTP setup
│   │   └── coap.md                   # CoAP setup
│   └── wiring-diagrams.md            # Connection diagrams
├── software/
│   ├── index.md                      # Software overview
│   ├── firmware-setup.md             # ESP32 Arduino setup
│   ├── libraries.md                  # Required libraries
│   └── code-examples.md              # Individual sensor code
├── integration/
│   ├── index.md                      # Integration overview
│   ├── complete-code.md              # Full system code
│   └── testing.md                    # Testing procedures
├── cloud/
│   ├── index.md                      # Cloud overview
│   ├── aws.md                        # AWS IoT Core setup
│   └── self-hosted.md                # Self-hosted server
├── troubleshooting/
│   ├── index.md                      # Troubleshooting overview
│   ├── hardware-issues.md             # Hardware problems
│   └── software-issues.md           # Software problems
└── resources/
    ├── index.md                      # Resources
    ├── glossary.md                   # Terms & definitions
    └── references.md                 # Links & datasheets
```

### 5.2 Page Template
Each hardware page MUST include:
1. **Overview** - What this component does
2. **Specifications** - Technical specs (voltage, current, range, etc.)
3. **Pinout** - Connection diagram or table
4. **Wiring** - How to connect to ESP32
5. **Code** - Standalone test code (if available in source)
6. **Testing** - How to verify it works
7. **Troubleshooting** - Common issues (if available)

## 6. Data Extraction Rules

### 6.1 Source File
- **Path**: `d:\IOT Framework Manual\Copy of IoT Kit - Tehqiq.md`
- **Format**: Markdown
- **Size**: ~2MB (read in chunks)

### 6.2 Extraction Protocol
1. Search for component name in source file
2. If found → Extract relevant paragraphs
3. If not found → Add `<!-- TODO: Add [component] details -->`
4. Never invent or guess specifications

### 6.3 Content to IGNORE
- Research proposal narrative
- Literature review sections
- Academic significance statements
- Grant/funding information
- Timeline/Gantt charts
- References/bibliography
- Feasibility analysis

## 7. MkDocs Configuration

### 7.1 Theme
- **Name**: Material
- **Features**: 
  - Dark/Light mode toggle
  - Search functionality
  - Code highlighting
  - Admonitions (info/warning boxes)
  - Tables
  - Navigation tabs

### 7.2 Plugins
- `search` - Built-in search
- `minify` - Minify HTML
- `mkdocs-awesome-pages-plugin` - Navigation

### 7.3 Code Highlighting
- **Languages**: C++ (Arduino), Python, YAML, JSON
- **Theme**: Material theme syntax highlighting

## 8. Quality Checklist

Before marking complete, verify:
- [ ] All hardware components have dedicated pages
- [ ] Each page has wiring instructions
- [ ] ESP32 code examples use proper Arduino Core syntax
- [ ] Cloud sections cover both AWS and self-hosted
- [ ] No hallucinated specifications
- [ ] All missing data marked with TODO comments
- [ ] Navigation works in left sidebar
- [ ] Search indexes all content
- [ ] GitHub Actions deploys successfully

## 9. GitHub Integration

### 9.1 Repository
- **URL**: https://github.com/OmerRastgar/IoT-Toolkit-Manual
- **Branch**: main
- **Site**: GitHub Pages

### 9.2 Auto-Deployment
- Trigger: Push to main branch
- Workflow: `.github/workflows/ci.yml`
- Action: Deploy to GitHub Pages

## 10. Success Metrics

The project is complete when:
1. A new student can follow the guide without external help
2. All hardware components are documented
3. Code examples compile for ESP32
4. Both cloud options are documented
5. Site is live on GitHub Pages
6. No TODO comments remain (or documented why)

## 11. Contact & Questions

For clarifications, refer to:
1. This SPEC.md file
2. AGENT.md for workflow guidance
3. Original source file: `Copy of IoT Kit - Tehqiq.md`

---
**Version**: 1.0
**Last Updated**: 2024
**Status**: Implementation Ready
