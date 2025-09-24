#!/bin/bash

# =============================================================================
# EXERCÍCIO INTEGRADO - MÓDULO 1: FUNDAMENTOS LINUX
# Treinamento Linux - Ministério das Finanças de Angola
# Ubuntu 24.04 LTS (Noble Numbat) - Comandos otimizados
# =============================================================================

echo "🎯 EXERCÍCIO INTEGRADO - MÓDULO 1: FUNDAMENTOS LINUX"
echo "===================================================="
echo ""

# Verificar se está executando como usuário normal
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  ATENÇÃO: Este exercício deve ser executado como usuário normal!"
    echo "Execute: ./modulo1_exercicio_integrado.sh"
    exit 1
fi

echo "✅ Executando como usuário normal: $(whoami)"
echo "📍 Diretório atual: $(pwd)"
echo "🕐 Data/Hora: $(date)"
echo ""

# Criar diretório de trabalho
echo "📁 Criando diretório de trabalho para exercício integrado:"
mkdir -p ~/exercicio_integrado_modulo1
cd ~/exercicio_integrado_modulo1
echo "✅ Diretório criado: $(pwd)"
echo ""

# =============================================================================
# PARTE 1: EXPLORAÇÃO DO SISTEMA
# =============================================================================

echo "🔍 PARTE 1: EXPLORAÇÃO DO SISTEMA"
echo "================================="
echo ""

echo "📊 1.1 - Informações do Sistema:"
echo "Sistema: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"
echo "Arquitetura: $(uname -m)"
echo "Uptime: $(uptime -p)"
echo ""

echo "📊 1.2 - Estrutura de Diretórios:"
echo "Diretório atual: $(pwd)"
echo "Conteúdo do diretório raiz:"
ls -la / | head -10
echo ""

echo "📊 1.3 - Uso de Disco:"
df -h | head -5
echo ""

# =============================================================================
# PARTE 2: CRIAÇÃO DE ESTRUTURA DE PROJETO
# =============================================================================

echo "🏗️  PARTE 2: CRIAÇÃO DE ESTRUTURA DE PROJETO"
echo "============================================"
echo ""

echo "📁 2.1 - Criando estrutura para projeto do Ministério das Finanças:"
mkdir -p minfin_sistema/{documentos,scripts,logs,backups,config,relatorios}
mkdir -p minfin_sistema/documentos/{publicos,confidenciais,restritos}
mkdir -p minfin_sistema/relatorios/{mensais,trimestrais,anuais}
echo "✅ Estrutura de diretórios criada"
echo ""

echo "📁 2.2 - Verificando estrutura criada:"
tree minfin_sistema || find minfin_sistema -type d | sort
echo ""

# =============================================================================
# PARTE 3: MANIPULAÇÃO DE ARQUIVOS
# =============================================================================

echo "📝 PARTE 3: MANIPULAÇÃO DE ARQUIVOS"
echo "==================================="
echo ""

echo "📄 3.1 - Criando arquivos de configuração:"
cat > minfin_sistema/config/sistema.conf << 'EOF'
# Configuração do Sistema MINFIN Angola
# Data de criação: $(date)
# Versão: 1.0

[Geral]
NomeSistema=MINFIN Sistema de Gestão
Versao=1.0
Ambiente=Produção

[Seguranca]
NivelAcesso=Alto
Criptografia=Ativa
Backup=Diario

[Logs]
Nivel=INFO
Rotacao=Diaria
Retencao=30dias
EOF

echo "✅ Arquivo de configuração criado"
echo ""

echo "📄 3.2 - Criando script de backup:"
cat > minfin_sistema/scripts/backup.sh << 'EOF'
#!/bin/bash
# Script de Backup - MINFIN Angola
# Criado em: $(date)

echo "Iniciando backup do sistema MINFIN..."
echo "Data/Hora: $(date)"

# Criar diretório de backup com data
BACKUP_DIR="backups/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup dos documentos
echo "Fazendo backup dos documentos..."
cp -r documentos/ "$BACKUP_DIR/"

# Backup das configurações
echo "Fazendo backup das configurações..."
cp -r config/ "$BACKUP_DIR/"

# Backup dos logs
echo "Fazendo backup dos logs..."
cp -r logs/ "$BACKUP_DIR/"

echo "Backup concluído em: $BACKUP_DIR"
echo "Tamanho do backup: $(du -sh "$BACKUP_DIR" | cut -f1)"
EOF

chmod +x minfin_sistema/scripts/backup.sh
echo "✅ Script de backup criado e executável"
echo ""

