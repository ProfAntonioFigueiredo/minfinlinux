#!/bin/bash

# =============================================================================
# EXERCÍCIO: IMPLEMENTAÇÃO DE CONTROLES DE ACESSO
# Módulo 2 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🔒 EXERCÍCIO: IMPLEMENTAÇÃO DE CONTROLES DE ACESSO"
echo "================================================"
echo ""

# Verificar se temos privilégios adequados
if [ "$EUID" -ne 0 ]; then
    echo "⚠️  Este exercício requer privilégios de root (sudo)."
    echo "Execute com: sudo ./exercicio_controles_acesso.sh"
    exit 1
fi

echo "✅ Executando como root. Privilégios adequados confirmados."
echo "📍 Diretório atual: $(pwd)"
echo ""

# Criar diretório de trabalho
echo "📁 Criando diretório de trabalho para exercícios de segurança:"
mkdir -p exercicios_seguranca
cd exercicios_seguranca
echo "✅ Diretório criado: $(pwd)"
echo ""

# Exercício 1: Implementar política de senhas seguras
echo "📝 EXERCÍCIO 1: Política de senhas seguras"
echo "----------------------------------------"
echo "🔐 Configurando política de senhas no PAM:"
echo ""

# Verificar se libpam-pwquality está instalado
if ! dpkg -l | grep -q libpam-pwquality; then
    echo "📦 Instalando libpam-pwquality..."
    apt update && apt install -y libpam-pwquality
fi

# Configurar política de senhas
cat > /etc/security/pwquality.conf << 'EOF'
# Política de senhas seguras - MINFIN Angola
# Mínimo 8 caracteres
minlen = 8
# Pelo menos 1 dígito
dcredit = -1
# Pelo menos 1 letra minúscula
lcredit = -1
# Pelo menos 1 letra maiúscula
ucredit = -1
# Pelo menos 1 caractere especial
ocredit = -1
# Não permitir sequências simples
maxsequence = 3
# Não permitir repetições
maxrepeat = 2
# Verificar se não é palavra do dicionário
dictcheck = 1
EOF

echo "✅ Política de senhas configurada em /etc/security/pwquality.conf"
echo ""

# Exercício 2: Configurar grupos departamentais e permissões
echo "📝 EXERCÍCIO 2: Grupos departamentais e permissões"
echo "------------------------------------------------"
echo "🏢 Criando estrutura organizacional:"
echo ""

# Criar grupos departamentais
echo "👥 Criando grupos departamentais:"
groupadd -g 1001 ti
groupadd -g 1002 financeiro
groupadd -g 1003 rh
groupadd -g 1004 administracao
groupadd -g 1005 auditores

echo "✅ Grupos criados:"
getent group ti financeiro rh administracao auditores
echo ""

# Criar usuários para cada departamento
echo "👤 Criando usuários departamentais:"
useradd -m -s /bin/bash -g ti -G auditores joao.ti
useradd -m -s /bin/bash -g financeiro maria.fin
useradd -m -s /bin/bash -g rh pedro.rh
useradd -m -s /bin/bash -g administracao ana.admin
useradd -m -s /bin/bash -g auditores carlos.auditor

# Definir senhas (em produção, usar senhas seguras)
echo "senha123" | passwd --stdin joao.ti > /dev/null 2>&1
echo "senha123" | passwd --stdin maria.fin > /dev/null 2>&1
echo "senha123" | passwd --stdin pedro.rh > /dev/null 2>&1
echo "senha123" | passwd --stdin ana.admin > /dev/null 2>&1
echo "senha123" | passwd --stdin carlos.auditor > /dev/null 2>&1

echo "✅ Usuários criados com senhas definidas"
echo ""

# Exercício 3: Implementar controle de acesso baseado em grupos
echo "📝 EXERCÍCIO 3: Controle de acesso baseado em grupos"
echo "--------------------------------------------------"
echo "📁 Criando estrutura de diretórios departamentais:"
echo ""

