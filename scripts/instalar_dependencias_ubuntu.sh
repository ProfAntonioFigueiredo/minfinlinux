#!/bin/bash

# =============================================================================
# SCRIPT DE INSTALAÇÃO DE DEPENDÊNCIAS ESPECÍFICAS - UBUNTU 24.04 LTS
# Treinamento Linux - Ministério das Finanças de Angola
# =============================================================================

echo "📦 INSTALANDO DEPENDÊNCIAS ESPECÍFICAS PARA UBUNTU 24.04 LTS"
echo "============================================================="
echo ""

# Verificar se está executando como usuário normal
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  ATENÇÃO: Execute como usuário normal, não como root!"
    exit 1
fi

# Atualizar sistema
echo "🔄 Atualizando sistema..."
sudo apt update && sudo apt upgrade -y
echo "✅ Sistema atualizado"
echo ""

# Adicionar repositórios necessários
echo "📦 Adicionando repositórios necessários..."

# Repositório do Docker
if ! curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 2>/dev/null; then
    echo "⚠️  Erro ao adicionar chave do Docker"
fi

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Repositório do Kubernetes
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Repositório do Ansible
sudo apt-add-repository ppa:ansible/ansible -y

echo "✅ Repositórios adicionados"
echo ""

# Atualizar lista de pacotes
echo "🔄 Atualizando lista de pacotes..."
sudo apt update
echo "✅ Lista atualizada"
echo ""

# Instalar Docker
echo "🐳 Instalando Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
echo "✅ Docker instalado"
echo ""

# Instalar Kubernetes (kubectl)
echo "☸️  Instalando Kubernetes (kubectl)..."
sudo apt install -y kubectl
echo "✅ Kubernetes instalado"
echo ""

# Instalar Ansible
echo "🤖 Instalando Ansible..."
sudo apt install -y ansible
echo "✅ Ansible instalado"
echo ""

# Instalar ferramentas de monitoramento
echo "📊 Instalando ferramentas de monitoramento..."
sudo apt install -y \
    prometheus \
    grafana \
    elasticsearch \
    logstash \
    kibana \
    filebeat \
    metricbeat \
    packetbeat
echo "✅ Ferramentas de monitoramento instaladas"
echo ""

# Instalar ferramentas de segurança
echo "🔒 Instalando ferramentas de segurança..."
sudo apt install -y \
    snort \
    suricata \
    ossec-hids \
    rkhunter \
    chkrootkit \
    lynis \
    aide
echo "✅ Ferramentas de segurança instaladas"
echo ""

# Instalar ferramentas de rede avançadas
echo "🌐 Instalando ferramentas de rede avançadas..."
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
echo "✅ Ferramentas de rede instaladas"
echo ""

# Instalar ferramentas de desenvolvimento
echo "💻 Instalando ferramentas de desenvolvimento..."
sudo apt install -y \
    python3-dev \
    python3-venv \
    python3-pip \
    nodejs \
    npm \
    golang-go \
    rustc \
    cargo \
    openjdk-17-jdk \
    maven \
    gradle
echo "✅ Ferramentas de desenvolvimento instaladas"
echo ""

# Instalar ferramentas de virtualização
echo "🖥️  Instalando ferramentas de virtualização..."
sudo apt install -y \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    virt-manager \
    virt-viewer \
    libguestfs-tools \
    vagrant
echo "✅ Ferramentas de virtualização instaladas"
echo ""

# Instalar ferramentas de backup
echo "💾 Instando ferramentas de backup..."
sudo apt install -y \
    rsync \
    rsnapshot \
    duplicity \
    borgbackup \
    restic
echo "✅ Ferramentas de backup instaladas"
echo ""

# Instalar ferramentas de análise forense
echo "🔍 Instalando ferramentas de análise forense..."
sudo apt install -y \
    sleuthkit \
    autopsy \
    volatility3 \
    bulk-extractor \
    scalpel \
    foremost
echo "✅ Ferramentas de análise forense instaladas"
echo ""

# Configurar serviços essenciais
echo "⚙️  Configurando serviços essenciais..."

# Configurar SSH
sudo systemctl enable ssh
sudo systemctl start ssh

# Configurar NTP
sudo systemctl enable chrony
sudo systemctl start chrony

# Configurar auditd
sudo systemctl enable auditd
sudo systemctl start auditd

