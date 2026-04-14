# AI Agent Instructions - IoT Toolkit Manual

## Project Overview
This is a **practical student guide** for setting up an IoT Toolkit using ESP32, sensors, displays, and cloud connectivity. This is NOT research documentation.

## Critical Rules

### 1. Data Source Rule
- **ONLY** extract data from: `Copy of IoT Kit - Tehqiq.md`
- **NEVER** hallucinate or invent specifications, pinouts, or code
- If data is **NOT present** in the source file → Leave that section **BLANK** with a TODO comment
- Do NOT guess sensor models, pin connections, or configurations

### 2. Hardware Components
From the source file, extract info for:
- **Microcontroller**: ESP32
- **Sensors**: Temperature, Humidity, Vibration, Acoustic
- **Displays**: LCD, TFT (separate pages)
- **Modules**: I2C Multiplexer, Voice Module, Camera Module
- **Communication**: WiFi with MQTT, HTTP, CoAP protocols

### 3. Cloud Options
Two methods must be documented:
1. **AWS IoT Core** - Managed cloud service
2. **Self-Hosted** - MQTT broker (Mosquitto) on Raspberry Pi/VM

### 4. Page Structure
Each hardware page must follow this template:
```markdown
# [Component Name]

## Overview
[Extract from source or leave blank]

## Specifications
[Extract from source or leave blank]

## Wiring
[Extract from source or leave blank]

## Code Example
[ESP32 Arduino code - only if present in source]

## Troubleshooting
[Extract from source or leave blank]
```

### 5. What NOT to Include
- ❌ Research proposal content
- ❌ Feasibility studies
- ❌ Literature review sections
- ❌ Grant/funding information
- ❌ 10-week timeline breakdown
- ❌ Academic objectives or significance
- ❌ LoRa/LoRaWAN documentation

### 6. MkDocs Site Structure
```
docs/
├── index.md
├── getting-started/
├── hardware/
│   ├── esp32.md
│   ├── sensors/
│   ├── displays/
│   ├── modules/
│   └── communication/
├── software/
├── integration/
├── cloud/
└── troubleshooting/
```

### 7. Before Making Changes
1. Read `Copy of IoT Kit - Tehqiq.md` to check if data exists
2. If data exists → Extract and format it properly
3. If data missing → Add `<!-- TODO: Add [topic] details from source -->`
4. Never invent technical specifications

### 8. Code Standards
- All code must be for **ESP32 Arduino Core**
- Include required libraries at top of code blocks
- Add comments explaining each section
- Use proper markdown code blocks with `cpp` language tag

### 9. Git Workflow
- Commit after each section completion
- Use descriptive commit messages
- Push regularly to GitHub

## Source File Location
`d:\IOT Framework Manual\Copy of IoT Kit - Tehqiq.md`

## Output Location
All documentation files go in: `d:\IOT Framework Manual\docs\`

## Questions?
If unclear about requirements, check `SPEC.md` for detailed specifications.
