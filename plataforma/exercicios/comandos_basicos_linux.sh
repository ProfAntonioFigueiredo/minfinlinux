#!/bin/bash

# =====================================================
# EXERCÍCIO: COMANDOS BÁSICOS DO LINUX
# Módulo 1: Fundamentos Linux
# Ministério das Finanças de Angola - 2025
# =====================================================

echo "====================================================="
echo "🏦 EXERCÍCIO: COMANDOS BÁSICOS DO LINUX"
echo "📚 Módulo 1: Fundamentos Linux"
echo "🏛️  Ministério das Finanças de Angola - 2025"
echo "====================================================="
echo ""

# Verificar se estamos no diretório home
echo "📍 Verificando localização atual..."
pwd
echo ""

# Criar estrutura do projeto DimDim Bank
echo "🏗️  Criando estrutura do projeto DimDim Bank..."
mkdir dimdim_bank
cd dimdim_bank
echo "✅ Diretório dimdim_bank criado"
echo ""

# Criar subdiretórios
echo "📁 Criando subdiretórios..."
mkdir clientes transacoes relatorios backup logs
echo "✅ Subdiretórios criados: clientes, transacoes, relatorios, backup, logs"
echo ""

# Listar estrutura criada
echo "📋 Listando estrutura criada..."
ls -l
echo ""

# Navegar para diretório de clientes
echo "👥 Trabalhando com clientes..."
cd clientes

# Criar arquivos de clientes
echo "📝 Criando arquivos de clientes..."
touch cliente_001_joao_silva.txt cliente_002_maria_santos.txt cliente_003_pedro_oliveira.txt
echo "✅ Arquivos de clientes criados"
echo ""

# Navegar para diretório de transações
echo "💳 Trabalhando com transações..."
cd ../transacoes

# Criar arquivos de transações
echo "📊 Criando arquivos de transações..."
touch transacoes_janeiro_2025.txt transacoes_fevereiro_2025.txt
echo "✅ Arquivos de transações criados"
echo ""

# Adicionar dados dos clientes
echo "👤 Adicionando dados dos clientes..."
echo "João Silva - CPF: 123.456.789-00 - Conta: 12345-6 - Saldo: R$ 1.500,00" > ../clientes/cliente_001_joao_silva.txt 
echo "Maria Santos - CPF: 987.654.321-00 - Conta: 98765-4 - Saldo: R$ 2.800,00" > ../clientes/cliente_002_maria_santos.txt 
echo "Pedro Oliveira - CPF: 456.789.123-00 - Conta: 45678-9 - Saldo: R$ 950,00" > ../clientes/cliente_003_pedro_oliveira.txt
echo "✅ Dados dos clientes adicionados"
echo ""

# Adicionar dados das transações
echo "💰 Adicionando dados das transações..."
echo "01/01/2025 - Transferência - João Silva -> Maria Santos - R$ 200,00" > transacoes_janeiro_2025.txt 
echo "02/01/2025 - Depósito - Pedro Oliveira - R$ 500,00" >> transacoes_janeiro_2025.txt 
echo "03/01/2025 - Saque - João Silva - R$ 100,00" >> transacoes_janeiro_2025.txt 
echo "15/02/2025 - PIX - Maria Santos -> Pedro Oliveira - R$ 150,00" > transacoes_fevereiro_2025.txt
echo "✅ Dados das transações adicionados"
echo ""

# Visualizar conteúdo dos arquivos
echo "👀 Visualizando conteúdo dos arquivos..."
echo "📄 Comando: Conteúdo das transações de janeiro"
echo "📄 Conteúdo das transações de janeiro:"
cat transacoes_janeiro_2025.txt
echo ""

echo "👤 Comando: Dados do cliente João Silva"
echo "👤 Dados do cliente João Silva:"
cat ../clientes/cliente_001_joao_silva.txt
echo ""

# Fazer backup dos arquivos
echo "💾 Fazendo backup dos arquivos..."
cp transacoes_janeiro_2025.txt ../backup/
cp ../clientes/cliente_001_joao_silva.txt ../backup/backup_cliente_001.txt
echo "✅ Backups criados"
echo ""

# Mover arquivo para relatórios
echo "📊 Movendo arquivo para relatórios..."
cd ../relatorios
mv ../transacoes/transacoes_fevereiro_2025.txt relatorio_mensal_fevereiro.txt
echo "✅ Arquivo movido para relatórios"
echo ""

