#!/bin/bash

# =============================================================================
# EXERCÍCIO: CENÁRIOS PRÁTICOS DE REDES E SEGURANÇA
# Módulo 2 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🌐 EXERCÍCIO: CENÁRIOS PRÁTICOS DE REDES E SEGURANÇA"
echo "=================================================="
echo ""

echo "📍 Diretório atual: $(pwd)"
echo "🕐 Data/Hora: $(date)"
echo ""

# Criar diretório de trabalho
echo "📁 Comando: Criando diretório de trabalho para cenários práticos"
echo "📁 Criando diretório de trabalho para cenários práticos:"
mkdir -p exercicios_cenarios
cd exercicios_cenarios
echo "✅ Diretório criado: $(pwd)"
echo ""

# Cenário 1: Diagnóstico de problemas de conectividade
echo "📝 CENÁRIO 1: Diagnóstico de problemas de conectividade"
echo "======================================================"
echo "🎯 Situação: Usuário não consegue acessar a Internet"
echo ""

echo "🔍 Passo 1: Verificar configuração de rede local"
echo "Comando: ip addr show"
echo "Resultado esperado: Interface ativa com IP configurado"
echo ""

echo "🔍 Passo 2: Testar conectividade local"
echo "Comando: ping -c 4 192.168.1.1"
echo "Resultado esperado: Resposta do gateway"
echo ""

echo "🔍 Passo 3: Verificar roteamento"
echo "Comando: ip route show"
echo "Resultado esperado: Rota padrão configurada"
echo ""

echo "🔍 Passo 4: Testar DNS"
echo "Comando: nslookup google.com"
echo "Resultado esperado: Resolução de nome funcionando"
echo ""

echo "🔍 Passo 5: Testar conectividade externa"
echo "Comando: ping -c 4 8.8.8.8"
echo "Resultado esperado: Conectividade com Internet"
echo ""

# Cenário 2: Configuração de rede para departamentos
echo "📝 CENÁRIO 2: Configuração de rede para departamentos"
echo "==================================================="
echo "🎯 Situação: Configurar rede para 3 departamentos"
echo ""

echo "📊 Comando: Requisitos"
echo "📊 Requisitos:"
echo "• TI: 50 hosts (192.168.10.0/26)"
echo "• Financeiro: 25 hosts (192.168.20.0/27)"
echo "• RH: 10 hosts (192.168.30.0/28)"
echo "• Gateway: 192.168.1.1"
echo ""

# Criar script de configuração
cat > configurar_rede_departamentos.sh << 'EOF'
#!/bin/bash
# Script de configuração de rede para departamentos

echo "Configurando rede para departamentos..."

# Configurar interface para TI
sudo ip addr add 192.168.10.1/26 dev eth1
sudo ip link set eth1 up

# Configurar interface para Financeiro
sudo ip addr add 192.168.20.1/27 dev eth2
sudo ip link set eth2 up

# Configurar interface para RH
sudo ip addr add 192.168.30.1/28 dev eth3
sudo ip link set eth3 up

# Configurar roteamento
sudo ip route add 192.168.10.0/26 via 192.168.10.1
sudo ip route add 192.168.20.0/27 via 192.168.20.1
sudo ip route add 192.168.30.0/28 via 192.168.30.1

# Configurar NAT para acesso à Internet
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth2 -o eth0 -j ACCEPT
sudo iptables -A FORWARD -i eth3 -o eth0 -j ACCEPT

echo "Configuração de rede concluída!"
EOF

chmod +x configurar_rede_departamentos.sh
echo "📄 Script de configuração criado: configurar_rede_departamentos.sh"
echo ""

# Cenário 3: Implementação de firewall básico
echo "📝 CENÁRIO 3: Implementação de firewall básico"
echo "============================================="
echo "🎯 Situação: Implementar regras de firewall para proteger a rede"
echo ""

# Criar script de firewall
cat > configurar_firewall.sh << 'EOF'
#!/bin/bash
# Script de configuração de firewall - MINFIN Angola

echo "Configurando firewall básico..."

