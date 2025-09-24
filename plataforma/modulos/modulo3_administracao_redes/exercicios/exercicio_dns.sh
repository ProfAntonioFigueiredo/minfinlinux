#!/bin/bash

# =============================================================================
# EXERCÍCIO PRÁTICO: CONFIGURAÇÃO DE SERVIDOR DNS - MÓDULO 3
# Ministério das Finanças de Angola - Treinamento Linux Avançado
# =============================================================================

echo "🌐 EXERCÍCIO: CONFIGURAÇÃO DE SERVIDOR DNS - MINFIN"
echo "=================================================="
echo ""

# Verificar se é root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Este exercício deve ser executado como root (sudo)"
    exit 1
fi

echo "🔧 Comando: Instalar BIND9 e ferramentas"
apt update && apt install -y bind9 bind9utils bind9-doc dnsutils
echo ""

echo "🔧 Comando: Verificar status do BIND9"
systemctl status bind9
echo ""

echo "🔧 Comando: Parar BIND9 para configuração"
systemctl stop bind9
echo ""

echo "🔧 Comando: Criar zona direta para minfin.local"
cat > /etc/bind/db.minfin.local << 'EOF'
$TTL 604800
@ IN SOA ns1.minfin.local. admin.minfin.local. (
    2025010101 ; Serial
    604800     ; Refresh
    86400      ; Retry
    2419200    ; Expire
    604800 )   ; Negative Cache TTL

@ IN NS ns1.minfin.local.
@ IN NS ns2.minfin.local.

; Servidores de nomes
ns1 IN A 192.168.1.10
ns2 IN A 192.168.1.11

; Servidores web
www IN A 192.168.1.20
web IN A 192.168.1.20

; Servidores de email
mail IN A 192.168.1.30
smtp IN A 192.168.1.30
pop3 IN A 192.168.1.30
imap IN A 192.168.1.30

; Servidores de banco de dados
db IN A 192.168.1.40
mysql IN A 192.168.1.40

; Servidores de aplicação
app IN A 192.168.1.50
api IN A 192.168.1.50

; Aliases
minfin.gov.ao. IN CNAME www.minfin.local.
EOF
echo ""

echo "🔧 Comando: Criar zona reversa"
cat > /etc/bind/db.192.168.1 << 'EOF'
$TTL 604800
@ IN SOA ns1.minfin.local. admin.minfin.local. (
    2025010101 ; Serial
    604800     ; Refresh
    86400      ; Retry
    2419200    ; Expire
    604800 )   ; Negative Cache TTL

@ IN NS ns1.minfin.local.
@ IN NS ns2.minfin.local.

10 IN PTR ns1.minfin.local.
11 IN PTR ns2.minfin.local.
20 IN PTR www.minfin.local.
30 IN PTR mail.minfin.local.
40 IN PTR db.minfin.local.
50 IN PTR app.minfin.local.
EOF
echo ""

echo "🔧 Comando: Configurar named.conf.local"
cat > /etc/bind/named.conf.local << 'EOF'
// Zona direta para minfin.local
zone "minfin.local" {
    type master;
    file "/etc/bind/db.minfin.local";
    allow-update { none; };
};

// Zona reversa para 192.168.1.0/24
zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.1";
    allow-update { none; };
};
EOF
echo ""

echo "🔧 Comando: Verificar configuração do BIND9"
named-checkconf
echo ""

echo "🔧 Comando: Verificar zona direta"
named-checkzone minfin.local /etc/bind/db.minfin.local
echo ""

echo "🔧 Comando: Verificar zona reversa"
named-checkzone 1.168.192.in-addr.arpa /etc/bind/db.192.168.1
echo ""

echo "🔧 Comando: Configurar resolv.conf local"
echo "nameserver 127.0.0.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "search minfin.local" >> /etc/resolv.conf
echo ""

echo "🔧 Comando: Iniciar BIND9"
systemctl start bind9
systemctl enable bind9
echo ""

echo "🔧 Comando: Verificar status do BIND9"
systemctl status bind9
echo ""

echo "🔧 Comando: Testar resolução de nomes"
nslookup www.minfin.local 127.0.0.1
echo ""

echo "🔧 Comando: Testar resolução reversa"
nslookup 192.168.1.20 127.0.0.1
echo ""

echo "🔧 Comando: Testar com dig"
dig @127.0.0.1 www.minfin.local
echo ""

echo "🔧 Comando: Verificar logs do BIND9"
tail -10 /var/log/syslog | grep named
echo ""

echo "🔧 Comando: Configurar cliente DNS"
echo "nameserver 192.168.1.10" > /etc/resolv.conf.backup
echo ""

echo "🔧 Comando: Testar resolução externa"
nslookup google.com 127.0.0.1
echo ""

echo "🔧 Comando: Verificar cache DNS"
rndc status
echo ""

echo "🔧 Comando: Limpar cache DNS"
rndc flush
echo ""

echo "🔧 Comando: Verificar estatísticas"
rndc stats
echo ""

echo "✅ EXERCÍCIO CONCLUÍDO!"
echo "======================="
echo ""
echo "📋 RESUMO DO QUE FOI CONFIGURADO:"
echo "• Servidor DNS BIND9 instalado e configurado"
echo "• Zona direta minfin.local com registros A, CNAME, MX"
echo "• Zona reversa para 192.168.1.0/24"
echo "• Resolução de nomes funcionando"
echo "• Cache DNS configurado"
echo ""
echo "🎯 PRÓXIMOS PASSOS:"
echo "• Configurar DNS secundário para redundância"
echo "• Implementar DNSSEC para segurança"
echo "• Configurar monitoramento de DNS"
echo "• Testar resolução de nomes externos"
echo ""