# Adicionar mais transações
echo "➕ Adicionando mais transações..."
cd ../transacoes 
echo "05/01/2025 - Pagamento de Conta - João Silva - R$ 80,00" >> transacoes_janeiro_2025.txt 
echo "08/01/2025 - Transferência - Pedro Oliveira -> João Silva - R$ 300,00" >> transacoes_janeiro_2025.txt 
echo "12/01/2025 - Depósito - Maria Santos - R$ 1.200,00" >> transacoes_janeiro_2025.txt 
echo "18/01/2025 - Saque - Pedro Oliveira - R$ 200,00" >> transacoes_janeiro_2025.txt 
echo "22/01/2025 - PIX - João Silva -> Maria Santos - R$ 450,00" >> transacoes_janeiro_2025.txt 
echo "25/01/2025 - Pagamento de Boleto - Maria Santos - R$ 320,00" >> transacoes_janeiro_2025.txt 
echo "28/01/2025 - Transferência - Maria Santos -> Pedro Oliveira - R$ 180,00" >> transacoes_janeiro_2025.txt
echo "✅ Transações adicionais criadas"
echo ""

# Visualizar últimas transações
echo "📈 Visualizando últimas 10 transações..."
tail -10 transacoes_janeiro_2025.txt
echo ""

# Remover arquivo de backup
echo "🗑️  Removendo arquivo de backup..."
cd ../backup 
rm backup_cliente_001.txt
echo "✅ Arquivo de backup removido"
echo ""

# Listar estrutura completa
echo "📋 Listando estrutura completa do projeto..."
cd ~/dimdim_bank
ls -la *
echo ""

# Listar cada diretório separadamente
echo "📁 Comando: Conteúdo de cada diretório"
echo "📁 Conteúdo de cada diretório:"
echo "👥 Clientes:"
ls -l clientes
echo ""

echo "💳 Transações:"
ls -l transacoes
echo ""

echo "📊 Comando: Relatórios"
echo "📊 Relatórios:"
ls -l relatorios
echo ""

echo "💾 Comando: Backup"
echo "💾 Backup:"
ls -l backup
echo ""

echo "📝 Logs:"
ls -l logs
echo ""

# Trabalhar com logs
echo "📝 Trabalhando com logs..."
cd logs 

# Criar arquivos de log
echo "📄 Criando arquivos de log..."
touch sistema_dimdim.log acesso_usuarios.log transacoes_api.log erro_sistema.log
echo "✅ Arquivos de log criados"
echo ""

# Adicionar logs do sistema
echo "🔧 Adicionando logs do sistema..."
echo "2025-01-28 09:15:32 [INFO] Sistema DimDim iniciado com sucesso" > sistema_dimdim.log 
echo "2025-01-28 09:16:45 [INFO] Módulo de transações carregado" >> sistema_dimdim.log 
echo "2025-01-28 09:17:12 [ERROR] Falha na conexão com banco de dados" >> sistema_dimdim.log 
echo "2025-01-28 09:18:00 [INFO] Reconexão com banco estabelecida" >> sistema_dimdim.log 
echo "2025-01-28 09:20:15 [WARN] Alto volume de transações detectado" >> sistema_dimdim.log
echo "✅ Logs do sistema adicionados"
echo ""

# Adicionar logs de acesso
echo "👤 Adicionando logs de acesso..."
echo "2025-01-28 08:30:15 LOGIN joao.silva 192.168.1.100 SUCCESS" > acesso_usuarios.log 
echo "2025-01-28 08:45:22 LOGIN maria.santos 192.168.1.101 SUCCESS" >> acesso_usuarios.log 
echo "2025-01-28 09:12:33 LOGIN pedro.oliveira 192.168.1.102 FAILED" >> acesso_usuarios.log 
echo "2025-01-28 09:13:01 LOGIN pedro.oliveira 192.168.1.102 SUCCESS" >> acesso_usuarios.log 
echo "2025-01-28 09:45:18 LOGOUT joao.silva 192.168.1.100" >> acesso_usuarios.log
echo "✅ Logs de acesso adicionados"
echo ""

# Adicionar logs de API
echo "🔌 Adicionando logs de API..."
echo "2025-01-28 10:15:30 API_CALL transfer amount=200.00 from=12345-6 to=98765-4" > transacoes_api.log 
echo "2025-01-28 10:16:45 API_CALL deposit amount=500.00 account=45678-9" >> transacoes_api.log 
echo "2025-01-28 10:18:22 API_CALL withdrawal amount=100.00 account=12345-6" >> transacoes_api.log 
echo "2025-01-28 10:25:15 API_CALL pix amount=150.00 from=98765-4 to=45678-9" >> transacoes_api.log
echo "✅ Logs de API adicionados"
echo ""

