#!/bin/bash

set -e

echo ""
echo "🚀 Welcome to Go-WhatsApp installation by AlxTexh"
echo "==============================================="
echo ""

# Prompt for custom port and password
read -p "Enter the port you want to use (default 3000): " APP_PORT
APP_PORT=${APP_PORT:-3000}

read -p "Enter your desired password: " APP_PASSWORD

# Update system
apt update && apt upgrade -y

# Install dependencies
apt install -y git curl ffmpeg libvips-dev make ufw wget tar

# Install latest Go
GO_VERSION="1.22.3"
cd /usr/local
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin
source ~/.bashrc
rm go${GO_VERSION}.linux-amd64.tar.gz

# Clone the repo
git clone https://github.com/dimaskiddo/go-whatsapp-multidevice-rest.git /opt/gowhatsapp
cd /opt/gowhatsapp

# Clean up any zip or rar files
find . -type f \( -iname "*.zip" -o -iname "*.rar" \) -exec rm -f {} \;

# Copy and update .env
cp .env.example .env
sed -i "s/^APP_PORT=.*/APP_PORT=${APP_PORT}/" .env
sed -i "s/^APP_PASSWORD=.*/APP_PASSWORD=${APP_PASSWORD}/" .env

# Install Go tools
go install github.com/markbates/pkger/cmd/pkger@latest
go install github.com/swaggo/swag/cmd/swag@latest

# Build the app
make docs
make build

# Open port with ufw
ufw allow ${APP_PORT}/tcp || echo "⚠️  UFW rule failed. You may need to manually allow port ${APP_PORT}."

# Detect public IP
PUBLIC_IP=$(curl -s ifconfig.me || curl -s ipinfo.io/ip)

# Run the app
./go-whatsapp-multidevice-rest &

# Final message
echo ""
echo "✅ Installation complete!"
echo "🌐 Your WhatsApp API server is running at:"
echo "👉 http://${PUBLIC_IP}:${APP_PORT}/api/v1/whatsapp"
echo ""
echo "💡 We develop systems and offer rental billing system for ISPs from as low as 500/-"
echo "📞 Powered by AlxTexh"
echo ""