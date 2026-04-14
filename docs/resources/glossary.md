# Glossary

Definitions of common terms used in this documentation.

## A

**ADC** (Analog-to-Digital Converter)  
Converts analog signals (like sensor readings) to digital values. ESP32 has 12-bit ADCs.

**AWS IoT Core**  
Amazon Web Services managed cloud service for IoT device connectivity and data processing.

## B

**Baud Rate**  
Speed of serial communication in bits per second. Common: 9600, 115200.

**Binary**  
Number system using only 0 and 1. Used by computers for all operations.

**Boot Mode**  
ESP32 startup mode determined by GPIO0 state. Low=programming mode, High=normal mode.

**Breadboard**  
Prototyping board with interconnected holes for building circuits without soldering.

**Brownout**  
Condition when voltage drops below required level, causing ESP32 to reset.

## C

**Client**  
Device or program that requests services from a server. ESP32 is MQTT client.

**CoAP** (Constrained Application Protocol)  
Lightweight IoT protocol similar to HTTP but designed for constrained devices.

**Compile**  
Process of converting source code to machine-readable binary for the ESP32.

**COM Port**  
Communication port on Windows (e.g., COM3). Used for USB-to-serial connections.

**Core**  
Processing unit. ESP32 has two Xtensa LX6 cores.

## D

**DAC** (Digital-to-Analog Converter)  
Converts digital values to analog signals. ESP32 has 8-bit DACs.

**Datasheet**  
Technical document with detailed specifications for a component.

**DC** (Direct Current)  
Unidirectional electrical flow. ESP32 uses 3.3V DC.

**Deep Sleep**  
ESP32 low-power mode where most functions are disabled. Wake on timer or GPIO.

**Driver**  
Software that enables operating system to communicate with hardware.

## E

**ESP32**  
Low-cost, low-power system on a chip microcontroller with WiFi and Bluetooth.

**Endpoint**  
URL or address where cloud service accepts connections.

**ESD** (Electrostatic Discharge)  
Sudden flow of electricity that can damage electronic components.

## F

**Flash**  
Non-volatile memory for storing program code and data. ESP32 typically has 4MB.

**Firmware**  
Software programmed into hardware device. Arduino sketches are firmware.

## G

**GPIO** (General Purpose Input/Output)  
Programmable pins on ESP32 for various input/output functions.

**GND** (Ground)  
Common reference point in electrical circuits. 0V potential.

**Grafana**  
Open-source platform for data visualization and monitoring dashboards.

## H

**Hexadecimal**  
Base-16 number system using digits 0-9 and letters A-F. Often used for I2C addresses (e.g., 0x27).

**HTTP** (Hypertext Transfer Protocol)  
Protocol for transmitting data on the web. Uses request/response model.

**HTTPS**  
HTTP with TLS encryption for secure communication.

**Hz** (Hertz)  
Unit of frequency. I2C typically runs at 100kHz or 400kHz.

## I

**I2C** (Inter-Integrated Circuit)  
Two-wire serial bus for connecting sensors and displays (SDA and SCL lines).

**IDE** (Integrated Development Environment)  
Software for writing, compiling, and uploading code. Arduino IDE for ESP32.

**InfluxDB**  
Time-series database optimized for storing and querying time-stamped data.

**IP Address**  
Unique identifier for devices on a network (e.g., 192.168.1.100).

## J

**JSON** (JavaScript Object Notation)  
Lightweight data format for exchanging information between devices and servers.

**Jumper Wire**  
Short wire used for making connections on breadboard.

## K

**kΩ** (Kiloohm)  
Unit of electrical resistance. 1000 ohms. Pull-up resistors are typically 4.7kΩ.

## L

**Library**  
Collection of pre-written code for common functions (e.g., sensor drivers).

**LiPo** (Lithium Polymer)  
Type of rechargeable battery often used with ESP32 for portable projects.

**LoRa** (Long Range)  
Long-range, low-power wireless protocol. Not used in this toolkit (WiFi used instead).

## M

**mA** (Milliampere)  
Unit of electrical current. ESP32 typically uses 100-250mA when active.