# Adicionar logs de erro
echo "❌ Adicionando logs de erro..."
echo "2025-01-28 09:17:12 [ERROR] Database connection timeout - retrying..." > erro_sistema.log 
echo "2025-01-28 11:30:45 [ERROR] Invalid transaction amount: -50.00" >> erro_sistema.log 
echo "2025-01-28 14:22:18 [ERROR] User authentication failed for CPF 111.222.333-44" >> erro_sistema.log
echo "✅ Logs de erro adicionados"
echo ""

# Voltar para diretório principal
cd ~/dimdim_bank

# Buscar arquivos
echo "🔍 Buscando arquivos..."
echo "📄 Comando: Buscando todos os arquivos .txt"
echo "📄 Buscando todos os arquivos .txt:"
find . -name "*.txt"
echo ""

echo "👤 Comando: Buscando arquivos de clientes específicos"
echo "👤 Buscando arquivos de clientes específicos:"
find . -name "*joao*"
echo ""

echo "📁 Comando: Buscando apenas diretórios"
echo "📁 Buscando apenas diretórios:"
find . -type d
echo ""

# Buscar conteúdo nos arquivos
echo "🔍 Buscando conteúdo nos arquivos..."
echo "👤 Comando: Buscando transações de João Silva"
echo "👤 Buscando transações de João Silva:"
grep -r "João Silva" .
echo ""

echo "❌ Comando: Buscando erros nos logs"
echo "❌ Buscando erros nos logs:"
grep "ERROR" logs/*.log
echo ""

echo "✅ Comando: Buscando logins bem-sucedidos"
echo "✅ Buscando logins bem-sucedidos:"
grep "SUCCESS" logs/acesso_usuarios.log
echo ""

echo "💰 Comando: Buscando transações acima de R$ 200"
echo "💰 Buscando transações acima de R$ 200:"
grep -E "(200|[3-9][0-9]{2}|[0-9]{4})" transacoes/transacoes_janeiro_2025.txt
echo ""

echo "📊 Comando: Contando quantas vezes uma palavra aparece"
echo "📊 Contando quantas vezes uma palavra aparece:"
grep -c "Transferência" transacoes/transacoes_janeiro_2025.txt
echo ""

# Verificar uso do disco
echo "💾 Verificando uso do disco..."
echo "📊 Comando: Uso geral do disco"
echo "📊 Uso geral do disco:"
df -h
echo ""

echo "📁 Comando: Uso específico do diretório atual"
echo "📁 Uso específico do diretório atual:"
df -h .
echo ""

echo "💻 Comando: Apenas sistemas de arquivos locais"
echo "💻 Apenas sistemas de arquivos locais:"
df -hT
echo ""

# Trabalhar com processos
echo "⚙️  Trabalhando com processos..."
echo "📋 Comando: Listando seus processos"
echo "📋 Listando seus processos:"
ps
echo ""

echo "📊 Comando: Listando todos os processos detalhadamente"
echo "📊 Listando todos os processos detalhadamente:"
ps -aux
echo ""

echo "🔍 Comando: Buscando processos específicos"
echo "🔍 Buscando processos específicos:"
ps -aux | grep bash
echo ""

echo "📈 Comando: Monitor de processos (pressione 'q' para sair)"
echo "📈 Monitor de processos (pressione 'q' para sair):"
echo "💡 Dica: Use 'q' para sair do comando top"
top
echo ""

# Limpeza final
echo "🧹 Limpeza final..."
cd ~
rm -rf dimdim_bank  
echo "✅ Projeto DimDim Bank removido"
echo ""

echo "====================================================="
echo "🎉 EXERCÍCIO CONCLUÍDO COM SUCESSO!"
echo "📚 Comandos básicos do Linux praticados:"
echo "   • Navegação (pwd, cd, ls)"
echo "   • Criação (mkdir, touch)"
echo "   • Manipulação (cp, mv, rm)"
echo "   • Visualização (cat, tail, head)"
echo "   • Busca (find, grep)"
echo "   • Monitoramento (ps, top, df)"
echo "   • Gerenciamento de arquivos e diretórios"
echo "====================================================="
