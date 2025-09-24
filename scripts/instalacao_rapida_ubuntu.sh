#!/bin/bash

# =============================================================================
# INSTALAÇÃO RÁPIDA - UBUNTU 24.04 LTS
# Treinamento Linux - Ministério das Finanças de Angola
# =============================================================================

echo "🚀 INSTALAÇÃO RÁPIDA - UBUNTU 24.04 LTS"
echo "======================================="
echo ""

# Verificar se está executando como usuário normal
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  ATENÇÃO: Execute como usuário normal, não como root!"
    echo "Execute: ./instalacao_rapida_ubuntu.sh"
    exit 1
fi

echo "✅ Executando como usuário normal: $(whoami)"
echo "📍 Diretório atual: $(pwd)"
echo "🕐 Data/Hora: $(date)"
echo ""

# Atualizar sistema
echo "🔄 Atualizando sistema..."
sudo apt update && sudo apt upgrade -y
echo "✅ Sistema atualizado"
echo ""

# Instalar pacotes essenciais em lote
echo "📦 Instalando pacotes essenciais..."

# Pacotes básicos
echo "📦 Instalando pacotes básicos..."
sudo apt install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    tree \
    htop \
    neofetch \
    unzip \
    zip \
    tar \
    gzip \
    bzip2 \
    xz-utils

# Pacotes de rede
echo "📦 Instalando pacotes de rede..."
sudo apt install -y \
    net-tools \
    iputils-ping \
    traceroute \
    dnsutils \
    netcat-openbsd \
    tcpdump \
    wireshark-common \
    nmap \
    nmap-common \
    netdiscover \
    arp-scan \
    iftop \
    nload \
    iperf3 \
    ipcalc \
    sipcalc

# Pacotes de segurança
echo "📦 Instalando pacotes de segurança..."
sudo apt install -y \
    auditd \
    audispd-plugins \
    libpam-pwquality \
    fail2ban \
    ufw \
    iptables-persistent \
    rkhunter \
    chkrootkit \
    lynis \
    aide

# Pacotes de desenvolvimento
echo "📦 Instalando pacotes de desenvolvimento..."
sudo apt install -y \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    nodejs \
    npm \
    golang-go \
    rustc \
    cargo \
    openjdk-17-jdk \
    maven \
    gradle

# Pacotes de sistema
echo "📦 Instalando pacotes de sistema..."
sudo apt install -y \
    systemd \
    systemd-timesyncd \
    rsyslog \
    logrotate \
    cron \
    at \
    screen \
    tmux \
    byobu

# Pacotes de virtualização
echo "📦 Instalando pacotes de virtualização..."
sudo apt install -y \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    virt-manager \
    virt-viewer \
    libguestfs-tools \
    vagrant

# Pacotes de backup
echo "📦 Instalando pacotes de backup..."
sudo apt install -y \
    rsync \
    rsnapshot \
    duplicity \
    borgbackup \
    restic

# Pacotes de monitoramento
echo "📦 Instalando pacotes de monitoramento..."
sudo apt install -y \
    prometheus \
    grafana \
    elasticsearch \
    logstash \
    kibana \
    filebeat \
    metricbeat \
    packetbeat

# Pacotes de rede avançados
echo "📦 Instalando pacotes de rede avançados..."
sudo apt install -y \
    bind9 \
    bind9utils \
    bind9-doc \
    isc-dhcp-server \
    apache2 \
    nginx \
    postfix \
    dovecot-core \
    dovecot-imapd \
    dovecot-pop3d \
    samba \
    nfs-kernel-server \
    openldap \
    slapd \
    ldap-utils \
    chrony

# Pacotes de análise forense
echo "📦 Instalando pacotes de análise forense..."
sudo apt install -y \
    sleuthkit \
    autopsy \
    volatility3 \
    bulk-extractor \
    scalpel \
    foremost

echo "✅ Todos os pacotes instalados"
echo ""

# Configurar usuário para grupos necessários
echo "👥 Configurando grupos de usuário..."
sudo usermod -a -G sudo,docker,libvirt,kvm,vboxusers $USER
echo "✅ Usuário adicionado aos grupos necessários"
echo ""

# Configurar aliases úteis
echo "🔧 Configurando aliases úteis..."
cat >> ~/.bashrc << 'EOF'

# Aliases para Treinamento Linux - MINFIN Angola
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Aliases de rede
alias myip='ip addr show | grep "inet " | grep -v 127.0.0.1'
alias ports='netstat -tuln'
alias connections='ss -tuln'

# Aliases de sistema
alias processes='ps aux'
alias topmem='ps aux --sort=-%mem | head -10'
alias topcpu='ps aux --sort=-%cpu | head -10'
alias services='systemctl list-units --type=service --state=active'

# Aliases de segurança
alias sudolog='sudo tail -f /var/log/auth.log'
alias fail2ban='sudo fail2ban-client status'

# Aliases de treinamento
alias treinamento='cd ~/treinamento-linux'
alias exercicios='cd ~/treinamento-linux/exercicios'
alias apresentacoes='cd ~/treinamento-linux/apresentacoes'

# Aliases de rede avançados
alias netinfo='ip addr show && echo "---" && ip route show'
alias dnsinfo='cat /etc/resolv.conf'
alias firewall='sudo ufw status verbose'
EOF

echo "✅ Aliases configurados"
echo ""

# Criar diretórios de trabalho
echo "📁 Criando diretórios de trabalho..."
mkdir -p ~/treinamento-linux/{exercicios,apresentacoes,logs,backups,projetos}
mkdir -p ~/treinamento-linux/exercicios/{modulo1,modulo2,modulo3,modulo4,modulo5,modulo6}
mkdir -p ~/treinamento-linux/projetos/{dimdim-bank,empresa-teste,lab-rede}

