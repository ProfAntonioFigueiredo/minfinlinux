#!/bin/bash

# =============================================================================
# INSTALAÇÃO DE DEPENDÊNCIAS ESPECÍFICAS - UBUNTU 24.04 LTS
# Treinamento Linux - Ministério das Finanças de Angola
# =============================================================================

echo "📦 INSTALANDO DEPENDÊNCIAS ESPECÍFICAS"
echo "====================================="
echo ""

# Verificar se está executando como usuário normal
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  ATENÇÃO: Execute como usuário normal, não como root!"
    exit 1
fi

echo "✅ Executando como usuário normal: $(whoami)"
echo ""

# Atualizar sistema
echo "🔄 Atualizando sistema..."
sudo apt update
echo "✅ Sistema atualizado"
echo ""

# Instalar dependências específicas para os exercícios
echo "📦 Instalando dependências específicas..."

# Pacotes para exercícios de rede
echo "📦 Instalando pacotes de rede..."
sudo apt install -y \
    ipcalc \
    sipcalc \
    nmap \
    tcpdump \
    wireshark-common \
    netcat-openbsd \
    traceroute \
    dnsutils \
    net-tools

# Pacotes para exercícios de segurança
echo "📦 Instalando pacotes de segurança..."
sudo apt install -y \
    auditd \
    audispd-plugins \
    fail2ban \
    ufw \
    iptables-persistent \
    rkhunter \
    chkrootkit \
    lynis

# Pacotes para exercícios de sistema
echo "📦 Instalando pacotes de sistema..."
sudo apt install -y \
    htop \
    tree \
    neofetch \
    screen \
    tmux \
    byobu

# Pacotes para exercícios de backup
echo "📦 Instalando pacotes de backup..."
sudo apt install -y \
    rsync \
    rsnapshot \
    duplicity \
    borgbackup

echo "✅ Dependências específicas instaladas"
echo ""

# Verificar instalação
echo "🔍 Verificando instalação..."
packages=("ipcalc" "nmap" "tcpdump" "auditd" "ufw" "htop" "tree" "rsync")
for package in "${packages[@]}"; do
    if command -v $package >/dev/null 2>&1; then
        echo "✅ $package - Instalado"
    else
        echo "❌ $package - Não instalado"
    fi
done
echo ""

echo "✅ Instalação de dependências concluída!"
echo "====================================="