# Limpar regras existentes
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Política padrão: DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Permitir loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Permitir conexões estabelecidas
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Permitir SSH (porta 22)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Permitir HTTP (porta 80)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Permitir HTTPS (porta 443)
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Permitir ping
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Permitir tráfego entre departamentos
iptables -A FORWARD -s 192.168.10.0/26 -d 192.168.20.0/27 -j ACCEPT
iptables -A FORWARD -s 192.168.20.0/27 -d 192.168.10.0/26 -j ACCEPT
iptables -A FORWARD -s 192.168.10.0/26 -d 192.168.30.0/28 -j ACCEPT
iptables -A FORWARD -s 192.168.30.0/28 -d 192.168.10.0/26 -j ACCEPT

# Log de tentativas de acesso
iptables -A INPUT -j LOG --log-prefix "FIREWALL: "
iptables -A FORWARD -j LOG --log-prefix "FIREWALL: "

echo "Firewall configurado com sucesso!"
echo "Regras aplicadas:"
iptables -L -n
EOF

chmod +x configurar_firewall.sh
echo "📄 Script de firewall criado: configurar_firewall.sh"
echo ""

# Cenário 4: Monitoramento de segurança
echo "📝 CENÁRIO 4: Monitoramento de segurança"
echo "======================================="
echo "🎯 Situação: Implementar monitoramento de segurança da rede"
echo ""

# Criar script de monitoramento
cat > monitorar_seguranca.sh << 'EOF'
#!/bin/bash
# Script de monitoramento de segurança - MINFIN Angola

LOG_FILE="/var/log/seguranca_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "Iniciando monitoramento de segurança em $DATE"

# Função para log
log_event() {
    echo "[$DATE] $1" >> $LOG_FILE
}

# Monitorar tentativas de login
echo "🔍 Monitorando tentativas de login..."
lastb | head -10 | while read line; do
    if [[ $line =~ ^[a-zA-Z] ]]; then
        user=$(echo $line | awk '{print $1}')
        ip=$(echo $line | awk '{print $3}')
        log_event "FAILED_LOGIN: $user from $ip"
    fi
done

# Monitorar conexões de rede suspeitas
echo "🔍 Monitorando conexões de rede..."
netstat -tuln | grep -E ":(22|23|21|25|53|80|443|993|995)" | while read line; do
    log_event "NETWORK_CONNECTION: $line"
done

# Monitorar processos suspeitos
echo "🔍 Monitorando processos suspeitos..."
ps aux | grep -E "(nc|netcat|nmap|masscan|zmap)" | while read line; do
    log_event "SUSPICIOUS_PROCESS: $line"
done

# Monitorar alterações em arquivos críticos
echo "🔍 Monitorando alterações em arquivos críticos..."
find /etc -name "*.conf" -mtime -1 2>/dev/null | while read file; do
    log_event "CONFIG_CHANGED: $file"
done

# Verificar integridade de arquivos sensíveis
echo "🔍 Verificando integridade de arquivos sensíveis..."
if [ -f /etc/passwd ]; then
    checksum=$(md5sum /etc/passwd | awk '{print $1}')
    log_event "PASSWD_CHECKSUM: $checksum"
fi

echo "Monitoramento concluído em $DATE"
echo "Log salvo em: $LOG_FILE"
EOF

chmod +x monitorar_seguranca.sh
echo "📄 Script de monitoramento criado: monitorar_seguranca.sh"
echo ""

# Cenário 5: Resposta a incidentes de segurança
echo "📝 CENÁRIO 5: Resposta a incidentes de segurança"
echo "=============================================="
echo "🎯 Situação: Responder a um incidente de segurança detectado"
echo ""

# Criar script de resposta a incidentes
cat > responder_incidente.sh << 'EOF'
#!/bin/bash
# Script de resposta a incidentes - MINFIN Angola

INCIDENT_LOG="/var/log/incidente_$(date +%Y%m%d_%H%M%S).log"

echo "🚨 INICIANDO RESPOSTA A INCIDENTE DE SEGURANÇA"
echo "Data/Hora: $(date)"
echo "Log do incidente: $INCIDENT_LOG"

# Função para log do incidente
log_incident() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a $INCIDENT_LOG
}

log_incident "=== INÍCIO DO INCIDENTE ==="

# Passo 1: Isolar o sistema afetado
echo "🔒 Passo 1: Isolando sistema afetado..."
log_incident "Isolando sistema da rede"
# iptables -A INPUT -s IP_SUSPEITO -j DROP
# iptables -A OUTPUT -d IP_SUSPEITO -j DROP

