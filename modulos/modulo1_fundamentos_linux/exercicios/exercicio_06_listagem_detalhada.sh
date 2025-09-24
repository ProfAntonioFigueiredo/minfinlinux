#!/bin/bash

# =============================================================================
# EXERCÍCIO 6: LISTAGEM DETALHADA E COMANDOS AVANÇADOS
# Slide 16 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 6: LISTAGEM DETALHADA E COMANDOS AVANÇADOS"
echo "======================================================"
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1-5 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

# Listagem detalhada de todos os arquivos
echo "📋 Listagem detalhada de todos os arquivos (incluindo ocultos):"
ls -la *
echo ""

# Listagem específica de cada diretório
echo "👥 Conteúdo do diretório CLIENTES:"
ls -l clientes
echo ""

echo "💳 Conteúdo do diretório TRANSAÇÕES:"
ls -l transacoes
echo ""

echo "📊 Conteúdo do diretório RELATÓRIOS:"
ls -l relatorios
echo ""

echo "💾 Conteúdo do diretório BACKUP:"
ls -l backup
echo ""

echo "📝 Conteúdo do diretório LOGS:"
ls -l logs
echo ""

# Mostrar estrutura completa com tree (se disponível)
echo "🌳 Estrutura completa do projeto:"
if command -v tree >/dev/null 2>&1; then
    tree
else
    echo "📁 Estrutura do projeto DimDim Bank:"
    find . -type d | sort
    echo ""
    echo "📄 Todos os arquivos:"
    find . -type f | sort
fi
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar 'ls -la *' para listagem detalhada"
echo "• Usar 'ls -l diretorio' para listagem específica"
echo "• Entender permissões e propriedades de arquivos"
echo "• Visualizar estrutura completa do projeto"
echo "• Diferenciar entre arquivos e diretórios"
echo ""

echo "📊 INFORMAÇÕES MOSTRADAS:"
echo "• Permissões de arquivos (rwx)"
echo "• Proprietário e grupo"
echo "• Tamanho dos arquivos"
echo "• Data de modificação"
echo "• Nomes de arquivos e diretórios"
echo ""

echo "💡 COMANDOS APRENDIDOS:"
echo "• 'ls -la *' - Lista tudo incluindo ocultos"
echo "• 'ls -l diretorio' - Lista conteúdo específico"
echo "• 'find . -type d' - Encontra diretórios"
echo "• 'find . -type f' - Encontra arquivos"
echo ""

echo "✅ Exercício 6 concluído! Listagem detalhada realizada."
echo "======================================================"
