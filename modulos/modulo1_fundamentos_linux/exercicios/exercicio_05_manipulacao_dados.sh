#!/bin/bash

# =============================================================================
# EXERCÍCIO 5: MANIPULAÇÃO DE DADOS E OPERAÇÕES DE ARQUIVO
# Slide 15 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 5: MANIPULAÇÃO DE DADOS E OPERAÇÕES DE ARQUIVO"
echo "=========================================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1-4 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

# Navegar para transações e adicionar mais dados
echo "📝 Adicionando mais transações de janeiro:"
cd transacoes

# Adicionar transações adicionais usando append (>>)
echo "05/01/2025 - Pagamento de Conta - João Silva - R$ 80,00" >> transacoes_janeiro_2025.txt
echo "08/01/2025 - Transferência - Pedro Oliveira -> João Silva - R$ 300,00" >> transacoes_janeiro_2025.txt
echo "12/01/2025 - Depósito - Maria Santos - R$ 1.200,00" >> transacoes_janeiro_2025.txt
echo "18/01/2025 - Saque - Pedro Oliveira - R$ 200,00" >> transacoes_janeiro_2025.txt
echo "22/01/2025 - PIX - João Silva -> Maria Santos - R$ 450,00" >> transacoes_janeiro_2025.txt
echo "25/01/2025 - Pagamento de Boleto - Maria Santos - R$ 320,00" >> transacoes_janeiro_2025.txt
echo "28/01/2025 - Transferência - Maria Santos -> Pedro Oliveira - R$ 180,00" >> transacoes_janeiro_2025.txt

echo "✅ 7 transações adicionais inseridas!"
echo ""

# Mostrar as últimas 10 linhas do arquivo
echo "📋 Últimas 10 transações de janeiro:"
tail -10 transacoes_janeiro_2025.txt
echo ""

# Navegar para backup e remover arquivo
echo "🗑️  Removendo arquivo de backup desnecessário:"
cd ../backup
echo "📋 Arquivos no backup antes da remoção:"
ls -l
echo ""

echo "🗑️  Removendo backup_cliente_001.txt..."
rm backup_cliente_001.txt
echo "✅ Arquivo removido!"

echo "📋 Arquivos no backup após remoção:"
ls -l
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar '>>' para adicionar conteúdo a arquivos existentes"
echo "• Usar 'tail' para visualizar últimas linhas de arquivo"
echo "• Usar 'rm' para remover arquivos"
echo "• Entender diferença entre '>' e '>>'"
echo "• Gerenciar arquivos de backup"
echo ""

echo "📊 OPERAÇÕES REALIZADAS:"
echo "• Adição de 7 novas transações"
echo "• Visualização das últimas 10 transações"
echo "• Remoção de arquivo de backup desnecessário"
echo "• Demonstração de comandos de manipulação"
echo ""

echo "💡 DICAS IMPORTANTES:"
echo "• '>' sobrescreve o arquivo"
echo "• '>>' adiciona ao final do arquivo"
echo "• 'tail -n' mostra as últimas n linhas"
echo "• 'rm' remove arquivos permanentemente"
echo ""

echo "✅ Exercício 5 concluído! Manipulação de dados realizada."
echo "=========================================================="