# Configurar fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

echo "✅ Serviços configurados"
echo ""

# Criar usuários de teste para o treinamento
echo "👥 Criando usuários de teste..."
sudo useradd -m -s /bin/bash aluno1
sudo useradd -m -s /bin/bash aluno2
sudo useradd -m -s /bin/bash professor
echo "aluno1:123456" | sudo chpasswd
echo "aluno2:123456" | sudo chpasswd
echo "professor:123456" | sudo chpasswd
echo "✅ Usuários de teste criados"
echo ""

# Criar grupos de teste
echo "👥 Criando grupos de teste..."
sudo groupadd administradores
sudo groupadd desenvolvedores
sudo groupadd operadores
sudo usermod -aG administradores professor
sudo usermod -aG desenvolvedores aluno1
sudo usermod -aG operadores aluno2
echo "✅ Grupos de teste criados"
echo ""

# Configurar permissões de exemplo
echo "🔐 Configurando permissões de exemplo..."
sudo mkdir -p /opt/treinamento/{dados,logs,backups}
sudo chown professor:administradores /opt/treinamento
sudo chmod 755 /opt/treinamento
sudo chown -R professor:administradores /opt/treinamento/dados
sudo chmod 750 /opt/treinamento/dados
echo "✅ Permissões configuradas"
echo ""

# Criar scripts de exemplo
echo "📝 Criando scripts de exemplo..."
cat > ~/treinamento-linux/exemplo_monitoramento.sh << 'EOF'
#!/bin/bash
# Script de exemplo para monitoramento

echo "=== MONITORAMENTO DO SISTEMA ==="
echo "Data/Hora: $(date)"
echo "Uptime: $(uptime)"
echo ""

echo "=== USO DE MEMÓRIA ==="
free -h
echo ""

echo "=== USO DE DISCO ==="
df -h
echo ""

echo "=== PROCESSOS TOP 5 ==="
ps aux --sort=-%cpu | head -6
echo ""

echo "=== CONEXÕES DE REDE ==="
ss -tuln | head -10
echo ""

echo "=== LOGS RECENTES ==="
sudo tail -5 /var/log/syslog
EOF

chmod +x ~/treinamento-linux/exemplo_monitoramento.sh

cat > ~/treinamento-linux/exemplo_backup.sh << 'EOF'
#!/bin/bash
# Script de exemplo para backup

BACKUP_DIR="/home/$USER/treinamento-linux/backups"
DATE=$(date +%Y%m%d_%H%M%S)

echo "=== INICIANDO BACKUP ==="
echo "Data/Hora: $(date)"
echo "Diretório de destino: $BACKUP_DIR"
echo ""

# Criar diretório de backup se não existir
mkdir -p "$BACKUP_DIR"

# Backup de configurações importantes
echo "Fazendo backup de configurações..."
sudo tar -czf "$BACKUP_DIR/config_$DATE.tar.gz" /etc/ssh /etc/network /etc/hosts 2>/dev/null

# Backup de logs
echo "Fazendo backup de logs..."
sudo tar -czf "$BACKUP_DIR/logs_$DATE.tar.gz" /var/log 2>/dev/null

# Backup de diretório home
echo "Fazendo backup do diretório home..."
tar -czf "$BACKUP_DIR/home_$DATE.tar.gz" ~/treinamento-linux

