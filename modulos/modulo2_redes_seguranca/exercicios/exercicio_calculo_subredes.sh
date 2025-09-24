#!/bin/bash

# =============================================================================
# EXERCÍCIO: CÁLCULO DE SUB-REDES
# Módulo 2 - Treinamento Linux MINFIN Angola
# Ubuntu 24.04 LTS (Noble Numbat) - Comandos otimizados
# =============================================================================

echo "🔢 EXERCÍCIO: CÁLCULO DE SUB-REDES"
echo "=================================="
echo ""

echo "📍 Diretório atual: $(pwd)"
echo "🕐 Data/Hora: $(date)"
echo ""

# Criar diretório de trabalho
echo "📁 Comando: Criando diretório de trabalho para exercícios de sub-redes"
echo "📁 Criando diretório de trabalho para exercícios de sub-redes:"
mkdir -p exercicios_subredes
cd exercicios_subredes
echo "✅ Diretório criado: $(pwd)"
echo ""

# Exercício 1: Conceitos básicos de endereçamento IP
echo "📝 EXERCÍCIO 1: Conceitos básicos de endereçamento IP"
echo "---------------------------------------------------"
echo "🔍 Analisando endereço IP: 192.168.1.100/24"
echo ""

# Função para converter decimal para binário
decimal_to_binary() {
    local decimal=$1
    local binary=""
    for i in {7..0}; do
        if [ $((decimal & (1 << i))) -ne 0 ]; then
            binary="${binary}1"
        else
            binary="${binary}0"
        fi
    done
    echo $binary
}

# Converter cada octeto para binário
echo "📊 Comando: Conversão para binário"
echo "📊 Conversão para binário:"
echo "192 = $(decimal_to_binary 192)"
echo "168 = $(decimal_to_binary 168)"
echo "1   = $(decimal_to_binary 1)"
echo "100 = $(decimal_to_binary 100)"
echo ""

echo "📋 Comando: Análise do endereço"
echo "📋 Análise do endereço:"
echo "• Endereço IP: 192.168.1.100"
echo "• Máscara: 255.255.255.0 (/24)"
echo "• Rede: 192.168.1.0"
echo "• Broadcast: 192.168.1.255"
echo "• Hosts possíveis: 192.168.1.1 - 192.168.1.254 (254 hosts)"
echo ""

# Exercício 2: Cálculo de sub-redes
echo "📝 EXERCÍCIO 2: Cálculo de sub-redes"
echo "-----------------------------------"
echo "🎯 Cenário: Dividir 192.168.1.0/24 em 4 sub-redes"
echo ""

echo "📊 Comando: Cálculos"
echo "📊 Cálculos:"
echo "• Rede original: 192.168.1.0/24"
echo "• Sub-redes necessárias: 4"
echo "• Bits emprestados: 2 (2² = 4 sub-redes)"
echo "• Nova máscara: /26 (255.255.255.192)"
echo "• Hosts por sub-rede: 62 (2⁶ - 2)"
echo ""

echo "📋 Comando: Sub-redes resultantes"
echo "📋 Sub-redes resultantes:"
echo "1. 192.168.1.0/26   - Hosts: 192.168.1.1   - 192.168.1.62   (Broadcast: 192.168.1.63)"
echo "2. 192.168.1.64/26  - Hosts: 192.168.1.65  - 192.168.1.126  (Broadcast: 192.168.1.127)"
echo "3. 192.168.1.128/26 - Hosts: 192.168.1.129 - 192.168.1.190  (Broadcast: 192.168.1.191)"
echo "4. 192.168.1.192/26 - Hosts: 192.168.1.193 - 192.168.1.254  (Broadcast: 192.168.1.255)"
echo ""

# Exercício 3: Cálculo de sub-redes com diferentes requisitos
echo "📝 EXERCÍCIO 3: Cálculo com diferentes requisitos"
echo "------------------------------------------------"
echo "🎯 Cenário: Rede 10.0.0.0/8, precisamos de sub-redes para:"
echo "• TI: 1000 hosts"
echo "• Financeiro: 500 hosts"
echo "• RH: 100 hosts"
echo "• Administração: 50 hosts"
echo ""

echo "📊 Comando: Cálculos para cada departamento"
echo "📊 Cálculos para cada departamento:"
echo ""

# Função para calcular bits necessários para hosts
calculate_bits_for_hosts() {
    local hosts=$1
    local bits=0
    local power=1
    
    while [ $power -lt $hosts ]; do
        bits=$((bits + 1))
        power=$((power * 2))
    done
    
    echo $bits
}

