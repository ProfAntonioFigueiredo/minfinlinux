#!/bin/bash

# =============================================================================
# SCRIPT DE PREPARAÇÃO DO AMBIENTE UBUNTU 24.04 LTS
# Treinamento Linux - Ministério das Finanças de Angola
# =============================================================================

echo "🐧 PREPARANDO AMBIENTE UBUNTU 24.04 LTS PARA TREINAMENTO LINUX"
echo "=============================================================="
echo ""

# Verificar se está executando como root
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  ATENÇÃO: Este script deve ser executado como usuário normal, não como root!"
    echo "Execute: ./preparar_ambiente_ubuntu.sh"
    exit 1
fi

echo "✅ Executando como usuário normal: $(whoami)"
echo "📍 Diretório atual: $(pwd)"
echo "🕐 Data/Hora: $(date)"
echo ""

# Verificar versão do Ubuntu
echo "🔍 Verificando versão do Ubuntu:"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Sistema: $PRETTY_NAME"
    echo "Versão: $VERSION"
    echo "Código: $VERSION_CODENAME"
    
    if [ "$VERSION_CODENAME" != "noble" ]; then
        echo "⚠️  ATENÇÃO: Este script foi otimizado para Ubuntu 24.04 LTS (Noble Numbat)"
        echo "Sua versão: $VERSION_CODENAME"
        echo "Continuando mesmo assim..."
    fi
else
    echo "❌ Não foi possível detectar a versão do Ubuntu"
    exit 1
fi
echo ""

# Atualizar lista de pacotes
echo "📦 Atualizando lista de pacotes..."
sudo apt update
if [ $? -eq 0 ]; then
    echo "✅ Lista de pacotes atualizada com sucesso"
else
    echo "❌ Erro ao atualizar lista de pacotes"
    exit 1
fi
echo ""

# Instalar pacotes essenciais para o treinamento
echo "📦 Instalando pacotes essenciais para o treinamento..."

# Pacotes básicos
PACKAGES_BASIC="
curl
wget
git
vim
nano
tree
htop
net-tools
iputils-ping
traceroute
dnsutils
netcat-openbsd
tcpdump
wireshark-common
"

# Pacotes de rede
PACKAGES_NETWORK="
ipcalc
nmap
nmap-common
netdiscover
arp-scan
iftop
nload
iperf3
"

# Pacotes de segurança
PACKAGES_SECURITY="
auditd
audispd-plugins
libpam-pwquality
fail2ban
ufw
iptables-persistent
"

# Pacotes de desenvolvimento
PACKAGES_DEV="
build-essential
python3
python3-pip
nodejs
npm
"

# Pacotes de sistema
PACKAGES_SYSTEM="
systemd
systemd-timesyncd
rsyslog
logrotate
cron
at
"

# Pacotes de virtualização
PACKAGES_VIRT="
qemu-kvm
libvirt-daemon-system
libvirt-clients
bridge-utils
virt-manager
"

# Instalar todos os pacotes
ALL_PACKAGES="$PACKAGES_BASIC $PACKAGES_NETWORK $PACKAGES_SECURITY $PACKAGES_DEV $PACKAGES_SYSTEM $PACKAGES_VIRT"

echo "Instalando pacotes básicos e de rede..."
sudo apt install -y $PACKAGES_BASIC $PACKAGES_NETWORK

echo "Instalando pacotes de segurança..."
sudo apt install -y $PACKAGES_SECURITY

echo "Instalando pacotes de desenvolvimento..."
sudo apt install -y $PACKAGES_DEV

echo "Instalando pacotes de sistema..."
sudo apt install -y $PACKAGES_SYSTEM

echo "Instalando pacotes de virtualização..."
sudo apt install -y $PACKAGES_VIRT

echo "✅ Pacotes instalados com sucesso"
echo ""

# Configurar usuário para grupos necessários
echo "👥 Configurando grupos de usuário..."
sudo usermod -a -G sudo,docker,libvirt,kvm,vboxusers $USER
echo "✅ Usuário adicionado aos grupos necessários"
echo ""

# Configurar sudo sem senha para comandos específicos
echo "🔐 Configurando sudo para comandos específicos..."
sudo tee /etc/sudoers.d/treinamento-linux > /dev/null << 'EOF'
# Configurações para Treinamento Linux - MINFIN Angola
# Permitir comandos específicos sem senha

