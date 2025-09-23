#!/bin/bash

# =============================================================================
# EXERCÍCIO 8: LOGS DE SISTEMA E API
# Slide 19 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 8: LOGS DE SISTEMA E API"
echo "===================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1-7 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

# Navegar para diretório de logs
cd logs

# Adicionar logs de transações da API
echo "📝 Adicionando logs de transações da API:"
echo "2025-01-28 10:15:30 API_CALL transfer amount=200.00 from=12345-6 to=98765-4" > transacoes_api.log
echo "2025-01-28 10:16:45 API_CALL deposit amount=500.00 account=45678-9" >> transacoes_api.log
echo "2025-01-28 10:18:22 API_CALL withdrawal amount=100.00 account=12345-6" >> transacoes_api.log
echo "2025-01-28 10:25:15 API_CALL pix amount=150.00 from=98765-4 to=45678-9" >> transacoes_api.log
echo "✅ Logs de API adicionados!"
echo ""

# Adicionar logs de erros do sistema
echo "📝 Adicionando logs de erros do sistema:"
echo "2025-01-28 09:17:12 [ERROR] Database connection timeout - retrying..." > erro_sistema.log
echo "2025-01-28 11:30:45 [ERROR] Invalid transaction amount: -50.00" >> erro_sistema.log
echo "2025-01-28 14:22:18 [ERROR] User authentication failed for CPF 111.222.333-44" >> erro_sistema.log
echo "✅ Logs de erro adicionados!"
echo ""

# Voltar para diretório principal
cd ~/dimdim_bank

# Demonstrar comandos de busca
echo "🔍 DEMONSTRANDO COMANDOS DE BUSCA:"
echo ""

echo "📄 Buscando todos os arquivos .txt:"
find . -name "*.txt"
echo ""

echo "👤 Buscando arquivos relacionados ao João:"
find . -name "*joao*"
echo ""

echo "📁 Buscando apenas diretórios:"
find . -type d
echo ""

echo "📋 Conteúdo completo do diretório logs:"
ls -l logs/
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Adicionar logs de API e erros"
echo "• Usar 'find' para buscar arquivos"
echo "• Usar 'find' com diferentes critérios"
echo "• Entender estrutura de logs profissionais"
echo "• Organizar logs por tipo e função"
echo ""

echo "📊 LOGS ADICIONADOS:"
echo "• transacoes_api.log - Chamadas de API"
echo "• erro_sistema.log - Erros do sistema"
echo "• Demonstração de comandos find"
echo ""

echo "💡 COMANDOS FIND APRENDIDOS:"
echo "• 'find . -name \"*.txt\"' - Busca por extensão"
echo "• 'find . -name \"*joao*\"' - Busca por nome"
echo "• 'find . -type d' - Busca apenas diretórios"
echo "• 'find . -type f' - Busca apenas arquivos"
echo ""

echo "✅ Exercício 8 concluído! Logs de sistema e API criados."
echo "===================================="
