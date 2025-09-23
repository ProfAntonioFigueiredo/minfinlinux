#!/bin/bash

# =============================================================================
# EXERCÍCIO 2: ESTRUTURA DE DIRETÓRIOS DO DIMDIM BANK
# Slide 12 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 2: ESTRUTURA DE DIRETÓRIOS DO DIMDIM BANK"
echo "====================================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Criando diretório dimdim_bank..."
    mkdir dimdim_bank
    cd dimdim_bank
else
    echo "📍 Navegando para o diretório dimdim_bank..."
    cd dimdim_bank
fi

echo "📍 Diretório atual: $(pwd)"
echo ""

# Listar conteúdo atual (deve estar vazio)
echo "📋 Conteúdo atual do diretório:"
ls -l
echo ""

# Criar estrutura de diretórios do banco
echo "🏗️  Criando estrutura organizacional do DimDim Bank:"
mkdir clientes transacoes relatorios backup logs
echo "✅ Diretórios criados: clientes, transacoes, relatorios, backup, logs"
echo ""

# Verificar estrutura criada
echo "📋 Estrutura criada:"
ls -l
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar 'ls -l' para listagem detalhada"
echo "• Criar múltiplos diretórios com um comando"
echo "• Organizar estrutura de projeto de forma lógica"
echo "• Verificar criação de diretórios"
echo ""

echo "📁 ESTRUTURA CRIADA:"
echo "• clientes/    - Arquivos de dados dos clientes"
echo "• transacoes/  - Registros de transações bancárias"
echo "• relatorios/  - Relatórios gerenciais"
echo "• backup/      - Cópias de segurança"
echo "• logs/        - Arquivos de log do sistema"
echo ""

echo "✅ Exercício 2 concluído! Estrutura organizacional criada."
echo "====================================================="