# Passo 2: Preservar evidências
echo "📸 Passo 2: Preservando evidências..."
log_incident "Criando backup de evidências"
mkdir -p /incidente/evidencias/$(date +%Y%m%d_%H%M%S)
cp /var/log/auth.log /incidente/evidencias/$(date +%Y%m%d_%H%M%S)/
cp /var/log/syslog /incidente/evidencias/$(date +%Y%m%d_%H%M%S)/
cp /var/log/audit/audit.log /incidente/evidencias/$(date +%Y%m%d_%H%M%S)/ 2>/dev/null

# Passo 3: Analisar logs
echo "🔍 Passo 3: Analisando logs..."
log_incident "Analisando logs de segurança"
echo "Últimas tentativas de login falhadas:"
lastb | head -10
echo "Conexões ativas suspeitas:"
netstat -tuln | grep -E ":(22|23|21|25|53|80|443|993|995)"

# Passo 4: Identificar comprometimento
echo "🎯 Passo 4: Identificando comprometimento..."
log_incident "Verificando integridade do sistema"
echo "Verificando arquivos críticos modificados:"
find /etc -name "*.conf" -mtime -1 2>/dev/null
echo "Verificando processos suspeitos:"
ps aux | grep -E "(nc|netcat|nmap|masscan|zmap)"

# Passo 5: Contenção
echo "🛡️ Passo 5: Implementando contenção..."
log_incident "Implementando medidas de contenção"
# Bloquear IPs suspeitos
# Desabilitar contas comprometidas
# Alterar senhas de administradores

# Passo 6: Recuperação
echo "🔄 Passo 6: Iniciando recuperação..."
log_incident "Iniciando processo de recuperação"
# Restaurar de backup limpo
# Aplicar patches de segurança
# Reconfigurar sistemas

# Passo 7: Documentação
echo "📋 Passo 7: Documentando incidente..."
log_incident "Documentando incidente para análise posterior"
echo "Relatório de incidente salvo em: $INCIDENT_LOG"

log_incident "=== FIM DO INCIDENTE ==="
echo "✅ Resposta a incidente concluída"
EOF

chmod +x responder_incidente.sh
echo "📄 Script de resposta a incidentes criado: responder_incidente.sh"
echo ""

# Cenário 6: Teste de penetração básico
echo "📝 CENÁRIO 6: Teste de penetração básico"
echo "======================================"
echo "🎯 Situação: Realizar teste de penetração básico na rede"
echo ""

# Criar script de teste de penetração
cat > teste_penetracao.sh << 'EOF'
#!/bin/bash
# Script de teste de penetração básico - MINFIN Angola

echo "🔍 INICIANDO TESTE DE PENETRAÇÃO BÁSICO"
echo "Data/Hora: $(date)"
echo ""

# Função para testar porta
test_port() {
    local host=$1
    local port=$2
    local service=$3
    
    if timeout 3 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null; then
        echo "✅ Porta $port ($service) - ABERTA"
        return 0
    else
        echo "❌ Porta $port ($service) - FECHADA"
        return 1
    fi
}

# Teste 1: Scan de portas comuns
echo "🔍 Teste 1: Scan de portas comuns"
echo "Alvo: 192.168.1.1"
echo ""

test_port "192.168.1.1" "22" "SSH"
test_port "192.168.1.1" "23" "Telnet"
test_port "192.168.1.1" "80" "HTTP"
test_port "192.168.1.1" "443" "HTTPS"
test_port "192.168.1.1" "21" "FTP"
test_port "192.168.1.1" "25" "SMTP"
test_port "192.168.1.1" "53" "DNS"
test_port "192.168.1.1" "110" "POP3"
test_port "192.168.1.1" "143" "IMAP"
test_port "192.168.1.1" "993" "IMAPS"
test_port "192.168.1.1" "995" "POP3S"
echo ""

# Teste 2: Verificar serviços em execução
echo "🔍 Teste 2: Verificar serviços em execução"
echo "Serviços ativos:"
systemctl list-units --type=service --state=active | grep -E "(ssh|apache|nginx|mysql|postgresql)"
echo ""

# Teste 3: Verificar configurações de segurança
echo "🔍 Teste 3: Verificar configurações de segurança"
echo "Configuração SSH:"
grep -E "^(PermitRootLogin|PasswordAuthentication|Port)" /etc/ssh/sshd_config 2>/dev/null || echo "Arquivo não encontrado"
echo ""