echo "📄 3.3 - Criando relatório de exemplo:"
cat > minfin_sistema/relatorios/mensais/relatorio_janeiro_2025.txt << 'EOF'
RELATÓRIO MENSAL - JANEIRO 2025
Ministério das Finanças de Angola
================================

1. RESUMO EXECUTIVO
   - Receitas arrecadadas: 100% da meta
   - Despesas controladas: 95% do orçamento
   - Projetos em andamento: 15

2. PRINCIPAIS REALIZAÇÕES
   - Implementação do novo sistema de gestão
   - Treinamento de 60 funcionários em Linux
   - Modernização da infraestrutura de TI

3. DESAFIOS
   - Migração de sistemas legados
   - Capacitação de equipe técnica
   - Integração de novos processos

4. PRÓXIMOS PASSOS
   - Conclusão da migração
   - Treinamento avançado
   - Implementação de monitoramento

Data: $(date)
Responsável: Equipe de TI - MINFIN
EOF

echo "✅ Relatório criado"
echo ""

# =============================================================================
# PARTE 4: PERMISSÕES E SEGURANÇA
# =============================================================================

echo "🔐 PARTE 4: PERMISSÕES E SEGURANÇA"
echo "=================================="
echo ""

echo "🔒 4.1 - Configurando permissões de segurança:"
# Documentos públicos - todos podem ler
chmod 755 minfin_sistema/documentos/publicos
chmod 644 minfin_sistema/documentos/publicos/* 2>/dev/null || true

# Documentos confidenciais - apenas proprietário e grupo
chmod 750 minfin_sistema/documentos/confidenciais
chmod 640 minfin_sistema/documentos/confidenciais/* 2>/dev/null || true

# Documentos restritos - apenas proprietário
chmod 700 minfin_sistema/documentos/restritos
chmod 600 minfin_sistema/documentos/restritos/* 2>/dev/null || true

# Scripts - executáveis para proprietário e grupo
chmod 750 minfin_sistema/scripts/
chmod 750 minfin_sistema/scripts/*

# Configurações - apenas proprietário
chmod 700 minfin_sistema/config/
chmod 600 minfin_sistema/config/*

# Logs - proprietário e grupo podem ler
chmod 750 minfin_sistema/logs/
chmod 640 minfin_sistema/logs/* 2>/dev/null || true

echo "✅ Permissões de segurança configuradas"
echo ""

echo "🔒 4.2 - Verificando permissões configuradas:"
echo "Estrutura de permissões:"
ls -la minfin_sistema/
echo ""
echo "Permissões dos documentos:"
ls -la minfin_sistema/documentos/*/
echo ""

# =============================================================================
# PARTE 5: USUÁRIOS E GRUPOS
# =============================================================================

echo "👥 PARTE 5: USUÁRIOS E GRUPOS"
echo "============================="
echo ""

echo "👤 5.1 - Criando grupos de trabalho:"
sudo groupadd minfin_funcionarios 2>/dev/null || echo "Grupo minfin_funcionarios já existe"
sudo groupadd minfin_gerentes 2>/dev/null || echo "Grupo minfin_gerentes já existe"
sudo groupadd minfin_administradores 2>/dev/null || echo "Grupo minfin_administradores já existe"

echo "✅ Grupos criados"
echo ""

echo "👤 5.2 - Criando usuários de teste:"
sudo useradd -m -s /bin/bash -g minfin_funcionarios minfin_func1 2>/dev/null || echo "Usuário minfin_func1 já existe"
sudo useradd -m -s /bin/bash -g minfin_gerentes minfin_gerente1 2>/dev/null || echo "Usuário minfin_gerente1 já existe"
sudo useradd -m -s /bin/bash -g minfin_administradores minfin_admin1 2>/dev/null || echo "Usuário minfin_admin1 já existe"

# Definir senhas
echo "minfin_func1:123456" | sudo chpasswd 2>/dev/null
echo "minfin_gerente1:123456" | sudo chpasswd 2>/dev/null
echo "minfin_admin1:123456" | sudo chpasswd 2>/dev/null

echo "✅ Usuários de teste criados"
echo ""

echo "👤 5.3 - Verificando usuários e grupos:"
echo "Grupos criados:"
getent group minfin_* 2>/dev/null || echo "Nenhum grupo minfin encontrado"
echo ""
echo "Usuários criados:"
getent passwd minfin_* 2>/dev/null || echo "Nenhum usuário minfin encontrado"
echo ""

# =============================================================================
# PARTE 6: PROCESSOS E SERVIÇOS
# =============================================================================

echo "⚙️  PARTE 6: PROCESSOS E SERVIÇOS"
echo "================================="
echo ""

