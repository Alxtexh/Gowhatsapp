# 🚀 GoWhatsApp Multi-Device Installer by AlxTexh

Welcome to the official installer for the [GoWhatsApp Multi-Device REST API](https://github.com/Alxtexh/Gowhatsapp), customized for quick deployment on any fresh VPS—no Docker needed.

---

## 🛠️ Features

- Prompts for custom API port and password
- Installs latest Go and dependencies
- Auto-configures `.env` file
- Opens selected port using UFW
- Cleans up leftover archives
- Detects your VPS public IP and displays server URL

---

## 📥 Installation Instructions

1. **Clone the repo**
   ```bash
    curl -O https://raw.githubusercontent.com/Alxtexh/Gowhatsapp/main/installgowhatsapp.sh
   chmod +x installgowhatsapp.sh
   ./installgowhatsapp.sh
  