# Comandos de rede
%sudo ALL=(ALL) NOPASSWD: /sbin/ip, /sbin/ifconfig, /sbin/route, /sbin/iptables, /sbin/ufw
%sudo ALL=(ALL) NOPASSWD: /usr/bin/nmap, /usr/bin/tcpdump, /usr/bin/wireshark

# Comandos de sistema
%sudo ALL=(ALL) NOPASSWD: /bin/systemctl, /usr/bin/systemctl
%sudo ALL=(ALL) NOPASSWD: /usr/sbin/auditctl, /usr/sbin/aureport, /usr/sbin/ausearch

# Comandos de usuários e grupos
%sudo ALL=(ALL) NOPASSWD: /usr/sbin/useradd, /usr/sbin/userdel, /usr/sbin/usermod
%sudo ALL=(ALL) NOPASSWD: /usr/sbin/groupadd, /usr/sbin/groupdel, /usr/sbin/groupmod
%sudo ALL=(ALL) NOPASSWD: /usr/bin/passwd, /usr/sbin/chpasswd

# Comandos de permissões
%sudo ALL=(ALL) NOPASSWD: /bin/chmod, /bin/chown, /bin/chgrp

# Comandos de processo
%sudo ALL=(ALL) NOPASSWD: /bin/kill, /usr/bin/killall, /usr/bin/pkill

# Comandos de backup
%sudo ALL=(ALL) NOPASSWD: /bin/tar, /usr/bin/rsync, /bin/cp, /bin/mv, /bin/rm
EOF

echo "✅ Configurações de sudo criadas"
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

# Configurar auditd
echo "🔍 Configurando auditoria do sistema..."
sudo systemctl enable auditd
sudo systemctl start auditd

# Configurar regras básicas de auditoria
sudo tee /etc/audit/rules.d/treinamento.rules > /dev/null << 'EOF'
# Regras de auditoria para Treinamento Linux - MINFIN Angola

# Monitorar comandos privilegiados
-w /usr/bin/sudo -p x -k privileged_commands
-w /usr/bin/su -p x -k privileged_commands

# Monitorar alterações de usuários
-w /etc/passwd -p wa -k user_changes
-w /etc/group -p wa -k group_changes
-w /etc/shadow -p wa -k password_changes

# Monitorar alterações de rede
-w /etc/network/interfaces -p wa -k network_changes
-w /etc/hosts -p wa -k network_changes

# Monitorar alterações de segurança
-w /etc/ssh/sshd_config -p wa -k ssh_changes
-w /etc/sudoers -p wa -k sudo_changes
EOF

sudo systemctl restart auditd
echo "✅ Auditoria configurada"
echo ""

