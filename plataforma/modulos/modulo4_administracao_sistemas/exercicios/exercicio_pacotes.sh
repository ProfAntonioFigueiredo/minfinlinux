#!/bin/bash

# =============================================================================
# EXERCÍCIO PRÁTICO: GERENCIAMENTO DE PACOTES - MÓDULO 4
# Ministério das Finanças de Angola - Treinamento Linux Avançado
# =============================================================================

echo "📦 EXERCÍCIO: GERENCIAMENTO DE PACOTES - MINFIN"
echo "=============================================="
echo ""

# Verificar se é root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Este exercício deve ser executado como root (sudo)"
    exit 1
fi

echo "🔧 Comando: Atualizar lista de pacotes"
apt update
echo ""

echo "🔧 Comando: Verificar pacotes que podem ser atualizados"
apt list --upgradable
echo ""

echo "🔧 Comando: Atualizar sistema"
apt upgrade -y
echo ""

echo "🔧 Comando: Instalar pacotes essenciais para MINFIN"
apt install -y curl wget git vim htop tree net-tools
echo ""

echo "🔧 Comando: Verificar informações do sistema"
lsb_release -a
echo ""

echo "🔧 Comando: Verificar arquitetura"
uname -m
echo ""

echo "🔧 Comando: Adicionar repositório do Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo ""

echo "🔧 Comando: Adicionar repositório Docker ao sources.list"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
echo ""

echo "🔧 Comando: Atualizar lista de pacotes após adicionar repositório"
apt update
echo ""

echo "🔧 Comando: Instalar Docker"
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
echo ""

echo "🔧 Comando: Verificar instalação do Docker"
docker --version
echo ""

echo "🔧 Comando: Adicionar repositório do Node.js"
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
echo ""

echo "🔧 Comando: Instalar Node.js"
apt install -y nodejs
echo ""

echo "🔧 Comando: Verificar versão do Node.js"
node --version
npm --version
echo ""

echo "🔧 Comando: Adicionar repositório personalizado MINFIN"
cat > /etc/apt/sources.list.d/minfin.list << 'EOF'
# Repositório personalizado MINFIN
deb http://archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse
EOF
echo ""

echo "🔧 Comando: Adicionar chave GPG personalizada (exemplo)"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0x1234567890ABCDEF 2>/dev/null || echo "Chave não encontrada (exemplo)"
echo ""

echo "🔧 Comando: Verificar repositórios configurados"
apt-cache policy
echo ""

echo "🔧 Comando: Buscar pacotes relacionados a web"
apt search nginx
echo ""

echo "🔧 Comando: Buscar pacotes relacionados a banco de dados"
apt search mysql
echo ""

echo "🔧 Comando: Verificar informações de um pacote específico"
apt show nginx
echo ""

echo "🔧 Comando: Verificar dependências de um pacote"
apt-cache depends nginx
echo ""

echo "🔧 Comando: Verificar pacotes que dependem de nginx"
apt-cache rdepends nginx
echo ""

echo "🔧 Comando: Instalar pacote com versão específica"
apt install -y nginx=1.18.0-0ubuntu1.4
echo ""

echo "🔧 Comando: Verificar versão instalada"
nginx -v
echo ""

echo "🔧 Comando: Verificar arquivos de um pacote"
dpkg -L nginx | head -20
echo ""

echo "🔧 Comando: Verificar status de um pacote"
dpkg -s nginx
echo ""

echo "🔧 Comando: Verificar pacotes órfãos"
apt autoremove --dry-run
echo ""

echo "🔧 Comando: Limpar cache de pacotes"
apt clean
echo ""

echo "🔧 Comando: Verificar espaço usado pelo cache"
du -sh /var/cache/apt/archives/
echo ""

echo "🔧 Comando: Configurar atualizações automáticas"
apt install -y unattended-upgrades
echo ""

echo "🔧 Comando: Configurar atualizações automáticas"
cat > /etc/apt/apt.conf.d/50unattended-upgrades << 'EOF'
Unattended-Upgrade::Allowed-Origins {
    "${distro_id}:${distro_codename}-security";
    "${distro_id}ESMApps:${distro_codename}-apps-security";
    "${distro_id}ESM:${distro_codename}-infra-security";
};
Unattended-Upgrade::AutoFixInterruptedDpkg "true";
Unattended-Upgrade::MinimalSteps "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot "false";
EOF
echo ""

echo "🔧 Comando: Habilitar atualizações automáticas"
echo 'APT::Periodic::Update-Package-Lists "1";' > /etc/apt/apt.conf.d/20auto-upgrades
echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/20auto-upgrades
echo ""

echo "🔧 Comando: Verificar configuração de atualizações automáticas"
cat /etc/apt/apt.conf.d/20auto-upgrades
echo ""

echo "🔧 Comando: Criar script de atualização MINFIN"
cat > /usr/local/bin/update-minfin.sh << 'EOF'
#!/bin/bash
# Script de atualização MINFIN
echo "Iniciando atualização do sistema MINFIN..."
apt update
apt upgrade -y
apt autoremove -y
apt autoclean
echo "Atualização concluída em $(date)"
EOF
chmod +x /usr/local/bin/update-minfin.sh
echo ""

echo "🔧 Comando: Executar script de atualização"
/usr/local/bin/update-minfin.sh
echo ""

echo "🔧 Comando: Verificar logs de instalação"
tail -20 /var/log/apt/history.log
echo ""

echo "🔧 Comando: Verificar pacotes instalados recentemente"
grep "Install:" /var/log/apt/history.log | tail -10
echo ""

echo "✅ EXERCÍCIO CONCLUÍDO!"
echo "======================="
echo ""
echo "📋 RESUMO DO QUE FOI CONFIGURADO:"
echo "• Sistema atualizado com pacotes mais recentes"
echo "• Docker instalado e configurado"
echo "• Node.js instalado para desenvolvimento"
echo "• Repositórios personalizados adicionados"
echo "• Atualizações automáticas configuradas"
echo "• Script de atualização MINFIN criado"
echo ""
echo "🎯 PRÓXIMOS PASSOS:"
echo "• Configurar repositórios internos MINFIN"
echo "• Implementar assinatura de pacotes"
echo "• Configurar mirror local"
echo "• Monitorar atualizações de segurança"
echo ""
