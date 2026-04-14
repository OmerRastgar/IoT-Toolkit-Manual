# IoT Certificate Generator (Self-Signed)
# Use this script to generate SSL certificates for Mosquitto on a VPS.

$IP = Read-Host "Enter the Public IP of your VPS (or Domain Name)"
if (-not $IP) { $IP = "localhost" }

Write-Host "Generating certificates for: $IP" -ForegroundColor Cyan

# Create directory if it doesn't exist
$CertPath = "./mosquitto/certs"
if (-not (Test-Path $CertPath)) { New-Item -ItemType Directory -Path $CertPath }

# Generate CA
openssl req -new -x509 -days 3650 -extensions v3_ca -keyout "$CertPath/ca.key" -out "$CertPath/ca.crt" -subj "/CN=IoT-CA" -nodes

# Generate Server Key & CSR
openssl genrsa -out "$CertPath/server.key" 2048
openssl req -new -out "$CertPath/server.csr" -key "$CertPath/server.key" -subj "/CN=$IP"

# Sign Server Certificate
openssl x509 -req -in "$CertPath/server.csr" -CA "$CertPath/ca.crt" -CAkey "$CertPath/ca.key" -CAcreateserial -out "$CertPath/server.crt" -days 3650

# Set Permissions (Simplified for Windows/Docker)
Write-Host "Certificates generated successfully in $CertPath" -ForegroundColor Green
Write-Host "1. Uncomment the SSL lines in mosquitto.conf" -ForegroundColor Yellow
Write-Host "2. Restart docker-compose" -ForegroundColor Yellow