echo "🔧 6.1 - Informações do sistema:"
echo "Uptime: $(uptime)"
echo "Usuários logados:"
w | head -5
echo ""

echo "🔧 6.2 - Processos em execução:"
echo "Top 5 processos por uso de CPU:"
ps aux --sort=-%cpu | head -6
echo ""

echo "🔧 6.3 - Serviços do sistema:"
echo "Serviços ativos:"
systemctl list-units --type=service --state=active | head -10
echo ""

echo "🔧 6.4 - Criando serviço de monitoramento:"
cat > minfin_sistema/scripts/monitor.sh << 'EOF'
#!/bin/bash
# Script de Monitoramento - MINFIN Angola

echo "=== MONITORAMENTO DO SISTEMA MINFIN ==="
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
sudo tail -5 /var/log/syslog 2>/dev/null || echo "Não foi possível acessar logs do sistema"
EOF

chmod +x minfin_sistema/scripts/monitor.sh
echo "✅ Script de monitoramento criado"
echo ""

# =============================================================================
# PARTE 7: TESTE E VALIDAÇÃO
# =============================================================================

echo "🧪 PARTE 7: TESTE E VALIDAÇÃO"
echo "============================="
echo ""

echo "✅ 7.1 - Executando script de backup:"
cd minfin_sistema
./scripts/backup.sh
echo ""

echo "✅ 7.2 - Executando script de monitoramento:"
./scripts/monitor.sh
echo ""

echo "✅ 7.3 - Verificando estrutura final:"
echo "Estrutura completa do projeto:"
tree . || find . -type f | sort
echo ""

echo "✅ 7.4 - Verificando permissões finais:"
echo "Permissões dos scripts:"
ls -la scripts/
echo ""
echo "Permissões dos documentos:"
ls -la documentos/*/
echo ""

# =============================================================================
# PARTE 8: RELATÓRIO FINAL
# =============================================================================

echo "📊 PARTE 8: RELATÓRIO FINAL"
echo "==========================="
echo ""

echo "🎯 RESUMO DO EXERCÍCIO INTEGRADO:"
echo "================================="
echo "✅ Estrutura de diretórios criada"
echo "✅ Arquivos de configuração criados"
echo "✅ Scripts funcionais desenvolvidos"
echo "✅ Permissões de segurança configuradas"
echo "✅ Usuários e grupos criados"
echo "✅ Sistema de monitoramento implementado"
echo "✅ Backup automático configurado"
echo ""

echo "📁 ESTRUTURA CRIADA:"
echo "==================="
echo "minfin_sistema/"
echo "├── documentos/"
echo "│   ├── publicos/"
echo "│   ├── confidenciais/"
echo "│   └── restritos/"
echo "├── scripts/"
echo "│   ├── backup.sh"
echo "│   └── monitor.sh"
echo "├── logs/"
echo "├── backups/"
echo "├── config/"
echo "│   └── sistema.conf"
echo "└── relatorios/"
echo "    ├── mensais/"
echo "    ├── trimestrais/"
echo "    └── anuais/"
echo ""

echo "🔐 PERMISSÕES CONFIGURADAS:"
echo "=========================="
echo "• Documentos públicos: 755/644 (todos podem ler)"
echo "• Documentos confidenciais: 750/640 (proprietário e grupo)"
echo "• Documentos restritos: 700/600 (apenas proprietário)"
echo "• Scripts: 750 (proprietário e grupo executam)"
echo "• Configurações: 700/600 (apenas proprietário)"
echo "• Logs: 750/640 (proprietário e grupo leem)"
echo ""

echo "👥 USUÁRIOS E GRUPOS CRIADOS:"
echo "============================"
echo "• Grupos: minfin_funcionarios, minfin_gerentes, minfin_administradores"
echo "• Usuários: minfin_func1, minfin_gerente1, minfin_admin1"
echo "• Senha padrão: 123456"
echo ""

echo "📈 ESTATÍSTICAS:"
echo "==============="
echo "• Arquivos criados: $(find . -type f | wc -l)"
echo "• Diretórios criados: $(find . -type d | wc -l)"
echo "• Tamanho total: $(du -sh . | cut -f1)"
echo "• Scripts executáveis: $(find . -name "*.sh" -executable | wc -l)"
echo ""

echo "🎉 EXERCÍCIO INTEGRADO CONCLUÍDO COM SUCESSO!"
echo "============================================="
echo ""
echo "📚 PRÓXIMOS PASSOS:"
echo "• Explore a estrutura criada"
echo "• Teste os scripts desenvolvidos"
echo "• Experimente com diferentes permissões"
echo "• Continue com os próximos módulos"
echo ""
echo "✅ Sistema MINFIN simulado criado e funcional!"