# Criar diretórios departamentais
mkdir -p /home/departamentos/{ti,financeiro,rh,administracao,compartilhado}
mkdir -p /home/departamentos/ti/{scripts,logs,backups}
mkdir -p /home/departamentos/financeiro/{relatorios,contas,auditoria}
mkdir -p /home/departamentos/rh/{funcionarios,folha,treinamentos}
mkdir -p /home/departamentos/administracao/{documentos,reunioes,estrategia}

echo "📋 Estrutura de diretórios criada:"
tree /home/departamentos 2>/dev/null || find /home/departamentos -type d | sort
echo ""

# Configurar permissões por departamento
echo "🔐 Configurando permissões por departamento:"

# TI - Acesso total ao seu diretório
chown -R joao.ti:ti /home/departamentos/ti
chmod -R 750 /home/departamentos/ti

# Financeiro - Acesso restrito
chown -R maria.fin:financeiro /home/departamentos/financeiro
chmod -R 750 /home/departamentos/financeiro

# RH - Acesso restrito
chown -R pedro.rh:rh /home/departamentos/rh
chmod -R 750 /home/departamentos/rh

# Administração - Acesso restrito
chown -R ana.admin:administracao /home/departamentos/administracao
chmod -R 750 /home/departamentos/administracao

# Compartilhado - Acesso de leitura para todos
chown root:root /home/departamentos/compartilhado
chmod 755 /home/departamentos/compartilhado

echo "✅ Permissões configuradas"
echo ""

# Exercício 4: Implementar auditoria de acesso
echo "📝 EXERCÍCIO 4: Auditoria de acesso"
echo "----------------------------------"
echo "📊 Configurando logging de auditoria:"
echo ""

# Configurar auditd para monitorar acessos
if ! command -v auditctl >/dev/null 2>&1; then
    echo "📦 Instalando auditd..."
    apt update && apt install -y auditd audispd-plugins
fi

# Configurar regras de auditoria
cat > /etc/audit/rules.d/minfin-audit.rules << 'EOF'
# Regras de auditoria - MINFIN Angola

# Monitorar acessos a arquivos sensíveis
-w /home/departamentos/financeiro -p rwxa -k financeiro_access
-w /home/departamentos/rh -p rwxa -k rh_access
-w /home/departamentos/administracao -p rwxa -k admin_access

# Monitorar comandos privilegiados
-w /usr/bin/sudo -p x -k privileged_commands
-w /usr/bin/su -p x -k privileged_commands

# Monitorar alterações de usuários e grupos
-w /etc/passwd -p wa -k user_changes
-w /etc/group -p wa -k group_changes
-w /etc/shadow -p wa -k password_changes

# Monitorar alterações de permissões
-w /etc/sudoers -p wa -k sudo_changes
-w /etc/ssh/sshd_config -p wa -k ssh_changes
EOF

# Reiniciar auditd
systemctl restart auditd
systemctl enable auditd

echo "✅ Regras de auditoria configuradas"
echo ""

# Exercício 5: Implementar controle de acesso temporal
echo "📝 EXERCÍCIO 5: Controle de acesso temporal"
echo "----------------------------------------"
echo "⏰ Configurando restrições de horário de acesso:"
echo ""

# Configurar PAM para restrições de horário
cat > /etc/security/time.conf << 'EOF'
# Restrições de horário - MINFIN Angola
# TI: 24/7
# Financeiro: 08:00-18:00, segunda a sexta
# RH: 08:00-17:00, segunda a sexta
# Administração: 08:00-18:00, segunda a sexta
# Auditores: 09:00-17:00, segunda a sexta

*;*;joao.ti;!Wd0000-2400
*;*;maria.fin;Wd0800-1800
*;*;pedro.rh;Wd0800-1700
*;*;ana.admin;Wd0800-1800
*;*;carlos.auditor;Wd0900-1700
EOF

echo "✅ Restrições de horário configuradas"
echo ""

# Exercício 6: Implementar monitoramento de atividades
echo "📝 EXERCÍCIO 6: Monitoramento de atividades"
echo "-----------------------------------------"
echo "👁️ Configurando monitoramento de atividades:"
echo ""