# Configurar logrotate para logs do treinamento
echo "📋 Configurando rotação de logs..."
sudo tee /etc/logrotate.d/treinamento-linux > /dev/null << 'EOF'
/home/*/treinamento-linux/logs/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 644 root root
}
EOF

echo "✅ Rotação de logs configurada"
echo ""

# Criar script de verificação do ambiente
echo "🔧 Criando script de verificação do ambiente..."
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
packages=("curl" "wget" "git" "vim" "nano" "tree" "htop" "nmap" "tcpdump" "auditd" "ufw")
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
services=("auditd" "ufw" "ssh")
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

# Criar script de limpeza
echo "🧹 Criando script de limpeza..."
cat > ~/treinamento-linux/limpar_ambiente.sh << 'EOF'
#!/bin/bash
# Script de limpeza do ambiente - Treinamento Linux MINFIN Angola

echo "🧹 LIMPANDO AMBIENTE DE TREINAMENTO"
echo "=================================="

# Limpar logs
echo "📋 Limpando logs..."
sudo journalctl --vacuum-time=1d
sudo find /var/log -name "*.log" -type f -mtime +7 -delete 2>/dev/null
echo "✅ Logs limpos"
echo ""

# Limpar cache
echo "🗑️ Limpando cache..."
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean
echo "✅ Cache limpo"
echo ""

# Limpar diretórios temporários
echo "📁 Limpando diretórios temporários..."
rm -rf /tmp/treinamento-*
rm -rf ~/.cache/thumbnails/*
echo "✅ Diretórios temporários limpos"
echo ""

# Limpar histórico de comandos
echo "📜 Limpando histórico de comandos..."
history -c
echo "✅ Histórico limpo"
echo ""

echo "✅ Limpeza concluída!"
EOF

chmod +x ~/treinamento-linux/limpar_ambiente.sh
echo "✅ Script de limpeza criado"
echo ""

# Criar README do ambiente
echo "📖 Criando documentação do ambiente..."
cat > ~/treinamento-linux/README_AMBIENTE.md << 'EOF'
# 🐧 AMBIENTE DE TREINAMENTO LINUX - UBUNTU 24.04 LTS
## Ministério das Finanças de Angola

---

## 📋 **INFORMAÇÕES DO AMBIENTE**

- **Sistema:** Ubuntu 24.04 LTS (Noble Numbat)
- **Preparado em:** $(date)
- **Usuário:** $(whoami)
- **Diretório:** ~/treinamento-linux

---

## 🛠️ **FERRAMENTAS INSTALADAS**

### **Pacotes Básicos:**
- curl, wget, git, vim, nano, tree, htop
- net-tools, iputils-ping, traceroute, dnsutils
- netcat-openbsd, tcpdump, wireshark-common

### **Pacotes de Rede:**
- ipcalc, nmap, netdiscover, arp-scan
- iftop, nload, iperf3

### **Pacotes de Segurança:**
- auditd, audispd-plugins, libpam-pwquality
- fail2ban, ufw, iptables-persistent

### **Pacotes de Desenvolvimento:**
- build-essential, python3, python3-pip
- nodejs, npm

### **Pacotes de Virtualização:**
- qemu-kvm, libvirt-daemon-system
- virt-manager, bridge-utils

---

## 📁 **ESTRUTURA DE DIRETÓRIOS**

```
~/treinamento-linux/
├── exercicios/          # Exercícios por módulo
│   ├── modulo1/
│   ├── modulo2/
│   ├── modulo3/
│   ├── modulo4/
│   ├── modulo5/
│   └── modulo6/
├── apresentacoes/       # Slides HTML
├── logs/               # Logs do treinamento
├── backups/            # Backups
├── projetos/           # Projetos práticos
│   ├── dimdim-bank/
│   ├── empresa-teste/
│   └── lab-rede/
├── verificar_ambiente.sh
├── limpar_ambiente.sh
└── README_AMBIENTE.md
```

---

## 🚀 **COMANDOS ÚTEIS**

### **Verificar Ambiente:**
```bash
./verificar_ambiente.sh
```

### **Limpar Ambiente:**
```bash
./limpar_ambiente.sh
```

### **Aliases Configurados:**
- `ll` - Lista detalhada
- `myip` - Mostra IP local
- `ports` - Portas abertas
- `processes` - Processos em execução
- `services` - Serviços ativos

---

## ⚠️ **OBSERVAÇÕES IMPORTANTES**

1. **Sudo:** Configurado para comandos específicos sem senha
2. **Firewall:** UFW ativo com regras básicas
3. **Auditoria:** Auditd configurado para monitoramento
4. **Logs:** Rotação automática configurada
5. **Grupos:** Usuário adicionado aos grupos necessários

---

## 🔧 **TROUBLESHOOTING**

### **Problemas Comuns:**
1. **Permissão negada:** Verifique se está no grupo sudo
2. **Comando não encontrado:** Execute `sudo apt update && sudo apt install [pacote]`
3. **Serviço não ativo:** Execute `sudo systemctl start [serviço]`

### **Logs Importantes:**
- `/var/log/auth.log` - Autenticação
- `/var/log/syslog` - Sistema
- `/var/log/audit/audit.log` - Auditoria

---

**Desenvolvido para o Treinamento Linux - Ministério das Finanças de Angola - 2025**
EOF

echo "✅ Documentação criada"
echo ""

# Executar verificação final
echo "🔍 Executando verificação final do ambiente..."
~/treinamento-linux/verificar_ambiente.sh

echo ""
echo "🎉 AMBIENTE UBUNTU 24.04 LTS PREPARADO COM SUCESSO!"
echo "=================================================="
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Reinicie o terminal ou execute: source ~/.bashrc"
echo "2. Navegue para: cd ~/treinamento-linux"
echo "3. Execute: ./verificar_ambiente.sh"
echo "4. Comece o treinamento!"
echo ""
echo "📚 RECURSOS DISPONÍVEIS:"
echo "- Documentação: ~/treinamento-linux/README_AMBIENTE.md"
echo "- Verificação: ~/treinamento-linux/verificar_ambiente.sh"
echo "- Limpeza: ~/treinamento-linux/limpar_ambiente.sh"
echo ""
echo "✅ Ambiente pronto para o treinamento Linux!"
