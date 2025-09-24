# 🐧 COMPATIBILIDADE UBUNTU 24.04 LTS
## Treinamento Linux - Ministério das Finanças de Angola

---

## 📋 **INFORMAÇÕES DO SISTEMA**

- **Sistema:** Ubuntu 24.04 LTS (Noble Numbat)
- **Kernel:** Linux 6.x
- **Arquitetura:** x86_64
- **Gerenciador de Pacotes:** APT (Advanced Package Tool)
- **Sistema de Inicialização:** systemd

---

## 🛠️ **COMANDOS ESPECÍFICOS UBUNTU**

### **Gerenciamento de Pacotes:**
```bash
# Atualizar lista de pacotes
sudo apt update

# Instalar pacote
sudo apt install nome_do_pacote

# Remover pacote
sudo apt remove nome_do_pacote

# Buscar pacote
apt search termo_busca

# Informações do pacote
apt show nome_do_pacote
```

### **Gerenciamento de Serviços:**
```bash
# Status do serviço
sudo systemctl status nome_do_servico

# Iniciar serviço
sudo systemctl start nome_do_servico

# Parar serviço
sudo systemctl stop nome_do_servico

# Reiniciar serviço
sudo systemctl restart nome_do_servico

# Habilitar serviço
sudo systemctl enable nome_do_servico

# Desabilitar serviço
sudo systemctl disable nome_do_servico
```

### **Gerenciamento de Usuários:**
```bash
# Criar usuário
sudo useradd -m -s /bin/bash nome_usuario

# Definir senha
echo "usuario:senha" | sudo chpasswd

# Adicionar ao grupo
sudo usermod -a -G grupo usuario

# Verificar grupos
groups usuario
```

---

## 📦 **PACOTES INSTALADOS**

### **Pacotes Básicos:**
- curl, wget, git, vim, nano, tree, htop
- net-tools, iputils-ping, traceroute, dnsutils
- netcat-openbsd, tcpdump, wireshark-common

### **Pacotes de Rede:**
- ipcalc, sipcalc, nmap, netdiscover, arp-scan
- iftop, nload, iperf3

### **Pacotes de Segurança:**
- auditd, audispd-plugins, libpam-pwquality
- fail2ban, ufw, iptables-persistent
- rkhunter, chkrootkit, lynis

### **Pacotes de Desenvolvimento:**
- build-essential, python3, python3-pip
- nodejs, npm, golang-go, rustc, cargo
- openjdk-17-jdk, maven, gradle

---

## 🔧 **CONFIGURAÇÕES ESPECÍFICAS**

### **Firewall (UFW):**
```bash
# Status
sudo ufw status verbose

# Habilitar
sudo ufw enable

# Permitir porta
sudo ufw allow 80/tcp

# Negar porta
sudo ufw deny 23/tcp
```

### **Auditoria (auditd):**
```bash
# Status
sudo systemctl status auditd

# Ver logs
sudo ausearch -m all

# Relatório
sudo aureport
```

### **Fail2ban:**
```bash
# Status
sudo fail2ban-client status

# Status de jail específico
sudo fail2ban-client status sshd
```

---

## 🚀 **SCRIPTS DE CONFIGURAÇÃO**

### **Instalação Rápida:**
```bash
./scripts/instalacao_rapida_ubuntu.sh
```

### **Dependências Específicas:**
```bash
./scripts/instalar_dependencias_especificas.sh
```

### **Teste dos Exercícios:**
```bash
./scripts/testar_exercicios_ubuntu.sh
```

### **Verificação do Ambiente:**
```bash
./treinamento-linux/verificar_ambiente.sh
```

---

## ⚠️ **OBSERVAÇÕES IMPORTANTES**

1. **Sudo:** Configurado para comandos específicos sem senha
2. **Firewall:** UFW ativo com regras básicas
3. **Auditoria:** Auditd configurado para monitoramento
4. **Logs:** Rotação automática configurada
5. **Grupos:** Usuário adicionado aos grupos necessários

---

## 🔍 **TROUBLESHOOTING**

### **Problemas Comuns:**
1. **Permissão negada:** Verifique se está no grupo sudo
2. **Comando não encontrado:** Execute `sudo apt install [pacote]`
3. **Serviço não ativo:** Execute `sudo systemctl start [serviço]`
4. **Firewall bloqueando:** Verifique regras com `sudo ufw status`

### **Logs Importantes:**
- `/var/log/auth.log` - Autenticação
- `/var/log/syslog` - Sistema
- `/var/log/audit/audit.log` - Auditoria
- `/var/log/fail2ban.log` - Fail2ban

---

**Desenvolvido para o Treinamento Linux - Ministério das Finanças de Angola - 2025**