**MAC Address**  
Unique hardware identifier for network devices.

**MQTT** (Message Queuing Telemetry Transport)  
Lightweight publish-subscribe messaging protocol ideal for IoT.

**Mosquitto**  
Open-source MQTT broker software.

**Multiplexer**  
Device that selects between multiple inputs/outputs. TCA9548A for I2C.

## N

**NTP** (Network Time Protocol)  
Protocol for synchronizing clocks over network.

## O

**Ohm**  
Unit of electrical resistance.

**OTA** (Over-The-Air)  
Method of updating firmware wirelessly without USB connection.

## P

**Payload**  
Actual data content of a message. In MQTT, the sensor readings are the payload.

**Pinout**  
Diagram showing function of each pin on a device.

**Pull-up Resistor**  
Resistor that pulls a signal line to high (3.3V) when not actively driven.

**PSRAM** (Pseudo-Static RAM)  
Additional memory on some ESP32 modules for storing larger data.

**PWM** (Pulse Width Modulation)  
Technique for simulating analog output using digital signals.

## Q

**QoS** (Quality of Service)  
MQTT feature controlling message delivery guarantees (0, 1, or 2).

## R

**RAM** (Random Access Memory)  
Volatile memory for program variables. ESP32 has 520KB SRAM.

**Reset**  
Restart of ESP32. Can be triggered by button, watchdog, or software.

**REST** (Representational State Transfer)  
Architectural style for designing networked applications using HTTP.

**RSSI** (Received Signal Strength Indicator)  
Measure of WiFi signal strength in dBm. Closer to 0 is better.

## S

**SDK** (Software Development Kit)  
Set of tools for developing applications. ESP32 Arduino Core is the SDK here.

**SDA** (Serial Data)  
I2C data line. Connects to GPIO21 on ESP32.

**SCL** (Serial Clock)  
I2C clock line. Connects to GPIO22 on ESP32.

**Sensor**  
Device that detects and responds to physical input (temperature, motion, etc.).

**Serial**  
Communication protocol for data exchange between devices. Uses TX/RX pins.

**SPI** (Serial Peripheral Interface)  
High-speed serial bus for displays and fast devices.

**SSID** (Service Set Identifier)  
Name of a WiFi network.

**SSL/TLS**  
Encryption protocols for secure network communication.

**Subscribe**  
In MQTT, to register interest in receiving messages from a topic.

## T

**TCP** (Transmission Control Protocol)  
Reliable, connection-oriented protocol used by MQTT and HTTP.

**TLS** (Transport Layer Security)  
Cryptographic protocol for secure communication. Successor to SSL.

**Topic**  
In MQTT, a hierarchical string that messages are published/subscribed to.

**TTL** (Transistor-Transistor Logic)  
Type of digital circuit. 3.3V or 5V logic levels.

## U

**UART** (Universal Asynchronous Receiver-Transmitter)  
Hardware for serial communication. Used for USB debugging.

**UDP** (User Datagram Protocol)  
Connectionless protocol used by CoAP. Faster but less reliable than TCP.

**Upload**  
Process of transferring compiled code from computer to ESP32.

**URL** (Uniform Resource Locator)  
Address of a resource on the internet.

**USB** (Universal Serial Bus)  
Standard for connecting peripherals. USB-to-serial for ESP32 programming.

## V

**VCC**  
Positive voltage supply pin (3.3V for ESP32).

**Volt**  
Unit of electrical potential difference. ESP32 operates at 3.3V.

## W

**Watchdog Timer**  
Hardware timer that resets ESP32 if program gets stuck.

**WiFi**  
Wireless networking technology. ESP32 has built-in WiFi support.

**Wiring Diagram**  
Visual representation of how components are connected.

## X

**XTAL** (Crystal Oscillator)  
Provides precise clock signal for ESP32 processor.

## See Also

- [References](references.md) - Useful links and datasheets
- [Hardware Guide](../hardware/index.md) - Component documentation
- [Troubleshooting](../troubleshooting/index.md) - Problem solving