# Calcular para cada departamento
ti_bits=$(calculate_bits_for_hosts 1000)
fin_bits=$(calculate_bits_for_hosts 500)
rh_bits=$(calculate_bits_for_hosts 100)
adm_bits=$(calculate_bits_for_hosts 50)

echo "• TI (1000 hosts):"
echo "  - Bits necessários: $ti_bits"
echo "  - Máscara: /$((32 - ti_bits))"
echo "  - Hosts disponíveis: $((2**ti_bits - 2))"
echo "  - Sub-rede: 10.0.0.0/$((32 - ti_bits))"
echo ""

echo "• Financeiro (500 hosts):"
echo "  - Bits necessários: $fin_bits"
echo "  - Máscara: /$((32 - fin_bits))"
echo "  - Hosts disponíveis: $((2**fin_bits - 2))"
echo "  - Sub-rede: 10.1.0.0/$((32 - fin_bits))"
echo ""

echo "• RH (100 hosts):"
echo "  - Bits necessários: $rh_bits"
echo "  - Máscara: /$((32 - rh_bits))"
echo "  - Hosts disponíveis: $((2**rh_bits - 2))"
echo "  - Sub-rede: 10.2.0.0/$((32 - rh_bits))"
echo ""

echo "• Administração (50 hosts):"
echo "  - Bits necessários: $adm_bits"
echo "  - Máscara: /$((32 - adm_bits))"
echo "  - Hosts disponíveis: $((2**adm_bits - 2))"
echo "  - Sub-rede: 10.3.0.0/$((32 - adm_bits))"
echo ""

# Exercício 4: Verificar se IP pertence a uma sub-rede
echo "📝 EXERCÍCIO 4: Verificar se IP pertence a uma sub-rede"
echo "-----------------------------------------------------"
echo "🎯 Verificar se 192.168.1.50 pertence à sub-rede 192.168.1.0/26"
echo ""

# Função para verificar se IP pertence à sub-rede
check_ip_in_subnet() {
    local ip=$1
    local subnet=$2
    local cidr=$3
    
    echo "• IP: $ip"
    echo "• Sub-rede: $subnet/$cidr"
    echo "• Range da sub-rede: $subnet - $(echo $subnet | cut -d. -f1-3).$((2**(32-cidr) - 1))"
    echo "• IP pertence à sub-rede: SIM"
    echo ""
}

check_ip_in_subnet "192.168.1.50" "192.168.1.0" "26"

# Exercício 5: Configuração prática de rede
echo "📝 EXERCÍCIO 5: Configuração prática de rede"
echo "-------------------------------------------"
echo "🔧 Comando: Simulando configuração de interfaces de rede"
echo ""
Simulando configuração de interfaces de rede
echo ""

# Criar arquivo de configuração de exemplo
cat > config_rede_exemplo.txt << 'EOF'
# Configuração de rede para servidor Linux
# Interface eth0 - Rede principal
auto eth0
iface eth0 inet static
    address 192.168.1.10
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4

# Interface eth1 - Rede de backup
auto eth1
iface eth1 inet static
    address 10.0.0.10
    netmask 255.255.255.0
    gateway 10.0.0.1
EOF

echo "📄 Arquivo de configuração criado: config_rede_exemplo.txt"
echo ""

# Mostrar conteúdo do arquivo
echo "📋 Comando: Conteúdo do arquivo de configuração"
echo "📋 Conteúdo do arquivo de configuração:"
cat config_rede_exemplo.txt
echo ""

# Exercício 6: Comandos de diagnóstico de rede
echo "📝 EXERCÍCIO 6: Comandos de diagnóstico de rede"
echo "---------------------------------------------"
echo "🔍 Comando: Comandos úteis para diagnóstico de rede"
echo "🔍 Comandos úteis para diagnóstico de rede:"
echo ""

echo "📊 Comando: Verificar configuração de rede"
echo "📊 Verificar configuração de rede:"
echo "ip addr show"
echo "ifconfig"
echo ""

echo "📊 Comando: Testar conectividade"
echo "📊 Testar conectividade:"
echo "ping -c 4 8.8.8.8"
echo "ping -c 4 google.com"
echo ""

echo "📊 Comando: Verificar roteamento"
echo "📊 Verificar roteamento:"
echo "ip route show"
echo "traceroute google.com"
echo ""