echo "✅ Diretórios de trabalho criados"
echo ""

# Configurar Git
echo "🔧 Configurando Git..."
git config --global user.name "Aluno Treinamento Linux"
git config --global user.email "aluno@minfin.gov.ao"
git config --global init.defaultBranch main
git config --global pull.rebase false

echo "✅ Git configurado"
echo ""

# Configurar firewall básico
echo "🔥 Configurando firewall básico..."
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable

echo "✅ Firewall configurado"
echo ""

# Configurar serviços essenciais
echo "⚙️  Configurando serviços essenciais..."
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl enable chrony
sudo systemctl start chrony
sudo systemctl enable auditd
sudo systemctl start auditd
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

echo "✅ Serviços configurados"
echo ""

# Criar usuários de teste
echo "👥 Criando usuários de teste..."
sudo useradd -m -s /bin/bash aluno1 2>/dev/null || echo "Usuário aluno1 já existe"
sudo useradd -m -s /bin/bash aluno2 2>/dev/null || echo "Usuário aluno2 já existe"
sudo useradd -m -s /bin/bash professor 2>/dev/null || echo "Usuário professor já existe"

echo "aluno1:123456" | sudo chpasswd 2>/dev/null
echo "aluno2:123456" | sudo chpasswd 2>/dev/null
echo "professor:123456" | sudo chpasswd 2>/dev/null

echo "✅ Usuários de teste criados"
echo ""

# Criar grupos de teste
echo "👥 Criando grupos de teste..."
sudo groupadd administradores 2>/dev/null || echo "Grupo administradores já existe"
sudo groupadd desenvolvedores 2>/dev/null || echo "Grupo desenvolvedores já existe"
sudo groupadd operadores 2>/dev/null || echo "Grupo operadores já existe"

sudo usermod -aG administradores professor 2>/dev/null
sudo usermod -aG desenvolvedores aluno1 2>/dev/null
sudo usermod -aG operadores aluno2 2>/dev/null

echo "✅ Grupos de teste criados"
echo ""

# Criar script de verificação
echo "🔧 Criando script de verificação..."
cat > ~/treinamento-linux/verificar_ambiente.sh << 'EOF'
#!/bin/bash
# Script de verificação do ambiente - Treinamento Linux MINFIN Angola

echo "🔍 VERIFICANDO AMBIENTE DE TREINAMENTO"
echo "====================================="

# Verificar sistema
echo "📊 Informações do Sistema:"
echo "Sistema: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"
echo "Arquitetura: $(uname -m)"
echo "Uptime: $(uptime -p)"
echo ""

# Verificar pacotes instalados
echo "📦 Pacotes Essenciais:"
packages=("curl" "wget" "git" "vim" "nano" "tree" "htop" "nmap" "tcpdump" "auditd" "ufw" "ipcalc")
for package in "${packages[@]}"; do
    if dpkg -l | grep -q "^ii  $package "; then
        echo "✅ $package - Instalado"
    else
        echo "❌ $package - Não instalado"
    fi
done
echo ""

# Verificar serviços
echo "🔧 Serviços:"
services=("auditd" "ufw" "ssh" "chrony")
for service in "${services[@]}"; do
    if systemctl is-active --quiet $service; then
        echo "✅ $service - Ativo"
    else
        echo "❌ $service - Inativo"
    fi
done
echo ""

# Verificar permissões
echo "🔐 Permissões:"
if groups | grep -q sudo; then
    echo "✅ Usuário no grupo sudo"
else
    echo "❌ Usuário não está no grupo sudo"
fi

if groups | grep -q docker; then
    echo "✅ Usuário no grupo docker"
else
    echo "❌ Usuário não está no grupo docker"
fi
echo ""

# Verificar conectividade
echo "🌐 Conectividade:"
if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    echo "✅ Conectividade com Internet"
else
    echo "❌ Sem conectividade com Internet"
fi

if ping -c 1 google.com >/dev/null 2>&1; then
    echo "✅ Resolução DNS funcionando"
else
    echo "❌ Problema com resolução DNS"
fi
echo ""

# Verificar diretórios
echo "📁 Diretórios de Trabalho:"
if [ -d ~/treinamento-linux ]; then
    echo "✅ Diretório de treinamento criado"
    echo "Conteúdo: $(ls ~/treinamento-linux)"
else
    echo "❌ Diretório de treinamento não encontrado"
fi
echo ""

echo "✅ Verificação concluída!"
EOF

chmod +x ~/treinamento-linux/verificar_ambiente.sh
echo "✅ Script de verificação criado"
echo ""

# Executar verificação final
echo "🔍 Executando verificação final..."
~/treinamento-linux/verificar_ambiente.sh

echo ""
echo "🎉 INSTALAÇÃO RÁPIDA CONCLUÍDA COM SUCESSO!"
echo "=========================================="
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Reinicie o terminal ou execute: source ~/.bashrc"
echo "2. Navegue para: cd ~/treinamento-linux"
echo "3. Execute: ./verificar_ambiente.sh"
echo "4. Comece o treinamento!"
echo ""
echo "📚 RECURSOS DISPONÍVEIS:"
echo "- Verificação: ~/treinamento-linux/verificar_ambiente.sh"
echo "- Diretórios: ~/treinamento-linux/{exercicios,apresentacoes,projetos}"
echo "- Usuários de teste: aluno1, aluno2, professor (senha: 123456)"
echo ""
echo "✅ Ambiente Ubuntu 24.04 LTS pronto para o treinamento Linux!"
