#!/bin/bash

# =============================================================================
# EXERCÍCIO PRÁTICO: CONFIGURAÇÃO DE REDE AVANÇADA - MÓDULO 3
# Ministério das Finanças de Angola - Treinamento Linux Avançado
# =============================================================================

echo "🌐 EXERCÍCIO: CONFIGURAÇÃO DE REDE AVANÇADA - MINFIN"
echo "=================================================="
echo ""

# Verificar se é root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Este exercício deve ser executado como root (sudo)"
    exit 1
fi

echo "🔧 Comando: Verificar interfaces de rede disponíveis"
ip link show
echo ""

echo "🔧 Comando: Verificar configuração atual de IP"
ip addr show
echo ""

echo "🔧 Comando: Instalar ferramentas de rede avançadas"
apt update && apt install -y vlan bridge-utils
echo ""

echo "🔧 Comando: Carregar módulo 8021q para VLANs"
modprobe 8021q
echo "8021q" >> /etc/modules
echo ""

echo "🔧 Comando: Criar VLAN 100 para departamento de TI"
ip link add link eth0 name eth0.100 type vlan id 100
echo ""

echo "🔧 Comando: Configurar endereço IP para VLAN 100"
ip addr add 192.168.100.1/24 dev eth0.100
echo ""

echo "🔧 Comando: Ativar interface VLAN"
ip link set dev eth0.100 up
echo ""

echo "🔧 Comando: Verificar configuração VLAN"
ip addr show eth0.100
echo ""

echo "🔧 Comando: Configurar bonding para redundância"
modprobe bonding
ip link add bond0 type bond
echo ""

echo "🔧 Comando: Configurar modo de bonding (active-backup)"
echo "mode=1" > /sys/class/net/bond0/bonding/mode
echo ""

echo "🔧 Comando: Adicionar interfaces ao bond (se disponíveis)"
if [ -d /sys/class/net/eth1 ]; then
    ip link set eth1 master bond0
    echo "Interface eth1 adicionada ao bond"
fi
if [ -d /sys/class/net/eth2 ]; then
    ip link set eth2 master bond0
    echo "Interface eth2 adicionada ao bond"
fi
echo ""

echo "🔧 Comando: Configurar IP do bond"
ip addr add 192.168.1.10/24 dev bond0
ip link set bond0 up
echo ""

echo "🔧 Comando: Verificar status do bond"
cat /proc/net/bonding/bond0
echo ""

echo "🔧 Comando: Testar conectividade"
ping -c 3 192.168.100.1
echo ""

echo "🔧 Comando: Verificar tabela de roteamento"
ip route show
echo ""

echo "🔧 Comando: Configurar rota estática (exemplo)"
ip route add 10.0.0.0/8 via 192.168.1.1
echo ""

echo "🔧 Comando: Verificar configuração final"
ip addr show
echo ""

echo "🔧 Comando: Salvar configuração permanente"
cat > /etc/netplan/99-minfin-vlans.yaml << 'EOF'
network:
  version: 2
  renderer: networkd
  vlans:
    eth0.100:
      id: 100
      link: eth0
      addresses:
        - 192.168.100.1/24
  bonds:
    bond0:
      interfaces:
        - eth1
        - eth2
      parameters:
        mode: active-backup
      addresses:
        - 192.168.1.10/24
EOF
echo ""

echo "🔧 Comando: Aplicar configuração Netplan"
netplan apply
echo ""

echo "✅ EXERCÍCIO CONCLUÍDO!"
echo "======================="
echo ""
echo "📋 RESUMO DO QUE FOI CONFIGURADO:"
echo "• VLAN 100 para departamento de TI (192.168.100.1/24)"
echo "• Bonding para redundância de interfaces"
echo "• Configuração permanente com Netplan"
echo "• Rotas estáticas configuradas"
echo ""
echo "🎯 PRÓXIMOS PASSOS:"
echo "• Testar conectividade entre VLANs"
echo "• Configurar firewall para VLANs"
echo "• Implementar monitoramento de rede"
echo ""