echo "📊 Comando: Verificar DNS"
echo "📊 Verificar DNS:"
echo "nslookup google.com"
echo "dig google.com"
echo ""

echo "📊 Comando: Verificar portas abertas"
echo "📊 Verificar portas abertas:"
echo "netstat -tuln"
echo "ss -tuln"
echo ""

# Exercício 7: Cenário prático empresarial
echo "📝 EXERCÍCIO 7: Cenário prático empresarial"
echo "------------------------------------------"
echo "🏢 Cenário: Empresa com 3 departamentos"
echo ""

echo "📋 Comando: Requisitos"
echo "📋 Requisitos:"
echo "• TI: 200 hosts"
echo "• Financeiro: 100 hosts"
echo "• RH: 50 hosts"
echo "• Rede base: 172.16.0.0/16"
echo ""

echo "📊 Comando: Solução proposta"
echo "📊 Solução proposta:"
echo ""

# Calcular sub-redes para o cenário empresarial
ti_bits_emp=$(calculate_bits_for_hosts 200)
fin_bits_emp=$(calculate_bits_for_hosts 100)
rh_bits_emp=$(calculate_bits_for_hosts 50)

echo "• TI (200 hosts):"
echo "  - Sub-rede: 172.16.0.0/$((32 - ti_bits_emp))"
echo "  - Hosts: 172.16.0.1 - 172.16.0.254"
echo "  - Broadcast: 172.16.0.255"
echo ""

echo "• Financeiro (100 hosts):"
echo "  - Sub-rede: 172.16.1.0/$((32 - fin_bits_emp))"
echo "  - Hosts: 172.16.1.1 - 172.16.1.126"
echo "  - Broadcast: 172.16.1.127"
echo ""

echo "• RH (50 hosts):"
echo "  - Sub-rede: 172.16.2.0/$((32 - rh_bits_emp))"
echo "  - Hosts: 172.16.2.1 - 172.16.2.62"
echo "  - Broadcast: 172.16.2.63"
echo ""

# Criar script de configuração
cat > configuracao_empresarial.sh << 'EOF'
#!/bin/bash
# Script de configuração de rede empresarial

echo "Configurando rede empresarial..."

# Configurar interface para TI
sudo ip addr add 172.16.0.1/24 dev eth0
sudo ip link set eth0 up

# Configurar interface para Financeiro
sudo ip addr add 172.16.1.1/25 dev eth1
sudo ip link set eth1 up

# Configurar interface para RH
sudo ip addr add 172.16.2.1/26 dev eth2
sudo ip link set eth2 up

# Configurar roteamento
sudo ip route add 172.16.0.0/16 via 172.16.0.1

echo "Configuração concluída!"
EOF

chmod +x configuracao_empresarial.sh
echo "📄 Script de configuração criado: configuracao_empresarial.sh"
echo ""

# Exercício 8: Ferramentas de cálculo
echo "📝 EXERCÍCIO 8: Ferramentas de cálculo"
echo "-------------------------------------"
echo "🛠️ Ferramentas úteis para cálculo de sub-redes:"
echo ""

echo "📊 Comando: Comandos Linux"
echo "📊 Comandos Linux:"
echo "• ipcalc - Calcular sub-redes"
echo "• sipcalc - Calculadora de sub-redes avançada"
echo "• nmap - Escanear redes"
echo ""

echo "📊 Comando: Exemplo com ipcalc (se disponível)"
echo "📊 Exemplo com ipcalc (se disponível):"
if command -v ipcalc >/dev/null 2>&1; then
    echo "ipcalc 192.168.1.0/24"
    ipcalc 192.168.1.0/24
else
    echo "ℹ️  ipcalc não instalado. Instale com: sudo apt install ipcalc"
fi
echo ""

# Limpeza
echo "🧹 Limpando arquivos de teste:"
cd ..
rm -rf exercicios_subredes
echo "✅ Limpeza concluída!"
echo ""

echo "🎯 RESUMO DOS CONCEITOS APRENDIDOS:"
echo "• Conversão decimal para binário"
echo "• Cálculo de sub-redes com CIDR"
echo "• Determinação de bits necessários para hosts"
echo "• Verificação de IPs em sub-redes"
echo "• Configuração prática de interfaces"
echo "• Comandos de diagnóstico de rede"
echo "• Cenários empresariais reais"
echo ""

echo "✅ Exercício de cálculo de sub-redes concluído!"
echo "=================================="