# Criar script de monitoramento
cat > /usr/local/bin/monitor_acesso.sh << 'EOF'
#!/bin/bash
# Script de monitoramento de acesso - MINFIN Angola

LOG_FILE="/var/log/acesso_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Função para log
log_event() {
    echo "[$DATE] $1" >> $LOG_FILE
}

# Monitorar logins
last | head -10 | while read line; do
    if [[ $line =~ ^[a-zA-Z] ]]; then
        user=$(echo $line | awk '{print $1}')
        log_event "LOGIN: $user"
    fi
done

# Monitorar comandos sudo
if [ -f /var/log/auth.log ]; then
    grep "sudo:" /var/log/auth.log | tail -5 | while read line; do
        log_event "SUDO: $line"
    done
done

# Monitorar alterações de arquivos sensíveis
find /home/departamentos -type f -mmin -60 2>/dev/null | while read file; do
    log_event "FILE_MODIFIED: $file"
done

echo "Monitoramento executado em $DATE"
EOF

chmod +x /usr/local/bin/monitor_acesso.sh

# Configurar cron para executar a cada hora
echo "0 * * * * root /usr/local/bin/monitor_acesso.sh" >> /etc/crontab

echo "✅ Script de monitoramento configurado"
echo ""

# Exercício 7: Implementar backup de configurações de segurança
echo "📝 EXERCÍCIO 7: Backup de configurações de segurança"
echo "--------------------------------------------------"
echo "💾 Criando backup das configurações de segurança:"
echo ""

# Criar diretório de backup
mkdir -p /backup/seguranca/$(date +%Y%m%d)

# Backup de configurações importantes
cp /etc/passwd /backup/seguranca/$(date +%Y%m%d)/
cp /etc/group /backup/seguranca/$(date +%Y%m%d)/
cp /etc/shadow /backup/seguranca/$(date +%Y%m%d)/
cp /etc/sudoers /backup/seguranca/$(date +%Y%m%d)/
cp -r /etc/security /backup/seguranca/$(date +%Y%m%d)/
cp -r /etc/audit /backup/seguranca/$(date +%Y%m%d)/

# Criar script de backup automático
cat > /usr/local/bin/backup_seguranca.sh << 'EOF'
#!/bin/bash
# Script de backup de segurança - MINFIN Angola

BACKUP_DIR="/backup/seguranca/$(date +%Y%m%d)"
mkdir -p $BACKUP_DIR

# Backup de configurações
cp /etc/passwd $BACKUP_DIR/
cp /etc/group $BACKUP_DIR/
cp /etc/shadow $BACKUP_DIR/
cp /etc/sudoers $BACKUP_DIR/
cp -r /etc/security $BACKUP_DIR/
cp -r /etc/audit $BACKUP_DIR/

# Backup de logs de auditoria
if [ -f /var/log/audit/audit.log ]; then
    cp /var/log/audit/audit.log $BACKUP_DIR/
fi

# Compactar backup
cd /backup/seguranca
tar -czf "seguranca_$(date +%Y%m%d_%H%M%S).tar.gz" $(date +%Y%m%d)
rm -rf $(date +%Y%m%d)

echo "Backup de segurança criado: seguranca_$(date +%Y%m%d_%H%M%S).tar.gz"
EOF

chmod +x /usr/local/bin/backup_seguranca.sh

echo "✅ Script de backup configurado"
echo ""

# Exercício 8: Testar controles implementados
echo "📝 EXERCÍCIO 8: Testar controles implementados"
echo "---------------------------------------------"
echo "🧪 Testando os controles de acesso implementados:"
echo ""

echo "📊 Verificando grupos e usuários:"
echo "Grupos criados:"
getent group ti financeiro rh administracao auditores
echo ""

echo "Usuários criados:"
getent passwd joao.ti maria.fin pedro.rh ana.admin carlos.auditor
echo ""

echo "📊 Verificando permissões dos diretórios:"
ls -la /home/departamentos/
echo ""

echo "📊 Verificando regras de auditoria:"
auditctl -l
echo ""

