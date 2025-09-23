#!/bin/bash

# =============================================================================
# EXERCÍCIO 4: VISUALIZAÇÃO E OPERAÇÕES DE BACKUP
# Slide 14 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 4: VISUALIZAÇÃO E OPERAÇÕES DE BACKUP"
echo "================================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1, 2 e 3 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

# Navegar para transações e visualizar conteúdo
echo "📋 Visualizando transações de janeiro:"
cd transacoes
cat transacoes_janeiro_2025.txt
echo ""

# Visualizar dados de um cliente específico
echo "👤 Visualizando dados do cliente João Silva:"
cat ../clientes/cliente_001_joao_silva.txt
echo ""

# Operações de backup
echo "💾 Realizando operações de backup:"
echo "📁 Copiando arquivo de transações para backup..."
cp transacoes_janeiro_2025.txt ../backup/
echo "✅ Arquivo copiado para backup/"

echo "📁 Copiando arquivo de cliente com nome personalizado..."
cp ../clientes/cliente_001_joao_silva.txt ../backup/backup_cliente_001.txt
echo "✅ Arquivo copiado como backup_cliente_001.txt"
echo ""

# Verificar backup
echo "📋 Verificando arquivos no diretório backup:"
ls -l ../backup/
echo ""

# Navegar para relatórios e mover arquivo
echo "📊 Movendo arquivo para relatórios:"
cd ../relatorios
mv ../transacoes/transacoes_fevereiro_2025.txt relatorio_mensal_fevereiro.txt
echo "✅ Arquivo movido e renomeado para relatorio_mensal_fevereiro.txt"
echo ""

# Verificar estrutura final
echo "📋 Estrutura final dos diretórios:"
echo "📁 Transações:"
ls -l ../transacoes/
echo ""
echo "📁 Backup:"
ls -l ../backup/
echo ""
echo "📁 Relatórios:"
ls -l .
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar 'cat' para visualizar conteúdo de arquivos"
echo "• Usar 'cp' para copiar arquivos"
echo "• Usar 'mv' para mover e renomear arquivos"
echo "• Entender diferença entre cópia e movimentação"
echo "• Organizar arquivos em diretórios apropriados"
echo ""

echo "📊 OPERAÇÕES REALIZADAS:"
echo "• Visualização de conteúdo de arquivos"
echo "• Cópia de arquivos para backup"
echo "• Movimentação de arquivo para relatórios"
echo "• Renomeação de arquivo durante movimentação"
echo ""

echo "✅ Exercício 4 concluído! Operações de backup realizadas."
echo "================================================="