echo "Configuração de firewall:"
iptables -L -n 2>/dev/null || echo "Firewall não configurado"
echo ""

# Teste 4: Verificar usuários e permissões
echo "🔍 Teste 4: Verificar usuários e permissões"
echo "Usuários com shell de login:"
grep -E "/(bash|sh)$" /etc/passwd
echo ""

echo "Usuários com sudo:"
grep -E "^sudo" /etc/group
echo ""

# Teste 5: Verificar logs de segurança
echo "🔍 Teste 5: Verificar logs de segurança"
echo "Últimas tentativas de login:"
last | head -5
echo ""

echo "Tentativas de login falhadas:"
lastb | head -5
echo ""

echo "✅ Teste de penetração básico concluído"
EOF

chmod +x teste_penetracao.sh
echo "📄 Script de teste de penetração criado: teste_penetracao.sh"
echo ""

# Cenário 7: Simulação de ataque DDoS
echo "📝 CENÁRIO 7: Simulação de ataque DDoS"
echo "====================================="
echo "🎯 Situação: Simular e defender contra ataque DDoS"
echo ""

# Criar script de simulação DDoS
cat > simular_ddos.sh << 'EOF'
#!/bin/bash
# Script de simulação de ataque DDoS - MINFIN Angola

echo "⚠️  SIMULAÇÃO DE ATAQUE DDOS - APENAS PARA TESTES"
echo "Data/Hora: $(date)"
echo ""

# Função para simular tráfego
simulate_traffic() {
    local target=$1
    local duration=$2
    
    echo "🎯 Simulando tráfego para $target por $duration segundos"
    
    # Simular ping flood
    ping -f -c 100 $target &
    ping_pid=$!
    
    # Simular requisições HTTP
    for i in {1..50}; do
        curl -s $target >/dev/null 2>&1 &
    done
    
    # Aguardar duração especificada
    sleep $duration
    
    # Parar processos
    kill $ping_pid 2>/dev/null
    pkill -f "curl.*$target" 2>/dev/null
    
    echo "✅ Simulação concluída"
}

# Simular ataque para localhost (apenas para teste)
simulate_traffic "127.0.0.1" "10"

echo "⚠️  ATENÇÃO: Este é apenas um teste de simulação!"
echo "Em um ambiente real, implemente:"
echo "- Rate limiting"
echo "- DDoS protection"
echo "- Load balancing"
echo "- CDN"
EOF

chmod +x simular_ddos.sh
echo "📄 Script de simulação DDoS criado: simular_ddos.sh"
echo ""

# Cenário 8: Relatório de segurança
echo "📝 CENÁRIO 8: Relatório de segurança"
echo "==================================="
echo "🎯 Situação: Gerar relatório completo de segurança"
echo ""

# Criar script de relatório
cat > gerar_relatorio_seguranca.sh << 'EOF'
#!/bin/bash
# Script de geração de relatório de segurança - MINFIN Angola

REPORT_FILE="relatorio_seguranca_$(date +%Y%m%d_%H%M%S).txt"

echo "📋 GERANDO RELATÓRIO DE SEGURANÇA"
echo "Arquivo: $REPORT_FILE"
echo ""

# Função para adicionar seção ao relatório
add_section() {
    echo "" >> $REPORT_FILE
    echo "===============================================" >> $REPORT_FILE
    echo "$1" >> $REPORT_FILE
    echo "===============================================" >> $REPORT_FILE
    echo "" >> $REPORT_FILE
}

# Iniciar relatório
echo "RELATÓRIO DE SEGURANÇA - MINFIN ANGOLA" > $REPORT_FILE
echo "Data: $(date)" >> $REPORT_FILE
echo "Sistema: $(uname -a)" >> $REPORT_FILE

# Seção 1: Informações do sistema
add_section "INFORMAÇÕES DO SISTEMA"
uname -a >> $REPORT_FILE
echo "" >> $REPORT_FILE
cat /etc/os-release >> $REPORT_FILE

# Seção 2: Usuários e grupos
add_section "USUÁRIOS E GRUPOS"
echo "Usuários do sistema:" >> $REPORT_FILE
cat /etc/passwd >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Grupos do sistema:" >> $REPORT_FILE
cat /etc/group >> $REPORT_FILE

