#!/bin/bash

# =============================================================================
# EXERCÍCIO PRÁTICO: CONFIGURAÇÃO SSH SEGURO - MÓDULO 5
# Ministério das Finanças de Angola - Treinamento Linux Avançado
# =============================================================================

echo "🔐 EXERCÍCIO: CONFIGURAÇÃO SSH SEGURO - MINFIN"
echo "=============================================="
echo ""

# Verificar se é root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Este exercício deve ser executado como root (sudo)"
    exit 1
fi

echo "🔧 Comando: Fazer backup da configuração SSH atual"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup.$(date +%Y%m%d_%H%M%S)
echo ""

echo "🔧 Comando: Gerar chaves SSH para administradores MINFIN"
ssh-keygen -t rsa -b 4096 -f /home/minfin_admin/.ssh/id_rsa -N "" -C "minfin_admin@minfin.gov.ao"
ssh-keygen -t rsa -b 4096 -f /home/minfin_ti/.ssh/id_rsa -N "" -C "minfin_ti@minfin.gov.ao"
echo ""

echo "🔧 Comando: Configurar permissões das chaves"
chown minfin_admin:minfin_admin /home/minfin_admin/.ssh/id_rsa*
chown minfin_ti:minfin_ti /home/minfin_ti/.ssh/id_rsa*
chmod 600 /home/minfin_admin/.ssh/id_rsa
chmod 600 /home/minfin_ti/.ssh/id_rsa
chmod 644 /home/minfin_admin/.ssh/id_rsa.pub
chmod 644 /home/minfin_ti/.ssh/id_rsa.pub
echo ""

echo "🔧 Comando: Configurar SSH com máxima segurança"
cat > /etc/ssh/sshd_config << 'EOF'
# Configuração SSH Seguro - MINFIN Angola
# Porta personalizada
Port 2222

# Desabilitar login root
PermitRootLogin no

# Autenticação por chave pública apenas
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

# Configurações de segurança
MaxAuthTries 3
MaxSessions 2
ClientAliveInterval 300
ClientAliveCountMax 2
LoginGraceTime 60

# Usuários permitidos
AllowUsers minfin_admin minfin_ti

# Desabilitar protocolos inseguros
Protocol 2

# Configurações de logging
SyslogFacility AUTH
LogLevel INFO

# Configurações de rede
AllowTcpForwarding no
X11Forwarding no
PermitTunnel no
GatewayPorts no

# Configurações de banner
Banner /etc/ssh/banner
EOF
echo ""

echo "🔧 Comando: Criar banner de segurança"
cat > /etc/ssh/banner << 'EOF'
***************************************************************************
*                    MINISTÉRIO DAS FINANÇAS - ANGOLA                    *
*                                                                         *
*  ATENÇÃO: Este é um sistema restrito. Acesso autorizado apenas para    *
*  funcionários do Ministério das Finanças. Todas as atividades são      *
*  monitoradas e registradas. Uso não autorizado é proibido por lei.     *
*                                                                         *
*  Acesso: $(date)                                                       *
*  Usuário: $(whoami)                                                    *
*                                                                         *
***************************************************************************
EOF
echo ""

echo "🔧 Comando: Configurar chaves autorizadas"
mkdir -p /home/minfin_admin/.ssh
mkdir -p /home/minfin_ti/.ssh
cp /home/minfin_admin/.ssh/id_rsa.pub /home/minfin_admin/.ssh/authorized_keys
cp /home/minfin_ti/.ssh/id_rsa.pub /home/minfin_ti/.ssh/authorized_keys
chown minfin_admin:minfin_admin /home/minfin_admin/.ssh/authorized_keys
chown minfin_ti:minfin_ti /home/minfin_ti/.ssh/authorized_keys
chmod 600 /home/minfin_admin/.ssh/authorized_keys
chmod 600 /home/minfin_ti/.ssh/authorized_keys
echo ""

echo "🔧 Comando: Configurar fail2ban para SSH"
apt update && apt install -y fail2ban
echo ""

echo "🔧 Comando: Configurar jail para SSH"
cat > /etc/fail2ban/jail.local << 'EOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3

[sshd]
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
EOF
echo ""

echo "🔧 Comando: Iniciar e habilitar fail2ban"
systemctl enable fail2ban
systemctl start fail2ban
echo ""

echo "🔧 Comando: Testar configuração SSH"
sshd -t
echo ""

echo "🔧 Comando: Reiniciar serviço SSH"
systemctl restart ssh
echo ""

echo "🔧 Comando: Verificar status do SSH"
systemctl status ssh
echo ""

echo "🔧 Comando: Verificar portas abertas"
ss -tuln | grep 2222
echo ""

echo "🔧 Comando: Testar conexão SSH local"
ssh -p 2222 -o StrictHostKeyChecking=no minfin_admin@localhost "echo 'Conexão SSH funcionando!'"
echo ""

echo "🔧 Comando: Verificar logs de SSH"
tail -10 /var/log/auth.log | grep sshd
echo ""

echo "🔧 Comando: Verificar status do fail2ban"
fail2ban-client status sshd
echo ""

echo "🔧 Comando: Criar script de monitoramento SSH"
cat > /usr/local/bin/monitor-ssh-minfin.sh << 'EOF'
#!/bin/bash
# Script de monitoramento SSH MINFIN
LOG_FILE="/var/log/ssh-monitor-minfin.log"
echo "=== Monitoramento SSH MINFIN $(date) ===" >> $LOG_FILE
echo "Conexões ativas:" >> $LOG_FILE
ss -tuln | grep 2222 >> $LOG_FILE
echo "Últimas tentativas de login:" >> $LOG_FILE
tail -20 /var/log/auth.log | grep sshd >> $LOG_FILE
echo "Status fail2ban:" >> $LOG_FILE
fail2ban-client status sshd >> $LOG_FILE
echo "=================================" >> $LOG_FILE
EOF
chmod +x /usr/local/bin/monitor-ssh-minfin.sh
echo ""

echo "🔧 Comando: Executar monitoramento"
/usr/local/bin/monitor-ssh-minfin.sh
echo ""

echo "🔧 Comando: Configurar monitoramento automático"
echo "0 */6 * * * /usr/local/bin/monitor-ssh-minfin.sh" | crontab -
echo ""

echo "✅ EXERCÍCIO CONCLUÍDO!"
echo "======================="
echo ""
echo "📋 RESUMO DO QUE FOI CONFIGURADO:"
echo "• SSH configurado na porta 2222"
echo "• Autenticação por chave pública apenas"
echo "• Login root desabilitado"
echo "• Fail2ban configurado para proteção"
echo "• Banner de segurança implementado"
echo "• Monitoramento automático configurado"
echo ""
echo "🎯 PRÓXIMOS PASSOS:"
echo "• Testar conexão SSH externa"
echo "• Configurar backup das chaves"
echo "• Implementar rotação de logs"
echo "• Configurar alertas de segurança"
echo ""
