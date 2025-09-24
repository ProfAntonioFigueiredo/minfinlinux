#!/bin/bash

# =============================================================================
# EXERCÍCIO 3: CRIAÇÃO DE ARQUIVOS E DADOS DO DIMDIM BANK
# Slide 13 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 3: CRIAÇÃO DE ARQUIVOS E DADOS DO DIMDIM BANK"
echo "========================================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Criando estrutura completa..."
    mkdir -p dimdim_bank/{clientes,transacoes,relatorios,backup,logs}
    cd dimdim_bank
else
    echo "📍 Navegando para o diretório dimdim_bank..."
    cd dimdim_bank
fi

echo "📍 Diretório atual: $(pwd)"
echo ""

# Navegar para diretório de clientes e criar arquivos
echo "👥 Criando arquivos de clientes:"
cd clientes
touch cliente_001_joao_silva.txt cliente_002_maria_santos.txt cliente_003_pedro_oliveira.txt
echo "✅ Arquivos de clientes criados:"
ls -l *.txt
echo ""

# Navegar para diretório de transações e criar arquivos
echo "💳 Criando arquivos de transações:"
cd ../transacoes
touch transacoes_janeiro_2025.txt transacoes_fevereiro_2025.txt
echo "✅ Arquivos de transações criados:"
ls -l *.txt
echo ""

# Adicionar dados dos clientes
echo "📝 Adicionando dados dos clientes:"
echo "João Silva - CPF: 123.456.789-00 - Conta: 12345-6 - Saldo: R$ 1.500,00" > ../clientes/cliente_001_joao_silva.txt
echo "Maria Santos - CPF: 987.654.321-00 - Conta: 98765-4 - Saldo: R$ 2.800,00" > ../clientes/cliente_002_maria_santos.txt
echo "Pedro Oliveira - CPF: 456.789.123-00 - Conta: 45678-9 - Saldo: R$ 950,00" > ../clientes/cliente_003_pedro_oliveira.txt
echo "✅ Dados dos clientes adicionados!"
echo ""

# Adicionar transações de janeiro
echo "📝 Adicionando transações de janeiro 2025:"
echo "01/01/2025 - Transferência - João Silva -> Maria Santos - R$ 200,00" > transacoes_janeiro_2025.txt
echo "02/01/2025 - Depósito - Pedro Oliveira - R$ 500,00" >> transacoes_janeiro_2025.txt
echo "03/01/2025 - Saque - João Silva - R$ 100,00" >> transacoes_janeiro_2025.txt
echo "✅ Transações de janeiro adicionadas!"
echo ""

# Adicionar transações de fevereiro
echo "📝 Adicionando transações de fevereiro 2025:"
echo "15/02/2025 - PIX - Maria Santos -> Pedro Oliveira - R$ 150,00" > transacoes_fevereiro_2025.txt
echo "✅ Transações de fevereiro adicionadas!"
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar 'touch' para criar arquivos vazios"
echo "• Usar 'echo' com '>' para criar conteúdo"
echo "• Usar 'echo' com '>>' para adicionar conteúdo"
echo "• Navegar entre diretórios com 'cd'"
echo "• Criar estrutura de dados realista"
echo ""

echo "📊 DADOS CRIADOS:"
echo "• 3 clientes com informações completas"
echo "• 4 transações de janeiro 2025"
echo "• 1 transação de fevereiro 2025"
echo "• Estrutura organizada por diretórios"
echo ""

echo "✅ Exercício 3 concluído! Dados do banco criados."
echo "========================================================="
