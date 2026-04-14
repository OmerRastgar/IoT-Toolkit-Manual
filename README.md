# IoT Toolkit Manual

A comprehensive student guide for building and configuring ESP32-based IoT systems with sensors, displays, and cloud connectivity.

## Documentation

📚 **View the full documentation**: [https://omerRastgar.github.io/IoT-Toolkit-Manual](https://omerRastgar.github.io/IoT-Toolkit-Manual)

## Quick Start

- [Getting Started Guide](https://omerRastgar.github.io/IoT-Toolkit-Manual/getting-started/)
- [Hardware Assembly](https://omerRastgar.github.io/IoT-Toolkit-Manual/getting-started/assembly-guide/)
- [Complete Integration Code](https://omerRastgar.github.io/IoT-Toolkit-Manual/integration/complete-code/)

## What You'll Learn

This guide covers:

- **Hardware Setup**: ESP32, sensors, displays, and modules
- **Software Configuration**: Arduino IDE, libraries, and firmware
- **Integration**: Combining all components into a working system
- **Cloud Connectivity**: AWS IoT Core and self-hosted options
- **Troubleshooting**: Common issues and solutions

## Hardware Components

### Core
- ESP32 DevKit (WiFi-enabled microcontroller)

### Sensors
- Temperature sensor
- Humidity sensor
- Vibration/Accelerometer
- Acoustic/Sound sensor

### Displays
- LCD Display (16x2 or 20x4, I2C)
- TFT Display (color, SPI)

### Additional Modules
- I2C Multiplexer (TCA9548A)
- Voice Module
- Camera Module (ESP32-CAM)

### Communication
- WiFi (built-in)
- MQTT, HTTP, CoAP protocols

## Documentation Structure

```
docs/
├── index.md                    # Homepage
├── getting-started/            # Quick start guides
│   ├── prerequisites.md        # Software setup
│   ├── hardware-list.md        # Component list
│   └── assembly-guide.md       # Step-by-step assembly
├── hardware/                   # Hardware documentation
│   ├── esp32.md               # ESP32 setup
│   ├── sensors/               # Sensor guides
│   ├── displays/              # Display guides
│   ├── modules/               # Module guides
│   ├── communication/         # Protocol guides
│   └── wiring-diagrams.md     # Connection diagrams
├── software/                  # Software documentation
│   ├── firmware-setup.md      # Arduino IDE setup
│   ├── libraries.md           # Required libraries
│   └── code-examples.md       # Test code
├── integration/              # System integration
│   ├── complete-code.md       # Full system code
│   └── testing.md             # Testing procedures
├── cloud/                    # Cloud setup
│   ├── aws.md                 # AWS IoT Core
│   └── self-hosted.md         # Self-hosted server
├── troubleshooting/          # Problem solving
│   ├── hardware-issues.md     # Hardware problems
│   └── software-issues.md    # Software problems
└── resources/                # Additional resources
    ├── glossary.md            # Term definitions
    └── references.md          # Useful links
```

## Local Development

### Prerequisites

- Python 3.8+
- pip

### Install MkDocs

```bash
pip install mkdocs-material mkdocs-awesome-pages-plugin mkdocs-minify-plugin
```

### Run Locally

```bash
# Clone the repository
git clone https://github.com/OmerRastgar/IoT-Toolkit-Manual.git
cd IoT-Toolkit-Manual

# Serve locally
mkdocs serve

# Open browser to http://localhost:8000
```

### Build Site

```bash
mkdocs build
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

### Development Notes

- Content is extracted from `Copy of IoT Kit - Tehqiq.md`
- Sections without data are marked with `<!-- TODO: ... -->` comments
- All hardware documentation should be practical and student-friendly
- Code examples should be copy-paste ready for ESP32

## Project Structure

```
IoT-Toolkit-Manual/
├── .github/workflows/       # GitHub Actions for auto-deployment
├── .windsurf/             # Agent instructions and specifications
│   ├── AGENT.md           # AI agent instructions
│   └── SPEC.md            # Project specifications
├── docs/                  # Documentation source files
├── mkdocs.yml             # MkDocs configuration
├── requirements.txt       # Python dependencies
└── README.md              # This file
```

## Agent Instructions

For AI agents working on this project, see:
- [AGENT.md](.windsurf/AGENT.md) - Instructions for AI agents
- [SPEC.md](.windsurf/SPEC.md) - Detailed specifications

## License

This documentation is provided for educational purposes.

## Acknowledgments

Research done by Basil Khowaja and Vishal Raj for Dr Tariq Mumtaz Summer project.

## Support

- 📖 [Full Documentation](https://omerRastgar.github.io/IoT-Toolkit-Manual)
- 🐛 [GitHub Issues](https://github.com/OmerRastgar/IoT-Toolkit-Manual/issues)
- 💬 [Discussions](https://github.com/OmerRastgar/IoT-Toolkit-Manual/discussions)

---

**Made with ❤️ for students learning IoT**