echo "📊 Verificando configurações de segurança:"
echo "Política de senhas:"
grep -v "^#" /etc/security/pwquality.conf | grep -v "^$"
echo ""

echo "Restrições de horário:"
cat /etc/security/time.conf
echo ""

# Exercício 9: Cenário prático de violação de segurança
echo "📝 EXERCÍCIO 9: Cenário prático de violação de segurança"
echo "-----------------------------------------------------"
echo "🚨 Simulando tentativa de acesso não autorizado:"
echo ""

# Criar arquivo sensível
echo "Dados confidenciais do financeiro" > /home/departamentos/financeiro/dados_sensiveis.txt
chown maria.fin:financeiro /home/departamentos/financeiro/dados_sensiveis.txt
chmod 600 /home/departamentos/financeiro/dados_sensiveis.txt

echo "📄 Arquivo sensível criado: /home/departamentos/financeiro/dados_sensiveis.txt"
echo ""

# Simular tentativa de acesso não autorizado
echo "🔍 Tentativa de acesso não autorizado (como usuário TI):"
sudo -u joao.ti cat /home/departamentos/financeiro/dados_sensiveis.txt 2>&1 || echo "❌ Acesso negado - Controle de segurança funcionando!"
echo ""

# Verificar logs de auditoria
echo "📊 Verificando logs de auditoria:"
if [ -f /var/log/audit/audit.log ]; then
    tail -5 /var/log/audit/audit.log | grep "financeiro_access" || echo "ℹ️  Logs de auditoria em /var/log/audit/audit.log"
else
    echo "ℹ️  Logs de auditoria serão criados conforme as regras configuradas"
fi
echo ""

# Exercício 10: Relatório de segurança
echo "📝 EXERCÍCIO 10: Relatório de segurança"
echo "-------------------------------------"
echo "📋 Gerando relatório de configurações de segurança:"
echo ""

cat > relatorio_seguranca.txt << EOF
===============================================
RELATÓRIO DE SEGURANÇA - MINFIN ANGOLA
Data: $(date)
===============================================

1. GRUPOS DEPARTAMENTAIS CRIADOS:
$(getent group ti financeiro rh administracao auditores)

2. USUÁRIOS CRIADOS:
$(getent passwd joao.ti maria.fin pedro.rh ana.admin carlos.auditor)

3. ESTRUTURA DE DIRETÓRIOS:
$(find /home/departamentos -type d | sort)

4. PERMISSÕES CONFIGURADAS:
$(ls -la /home/departamentos/)

5. POLÍTICA DE SENHAS:
$(grep -v "^#" /etc/security/pwquality.conf | grep -v "^$")

6. REGRAS DE AUDITORIA:
$(auditctl -l)

7. CONTROLES IMPLEMENTADOS:
- Política de senhas seguras
- Controle de acesso baseado em grupos
- Auditoria de atividades
- Restrições de horário
- Monitoramento de arquivos
- Backup de configurações

8. RECOMENDAÇÕES:
- Revisar logs de auditoria regularmente
- Atualizar senhas periodicamente
- Testar restauração de backups
- Monitorar tentativas de acesso suspeitas
- Manter sistemas atualizados

===============================================
EOF

echo "📄 Relatório criado: relatorio_seguranca.txt"
echo ""

# Limpeza
echo "🧹 Limpando arquivos temporários:"
cd ..
rm -rf exercicios_seguranca
echo "✅ Limpeza concluída!"
echo ""

echo "🎯 RESUMO DOS CONTROLES IMPLEMENTADOS:"
echo "• Política de senhas seguras configurada"
echo "• Grupos departamentais criados e organizados"
echo "• Controle de acesso baseado em grupos implementado"
echo "• Auditoria de atividades configurada"
echo "• Restrições de horário de acesso definidas"
echo "• Monitoramento de atividades implementado"
echo "• Backup de configurações de segurança configurado"
echo "• Testes de violação de segurança realizados"
echo "• Relatório de segurança gerado"
echo ""

echo "✅ Exercício de controles de acesso concluído!"
echo "==============================================="
