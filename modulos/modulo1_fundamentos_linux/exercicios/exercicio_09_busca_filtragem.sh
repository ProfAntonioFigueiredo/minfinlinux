#!/bin/bash

# =============================================================================
# EXERCÍCIO 9: BUSCA E FILTRAGEM COM GREP
# Slide 20 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 9: BUSCA E FILTRAGEM COM GREP"
echo "========================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1-8 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

echo "🔍 DEMONSTRANDO COMANDOS DE BUSCA E FILTRAGEM:"
echo ""

# Buscar transações de João Silva
echo "👤 Buscando transações de João Silva:"
grep -r "João Silva" .
echo ""

# Buscar erros nos logs
echo "❌ Buscando erros nos logs:"
grep "ERROR" logs/*.log
echo ""

# Buscar logins bem-sucedidos
echo "✅ Buscando logins bem-sucedidos:"
grep "SUCCESS" logs/acesso_usuarios.log
echo ""

# Buscar transações acima de R$ 200
echo "💰 Buscando transações acima de R$ 200:"
grep -E "(200|[3-9][0-9]{2}|[0-9]{4})" transacoes/transacoes_janeiro_2025.txt
echo ""

# Contar quantas vezes uma palavra aparece
echo "📊 Contando ocorrências de 'Transferência':"
grep -c "Transferência" transacoes/transacoes_janeiro_2025.txt
echo ""

# Buscar por padrões específicos
echo "🔍 Buscando por padrões de data:"
grep -E "[0-9]{2}/[0-9]{2}/[0-9]{4}" transacoes/transacoes_janeiro_2025.txt
echo ""

# Buscar por tipos de transação
echo "💳 Buscando por tipos de transação:"
grep -E "(Transferência|Depósito|Saque|PIX)" transacoes/transacoes_janeiro_2025.txt
echo ""

# Buscar por IPs nos logs
echo "🌐 Buscando por endereços IP:"
grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" logs/acesso_usuarios.log
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar 'grep' para buscar conteúdo em arquivos"
echo "• Usar 'grep -r' para busca recursiva"
echo "• Usar 'grep -c' para contar ocorrências"
echo "• Usar expressões regulares com 'grep -E'"
echo "• Filtrar dados específicos de logs"
echo ""

echo "📊 BUSCAS REALIZADAS:"
echo "• Busca por nome de cliente"
echo "• Busca por níveis de log (ERROR)"
echo "• Busca por status de login (SUCCESS)"
echo "• Busca por valores monetários"
echo "• Contagem de ocorrências"
echo "• Busca por padrões de data"
echo "• Busca por tipos de transação"
echo "• Busca por endereços IP"
echo ""

echo "💡 COMANDOS GREP APRENDIDOS:"
echo "• 'grep texto arquivo' - Busca simples"
echo "• 'grep -r texto .' - Busca recursiva"
echo "• 'grep -c texto arquivo' - Conta ocorrências"
echo "• 'grep -E \"padrão\" arquivo' - Expressões regulares"
echo "• 'grep \"texto\" *.log' - Busca em múltiplos arquivos"
echo ""

echo "✅ Exercício 9 concluído! Busca e filtragem realizada."
echo "========================================="
