#!/bin/bash

# =============================================================================
# CONFIGURAÇÃO DE EXERCÍCIOS PARA UBUNTU 24.04 LTS
# Treinamento Linux - Ministério das Finanças de Angola
# =============================================================================

echo "🔧 CONFIGURANDO EXERCÍCIOS PARA UBUNTU 24.04 LTS"
echo "==============================================="
echo ""

# Verificar se está no diretório correto
if [ ! -d "modulos" ]; then
    echo "❌ Execute este script no diretório raiz do projeto (onde está a pasta 'modulos')"
    exit 1
fi

echo "✅ Diretório correto detectado"
echo "📍 Diretório atual: $(pwd)"
echo ""

# Função para atualizar cabeçalho dos scripts
update_script_header() {
    local file=$1
    local module=$2
    local title=$3
    
    if [ -f "$file" ]; then
        echo "🔧 Atualizando: $file"
        
        # Backup do arquivo original
        cp "$file" "${file}.backup"
        
        # Atualizar cabeçalho
        sed -i "1,7s/.*/#!/bin/bash\n\n# =============================================================================\n# $title\n# $module - Treinamento Linux MINFIN Angola\n# Ubuntu 24.04 LTS (Noble Numbat) - Comandos otimizados\n# =============================================================================/" "$file"
        
        echo "✅ $file atualizado"
    else
        echo "⚠️  Arquivo não encontrado: $file"
    fi
}

# Atualizar scripts do Módulo 1
echo "📝 Atualizando scripts do Módulo 1..."
update_script_header "modulos/modulo1_fundamentos_linux/exercicios/exercicio_permissoes_arquivos.sh" "Módulo 1" "EXERCÍCIO: PERMISSÕES DE ARQUIVOS E DIRETÓRIOS"
update_script_header "modulos/modulo1_fundamentos_linux/exercicios/exercicio_usuarios_grupos.sh" "Módulo 1" "EXERCÍCIO: GESTÃO DE USUÁRIOS E GRUPOS"
update_script_header "modulos/modulo1_fundamentos_linux/exercicios/exercicio_processos_servicos.sh" "Módulo 1" "EXERCÍCIO: PROCESSOS E SERVIÇOS"

# Atualizar scripts do Módulo 2
echo "📝 Atualizando scripts do Módulo 2..."
update_script_header "modulos/modulo2_redes_seguranca/exercicios/exercicio_calculo_subredes.sh" "Módulo 2" "EXERCÍCIO: CÁLCULO DE SUB-REDES"
update_script_header "modulos/modulo2_redes_seguranca/exercicios/exercicio_controles_acesso.sh" "Módulo 2" "EXERCÍCIO: CONTROLES DE ACESSO"
update_script_header "modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh" "Módulo 2" "EXERCÍCIO: CENÁRIOS PRÁTICOS"

echo "✅ Scripts atualizados"
echo ""

# Corrigir comandos específicos do Ubuntu
echo "🔧 Corrigindo comandos específicos do Ubuntu..."

# Corrigir comando passwd --stdin para chpasswd
echo "🔧 Corrigindo comando de senha..."
find modulos -name "*.sh" -exec sed -i 's/echo "senha123" | passwd --stdin/echo "usuario:senha123" | chpasswd/g' {} \;
find modulos -name "*.sh" -exec sed -i 's/echo "senha123" | passwd --stdin/echo "usuario:senha123" | chpasswd/g' {} \;

echo "✅ Comandos de senha corrigidos"
echo ""

# Adicionar verificações de pacotes Ubuntu
echo "🔧 Adicionando verificações de pacotes Ubuntu..."

# Função para adicionar verificação de pacotes
add_package_check() {
    local file=$1
    local package=$2
    
    if [ -f "$file" ]; then
        # Adicionar verificação no início do script
        sed -i "/^echo \"📍 Diretório atual: \$(pwd)\"/a\\n# Verificar se pacote está instalado\nif ! command -v $package >/dev/null 2>&1; then\n    echo \"⚠️  Pacote $package não encontrado. Instale com: sudo apt install $package\"\n    echo \"Continuando mesmo assim...\"\n    echo \"\"\nfi" "$file"
    fi
}

