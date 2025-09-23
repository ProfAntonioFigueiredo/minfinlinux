#!/bin/bash

# =============================================================================
# EXERCÍCIO 12: LIMPEZA FINAL DO AMBIENTE
# Slide 23 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 12: LIMPEZA FINAL DO AMBIENTE"
echo "========================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Projeto DimDim Bank não encontrado!"
    echo "Execute os exercícios anteriores primeiro."
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

echo "🧹 REALIZANDO LIMPEZA FINAL DO AMBIENTE:"
echo ""

# Mostrar estrutura final antes da limpeza
echo "📋 Estrutura final do projeto DimDim Bank:"
find . -type f | wc -l
echo "Arquivos encontrados: $(find . -type f | wc -l)"
echo "Diretórios encontrados: $(find . -type d | wc -l)"
echo ""

echo "📁 Conteúdo final:"
ls -la
echo ""

# Mostrar tamanho total do projeto
echo "💾 Tamanho total do projeto:"
du -sh .
echo ""

# Confirmar limpeza
echo "⚠️  ATENÇÃO: Este comando irá remover COMPLETAMENTE o projeto DimDim Bank!"
echo "Todos os arquivos e diretórios criados durante os exercícios serão deletados."
echo ""

read -p "Deseja continuar com a limpeza? (s/N): " confirmacao

if [[ $confirmacao =~ ^[Ss]$ ]]; then
    echo ""
    echo "🗑️  Removendo projeto DimDim Bank..."
    
    # Voltar para o diretório home
    cd ~
    
    # Remover completamente o diretório
    rm -rf dimdim_bank
    
    echo "✅ Projeto DimDim Bank removido com sucesso!"
    echo ""
    
    # Verificar se foi removido
    if [ ! -d "dimdim_bank" ]; then
        echo "✅ Confirmação: Diretório dimdim_bank não existe mais."
    else
        echo "❌ Erro: Diretório ainda existe."
    fi
    
    echo ""
    echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
    echo "• Usar 'rm -rf' para remoção recursiva"
    echo "• Entender perigos da remoção em massa"
    echo "• Confirmar ações destrutivas"
    echo "• Limpar ambiente de teste"
    echo "• Finalizar projeto prático"
    echo ""
    
    echo "💡 COMANDOS APRENDIDOS:"
    echo "• 'rm -rf diretorio' - Remove diretório e conteúdo"
    echo "• 'find . -type f | wc -l' - Conta arquivos"
    echo "• 'find . -type d | wc -l' - Conta diretórios"
    echo "• 'du -sh .' - Tamanho do diretório"
    echo "• 'read -p' - Confirmação interativa"
    echo ""
    
    echo "⚠️  IMPORTANTE:"
    echo "• 'rm -rf' é um comando DESTRUTIVO"
    echo "• Sempre confirme antes de usar"
    echo "• Use com extremo cuidado"
    echo "• Não use em produção sem backup"
    echo ""
    
    echo "🏆 PARABÉNS! TODOS OS EXERCÍCIOS CONCLUÍDOS!"
    echo "========================================="
    echo "Você completou com sucesso todos os 12 exercícios do projeto DimDim Bank!"
    echo "Habilidades desenvolvidas:"
    echo "• Navegação e manipulação de arquivos"
    echo "• Criação de estrutura de diretórios"
    echo "• Gerenciamento de dados e logs"
    echo "• Busca e filtragem de informações"
    echo "• Monitoramento de sistema"
    echo "• Comandos Linux essenciais"
    echo ""
    echo "✅ Exercício 12 concluído! Ambiente limpo."
    
else
    echo ""
    echo "❌ Limpeza cancelada pelo usuário."
    echo "O projeto DimDim Bank foi mantido para futuras consultas."
    echo ""
    echo "Para remover manualmente mais tarde, execute:"
    echo "cd ~ && rm -rf dimdim_bank"
fi

echo "========================================="
