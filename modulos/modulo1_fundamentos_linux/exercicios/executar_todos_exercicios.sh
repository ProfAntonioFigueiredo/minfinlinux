#!/bin/bash

# =============================================================================
# SCRIPT MESTRE: EXECUTAR TODOS OS EXERCÍCIOS DO PROJETO DIMDIM BANK
# Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 PROJETO DIMDIM BANK - EXECUÇÃO COMPLETA"
echo "=========================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -f "README_EXERCICIOS.md" ]; then
    echo "⚠️  Execute este script no diretório de exercícios!"
    echo "Certifique-se de estar em: /caminho/para/exercicios/"
    exit 1
fi

echo "📋 Este script executará todos os 12 exercícios do projeto DimDim Bank"
echo "em sequência, criando um ambiente completo de aprendizado Linux."
echo ""

# Confirmar execução
read -p "Deseja continuar com a execução completa? (s/N): " confirmacao

if [[ ! $confirmacao =~ ^[Ss]$ ]]; then
    echo "❌ Execução cancelada pelo usuário."
    exit 0
fi

echo ""
echo "🚀 INICIANDO EXECUÇÃO DOS EXERCÍCIOS..."
echo "======================================"
echo ""

# Array com todos os exercícios
exercicios=(
    "exercicio_01_configuracao_inicial.sh"
    "exercicio_02_estrutura_diretorios.sh"
    "exercicio_03_criacao_arquivos_dados.sh"
    "exercicio_04_visualizacao_backup.sh"
    "exercicio_05_manipulacao_dados.sh"
    "exercicio_06_listagem_detalhada.sh"
    "exercicio_07_gerenciamento_logs.sh"
    "exercicio_08_logs_sistema_api.sh"
    "exercicio_09_busca_filtragem.sh"
    "exercicio_10_monitoramento_disco.sh"
    "exercicio_11_monitoramento_processos.sh"
    "exercicio_12_limpeza_final.sh"
)

# Contador de exercícios
contador=1
total=${#exercicios[@]}

# Executar cada exercício
for exercicio in "${exercicios[@]}"; do
    echo ""
    echo "📝 EXECUTANDO EXERCÍCIO $contador de $total: $exercicio"
    echo "=================================================="
    
    # Verificar se o arquivo existe
    if [ ! -f "$exercicio" ]; then
        echo "❌ Arquivo $exercicio não encontrado!"
        continue
    fi
    
    # Tornar executável
    chmod +x "$exercicio"
    
    # Executar o exercício
    if ./"$exercicio"; then
        echo "✅ Exercício $contador concluído com sucesso!"
    else
        echo "❌ Erro na execução do exercício $contador!"
        echo "Continuando com o próximo exercício..."
    fi
    
    # Incrementar contador
    ((contador++))
    
    # Pausa entre exercícios (exceto no último)
    if [ $contador -le $total ]; then
        echo ""
        echo "⏸️  Pausa de 2 segundos antes do próximo exercício..."
        sleep 2
    fi
done

echo ""
echo "🏆 EXECUÇÃO COMPLETA FINALIZADA!"
echo "==============================="
echo ""
echo "📊 RESUMO DA EXECUÇÃO:"
echo "• Total de exercícios: $total"
echo "• Exercícios executados: $((contador-1))"
echo "• Status: Concluído"
echo ""
echo "🎯 HABILIDADES DESENVOLVIDAS:"
echo "• Navegação e manipulação de arquivos"
echo "• Criação de estrutura de diretórios"
echo "• Gerenciamento de dados e logs"
echo "• Busca e filtragem de informações"
echo "• Monitoramento de sistema"
echo "• Comandos Linux essenciais"
echo ""
echo "📚 PRÓXIMOS PASSOS:"
echo "• Revise os comandos aprendidos"
echo "• Pratique os exercícios individualmente"
echo "• Explore variações dos comandos"
echo "• Consulte a documentação Linux"
echo ""
echo "✅ Treinamento prático concluído com sucesso!"
echo "=========================================="