echo "=== BACKUP CONCLUÍDO ==="
echo "Arquivos criados:"
ls -lh "$BACKUP_DIR"/*$DATE*
echo ""
EOF

chmod +x ~/treinamento-linux/exemplo_backup.sh

echo "✅ Scripts de exemplo criados"
echo ""

# Criar documentação das ferramentas
echo "📚 Criando documentação das ferramentas..."
cat > ~/treinamento-linux/FERRAMENTAS_INSTALADAS.md << 'EOF'
# 🛠️ FERRAMENTAS INSTALADAS - UBUNTU 24.04 LTS
## Treinamento Linux - Ministério das Finanças de Angola

---

## 🐳 **CONTAINERIZAÇÃO**

### **Docker:**
- **Comando:** `docker --version`
- **Status:** `sudo systemctl status docker`
- **Uso:** `docker run hello-world`

### **Kubernetes:**
- **Comando:** `kubectl version --client`
- **Configuração:** `~/.kube/config`

---

## 🤖 **AUTOMAÇÃO**

### **Ansible:**
- **Comando:** `ansible --version`
- **Inventário:** `/etc/ansible/hosts`
- **Playbooks:** `~/treinamento-linux/playbooks/`

---

## 📊 **MONITORAMENTO**

### **Prometheus:**
- **Serviço:** `sudo systemctl status prometheus`
- **Porta:** 9090
- **Config:** `/etc/prometheus/prometheus.yml`

### **Grafana:**
- **Serviço:** `sudo systemctl status grafana-server`
- **Porta:** 3000
- **Login:** admin/admin

### **ELK Stack:**
- **Elasticsearch:** `sudo systemctl status elasticsearch`
- **Logstash:** `sudo systemctl status logstash`
- **Kibana:** `sudo systemctl status kibana`

---

## 🔒 **SEGURANÇA**

### **Snort:**
- **Comando:** `snort --version`
- **Config:** `/etc/snort/snort.conf`

### **Suricata:**
- **Comando:** `suricata --version`
- **Config:** `/etc/suricata/suricata.yaml`

### **Fail2ban:**
- **Status:** `sudo fail2ban-client status`
- **Config:** `/etc/fail2ban/jail.local`

---

## 🌐 **REDES**

### **BIND9 (DNS):**
- **Serviço:** `sudo systemctl status bind9`
- **Config:** `/etc/bind/named.conf`

### **Apache:**
- **Serviço:** `sudo systemctl status apache2`
- **Porta:** 80
- **Config:** `/etc/apache2/apache2.conf`

### **Nginx:**
- **Serviço:** `sudo systemctl status nginx`
- **Porta:** 80
- **Config:** `/etc/nginx/nginx.conf`

---

## 💾 **BACKUP**

### **Rsync:**
- **Comando:** `rsync --version`
- **Uso:** `rsync -av source/ destination/`

### **Borg:**
- **Comando:** `borg --version`
- **Uso:** `borg init /path/to/repo`

---

## 🔍 **FORENSE**

### **Sleuth Kit:**
- **Comando:** `tsk_gettimes`
- **Uso:** Análise de sistemas de arquivos

### **Volatility:**
- **Comando:** `vol.py --help`
- **Uso:** Análise de memória

---

## 👥 **USUÁRIOS DE TESTE**

- **aluno1** (desenvolvedores)
- **aluno2** (operadores)  
- **professor** (administradores)

**Senha padrão:** 123456

---

## 📁 **ESTRUTURA DE DIRETÓRIOS**

```
~/treinamento-linux/
├── backups/                    # Backups automáticos
├── logs/                      # Logs do treinamento
├── projetos/                  # Projetos práticos
├── exemplo_monitoramento.sh   # Script de monitoramento
├── exemplo_backup.sh          # Script de backup
└── FERRAMENTAS_INSTALADAS.md  # Esta documentação
```

---

## 🚀 **COMANDOS ÚTEIS**

### **Verificar Status dos Serviços:**
```bash
sudo systemctl status docker prometheus grafana-server elasticsearch
```

### **Iniciar Serviços:**
```bash
sudo systemctl start [serviço]
```

### **Parar Serviços:**
```bash
sudo systemctl stop [serviço]
```

### **Reiniciar Serviços:**
```bash
sudo systemctl restart [serviço]
```

---

**Desenvolvido para o Treinamento Linux - Ministério das Finanças de Angola - 2025**
EOF

echo "✅ Documentação das ferramentas criada"
echo ""

# Verificação final
echo "🔍 Verificando instalação..."
echo "Docker: $(docker --version 2>/dev/null || echo 'Não instalado')"
echo "Kubernetes: $(kubectl version --client 2>/dev/null || echo 'Não instalado')"
echo "Ansible: $(ansible --version 2>/dev/null | head -1 || echo 'Não instalado')"
echo ""

echo "🎉 DEPENDÊNCIAS INSTALADAS COM SUCESSO!"
echo "======================================"
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Reinicie o terminal ou execute: source ~/.bashrc"
echo "2. Verifique as ferramentas: ~/treinamento-linux/FERRAMENTAS_INSTALADAS.md"
echo "3. Teste os scripts: ./exemplo_monitoramento.sh"
echo "4. Comece o treinamento!"
echo ""
echo "✅ Ambiente completo pronto para o treinamento Linux!"