# Seção 3: Configurações de rede
add_section "CONFIGURAÇÕES DE REDE"
echo "Interfaces de rede:" >> $REPORT_FILE
ip addr show >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Tabela de roteamento:" >> $REPORT_FILE
ip route show >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Conexões ativas:" >> $REPORT_FILE
netstat -tuln >> $REPORT_FILE

# Seção 4: Serviços em execução
add_section "SERVIÇOS EM EXECUÇÃO"
systemctl list-units --type=service --state=active >> $REPORT_FILE

# Seção 5: Configurações de firewall
add_section "CONFIGURAÇÕES DE FIREWALL"
iptables -L -n >> $REPORT_FILE

# Seção 6: Logs de segurança
add_section "LOGS DE SEGURANÇA"
echo "Últimas tentativas de login:" >> $REPORT_FILE
last | head -20 >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Tentativas de login falhadas:" >> $REPORT_FILE
lastb | head -20 >> $REPORT_FILE

# Seção 7: Arquivos críticos
add_section "ARQUIVOS CRÍTICOS"
echo "Permissões de /etc/passwd:" >> $REPORT_FILE
ls -la /etc/passwd >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Permissões de /etc/shadow:" >> $REPORT_FILE
ls -la /etc/shadow >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Permissões de /etc/sudoers:" >> $REPORT_FILE
ls -la /etc/sudoers >> $REPORT_FILE

# Seção 8: Recomendações
add_section "RECOMENDAÇÕES DE SEGURANÇA"
cat >> $REPORT_FILE << 'RECOMMENDATIONS'
1. Manter sistemas atualizados
2. Implementar autenticação multifator
3. Configurar firewall adequadamente
4. Monitorar logs regularmente
5. Fazer backups regulares
6. Implementar detecção de intrusão
7. Educar usuários sobre segurança
8. Testar planos de contingência
9. Auditar permissões regularmente
10. Implementar criptografia
RECOMMENDATIONS

echo "✅ Relatório de segurança gerado: $REPORT_FILE"
echo "Tamanho do arquivo: $(wc -l < $REPORT_FILE) linhas"
EOF

chmod +x gerar_relatorio_seguranca.sh
echo "📄 Script de relatório criado: gerar_relatorio_seguranca.sh"
echo ""

# Cenário 9: Teste de todos os cenários
echo "📝 CENÁRIO 9: Teste de todos os cenários"
echo "======================================"
echo "🎯 Situação: Executar todos os cenários em sequência"
echo ""

# Criar script mestre
cat > executar_todos_cenarios.sh << 'EOF'
#!/bin/bash
# Script mestre para executar todos os cenários - MINFIN Angola

echo "🚀 EXECUTANDO TODOS OS CENÁRIOS DE REDES E SEGURANÇA"
echo "Data/Hora: $(date)"
echo ""

# Lista de scripts para executar
scripts=(
    "configurar_rede_departamentos.sh"
    "configurar_firewall.sh"
    "monitorar_seguranca.sh"
    "teste_penetracao.sh"
    "gerar_relatorio_seguranca.sh"
)

# Executar cada script
for script in "${scripts[@]}"; do
    if [ -f "$script" ]; then
        echo "▶️  Executando: $script"
        echo "----------------------------------------"
        ./$script
        echo ""
        echo "✅ $script concluído"
        echo ""
    else
        echo "❌ Script não encontrado: $script"
    fi
done

echo "🎉 Todos os cenários executados com sucesso!"
echo "Data/Hora de conclusão: $(date)"
EOF

chmod +x executar_todos_cenarios.sh
echo "📄 Script mestre criado: executar_todos_cenarios.sh"
echo ""

# Limpeza
echo "🧹 Limpando arquivos temporários:"
cd ..
rm -rf exercicios_cenarios
echo "✅ Limpeza concluída!"
echo ""

echo "🎯 RESUMO DOS CENÁRIOS CRIADOS:"
echo "• Diagnóstico de problemas de conectividade"
echo "• Configuração de rede para departamentos"
echo "• Implementação de firewall básico"
echo "• Monitoramento de segurança"
echo "• Resposta a incidentes de segurança"
echo "• Teste de penetração básico"
echo "• Simulação de ataque DDoS"
echo "• Geração de relatório de segurança"
echo "• Script mestre para executar todos os cenários"
echo ""

echo "✅ Exercício de cenários práticos concluído!"
echo "=================================================="