# Adicionar verificações para pacotes importantes
add_package_check "modulos/modulo2_redes_seguranca/exercicios/exercicio_calculo_subredes.sh" "ipcalc"
add_package_check "modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh" "nmap"
add_package_check "modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh" "tcpdump"

echo "✅ Verificações de pacotes adicionadas"
echo ""

# Criar script de instalação de dependências específicas
echo "🔧 Criando script de dependências específicas..."
cat > scripts/instalar_dependencias_especificas.sh << 'EOF'
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
EOF

chmod +x scripts/instalar_dependencias_especificas.sh
echo "✅ Script de dependências específicas criado"
echo ""

# Criar script de teste dos exercícios
echo "🔧 Criando script de teste dos exercícios..."
cat > scripts/testar_exercicios_ubuntu.sh << 'EOF'
#!/bin/bash

# =============================================================================
# TESTE DOS EXERCÍCIOS - UBUNTU 24.04 LTS
# Treinamento Linux - Ministério das Finanças de Angola
# =============================================================================

echo "🧪 TESTANDO EXERCÍCIOS - UBUNTU 24.04 LTS"
echo "========================================="
echo ""

# Verificar se está no diretório correto
if [ ! -d "modulos" ]; then
    echo "❌ Execute este script no diretório raiz do projeto"
    exit 1
fi

echo "✅ Diretório correto detectado"
echo "📍 Diretório atual: $(pwd)"
echo ""

# Função para testar script
test_script() {
    local script=$1
    local module=$2
    
    if [ -f "$script" ]; then
        echo "🧪 Testando: $script"
        
        # Tornar executável
        chmod +x "$script"
        
        # Executar com timeout (30 segundos)
        if timeout 30s "$script" >/dev/null 2>&1; then
            echo "✅ $script - OK"
        else
            echo "⚠️  $script - Timeout ou erro"
        fi
    else
        echo "❌ $script - Não encontrado"
    fi
    echo ""
}

# Testar scripts do Módulo 1
echo "📝 Testando scripts do Módulo 1..."
test_script "modulos/modulo1_fundamentos_linux/exercicios/exercicio_permissoes_arquivos.sh" "Módulo 1"
test_script "modulos/modulo1_fundamentos_linux/exercicios/exercicio_usuarios_grupos.sh" "Módulo 1"
test_script "modulos/modulo1_fundamentos_linux/exercicios/exercicio_processos_servicos.sh" "Módulo 1"

# Testar scripts do Módulo 2
echo "📝 Testando scripts do Módulo 2..."
test_script "modulos/modulo2_redes_seguranca/exercicios/exercicio_calculo_subredes.sh" "Módulo 2"
test_script "modulos/modulo2_redes_seguranca/exercicios/exercicio_controles_acesso.sh" "Módulo 2"
test_script "modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh" "Módulo 2"

echo "✅ Teste dos exercícios concluído!"
echo "========================================="
EOF

chmod +x scripts/testar_exercicios_ubuntu.sh
echo "✅ Script de teste criado"
echo ""

# Criar documentação de compatibilidade Ubuntu
echo "📚 Criando documentação de compatibilidade..."
cat > UBUNTU_COMPATIBILIDADE.md << 'EOF'
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
EOF

echo "✅ Documentação de compatibilidade criada"
echo ""

# Executar teste dos exercícios
echo "🧪 Executando teste dos exercícios..."
./scripts/testar_exercicios_ubuntu.sh

echo ""
echo "🎉 CONFIGURAÇÃO PARA UBUNTU 24.04 LTS CONCLUÍDA!"
echo "==============================================="
echo ""
echo "📋 PRÓXIMOS PASSOS:"
echo "1. Execute: ./scripts/instalacao_rapida_ubuntu.sh"
echo "2. Execute: ./scripts/instalar_dependencias_especificas.sh"
echo "3. Execute: ./scripts/testar_exercicios_ubuntu.sh"
echo "4. Comece o treinamento!"
echo ""
echo "📚 DOCUMENTAÇÃO:"
echo "- Compatibilidade: UBUNTU_COMPATIBILIDADE.md"
echo "- Verificação: ~/treinamento-linux/verificar_ambiente.sh"
echo ""
echo "✅ Exercícios configurados para Ubuntu 24.04 LTS!"
