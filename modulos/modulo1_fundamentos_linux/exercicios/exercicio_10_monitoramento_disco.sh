#!/bin/bash

# =============================================================================
# EXERCÍCIO 10: MONITORAMENTO DE DISCO
# Slide 21 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 10: MONITORAMENTO DE DISCO"
echo "======================================"
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1-9 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

echo "💾 DEMONSTRANDO COMANDOS DE MONITORAMENTO DE DISCO:"
echo ""

# Verificar uso geral do disco
echo "📊 Verificando uso geral do disco:"
df -h
echo ""

# Verificar uso específico do diretório atual
echo "📁 Verificando uso específico do diretório atual:"
df -h .
echo ""

# Mostrar apenas sistemas de arquivos locais
echo "🖥️  Mostrando apenas sistemas de arquivos locais:"
df -hT
echo ""

# Verificar espaço usado pelo projeto DimDim Bank
echo "🏦 Verificando espaço usado pelo projeto DimDim Bank:"
du -sh .
echo ""

# Verificar espaço usado por cada diretório
echo "📁 Verificando espaço usado por cada diretório:"
du -sh */
echo ""

# Verificar os maiores arquivos
echo "📄 Verificando os maiores arquivos:"
find . -type f -exec du -h {} + | sort -rh | head -10
echo ""

# Verificar espaço livre em diferentes formatos
echo "💿 Verificando espaço livre (formato legível):"
df -h | grep -E "(Filesystem|/dev/)"
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar 'df' para verificar uso de disco"
echo "• Usar 'df -h' para formato legível"
echo "• Usar 'df -hT' para mostrar tipos de sistema"
echo "• Usar 'du' para verificar uso de diretórios"
echo "• Monitorar espaço disponível"
echo "• Identificar arquivos grandes"
echo ""

echo "📊 INFORMAÇÕES MOSTRADAS:"
echo "• Uso geral de todos os sistemas de arquivos"
echo "• Uso específico do diretório atual"
echo "• Tipos de sistemas de arquivos"
echo "• Espaço usado pelo projeto"
echo "• Espaço usado por cada diretório"
echo "• Maiores arquivos do projeto"
echo ""

echo "💡 COMANDOS APRENDIDOS:"
echo "• 'df -h' - Uso de disco em formato legível"
echo "• 'df -h .' - Uso do diretório atual"
echo "• 'df -hT' - Uso com tipos de sistema"
echo "• 'du -sh .' - Tamanho do diretório atual"
echo "• 'du -sh */' - Tamanho de subdiretórios"
echo "• 'find . -type f -exec du -h {} +' - Maiores arquivos"
echo ""

echo "⚠️  IMPORTANTE:"
echo "• Monitore regularmente o uso de disco"
echo "• Limpe arquivos desnecessários"
echo "• Use 'du' para identificar diretórios grandes"
echo "• Use 'df' para verificar espaço disponível"
echo ""

echo "✅ Exercício 10 concluído! Monitoramento de disco realizado."
echo "======================================"
