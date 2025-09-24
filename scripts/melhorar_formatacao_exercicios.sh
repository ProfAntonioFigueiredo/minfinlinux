#!/bin/bash

# =====================================================
# SCRIPT: MELHORAR FORMATAÇÃO DOS EXERCÍCIOS
# Adiciona quebras de linha e formatação melhorada
# =====================================================

echo "🔧 MELHORANDO FORMATAÇÃO DOS EXERCÍCIOS..."
echo "=========================================="
echo ""

# Função para melhorar formatação de um arquivo
melhorar_arquivo() {
    local arquivo="$1"
    local nome_arquivo=$(basename "$arquivo")
    
    echo "📝 Processando: $nome_arquivo"
    
    # Criar backup
    cp "$arquivo" "${arquivo}.backup"
    
    # Aplicar melhorias de formatação
    sed -i '' '
    # Adicionar quebra de linha antes de comandos importantes
    s/^echo "🔧 \([^"]*\):"$/echo "🔧 Comando: \1"\necho ""\n\1/
    s/^echo "📋 \([^"]*\):"$/echo "📋 Comando: \1"\necho "📋 \1:"/
    s/^echo "🔍 \([^"]*\):"$/echo "🔍 Comando: \1"\necho "🔍 \1:"/
    s/^echo "⚙️  \([^"]*\):"$/echo "⚙️  Comando: \1"\necho "⚙️  \1:"/
    s/^echo "💾 \([^"]*\):"$/echo "💾 Comando: \1"\necho "💾 \1:"/
    s/^echo "👤 \([^"]*\):"$/echo "👤 Comando: \1"\necho "👤 \1:"/
    s/^echo "📊 \([^"]*\):"$/echo "📊 Comando: \1"\necho "📊 \1:"/
    s/^echo "📁 \([^"]*\):"$/echo "📁 Comando: \1"\necho "📁 \1:"/
    s/^echo "📄 \([^"]*\):"$/echo "📄 Comando: \1"\necho "📄 \1:"/
    s/^echo "🔌 \([^"]*\):"$/echo "🔌 Comando: \1"\necho "🔌 \1:"/
    s/^echo "❌ \([^"]*\):"$/echo "❌ Comando: \1"\necho "❌ \1:"/
    s/^echo "✅ \([^"]*\):"$/echo "✅ Comando: \1"\necho "✅ \1:"/
    s/^echo "💰 \([^"]*\):"$/echo "💰 Comando: \1"\necho "💰 \1:"/
    s/^echo "📈 \([^"]*\):"$/echo "📈 Comando: \1"\necho "📈 \1:"/
    s/^echo "📋 \([^"]*\):"$/echo "📋 Comando: \1"\necho "📋 \1:"/
    s/^echo "🔍 \([^"]*\):"$/echo "🔍 Comando: \1"\necho "🔍 \1:"/
    s/^echo "📊 \([^"]*\):"$/echo "📊 Comando: \1"\necho "📊 \1:"/
    s/^echo "💻 \([^"]*\):"$/echo "💻 Comando: \1"\necho "💻 \1:"/
    s/^echo "📁 \([^"]*\):"$/echo "📁 Comando: \1"\necho "📁 \1:"/
    s/^echo "📄 \([^"]*\):"$/echo "📄 Comando: \1"\necho "📄 \1:"/
    s/^echo "🔌 \([^"]*\):"$/echo "🔌 Comando: \1"\necho "🔌 \1:"/
    s/^echo "❌ \([^"]*\):"$/echo "❌ Comando: \1"\necho "❌ \1:"/
    s/^echo "✅ \([^"]*\):"$/echo "✅ Comando: \1"\necho "✅ \1:"/
    s/^echo "💰 \([^"]*\):"$/echo "💰 Comando: \1"\necho "💰 \1:"/
    s/^echo "📈 \([^"]*\):"$/echo "📈 Comando: \1"\necho "📈 \1:"/
    ' "$arquivo"
    
    echo "✅ Formatação melhorada: $nome_arquivo"
}

# Lista de arquivos para melhorar
arquivos=(
    "/Users/imac/LinuxAvançado/modulos/modulo1_fundamentos_linux/exercicios/exercicio_permissoes_arquivos.sh"
    "/Users/imac/LinuxAvançado/modulos/modulo1_fundamentos_linux/exercicios/exercicio_usuarios_grupos.sh"
    "/Users/imac/LinuxAvançado/modulos/modulo1_fundamentos_linux/exercicios/exercicio_processos_servicos.sh"
    "/Users/imac/LinuxAvançado/modulos/modulo2_redes_seguranca/exercicios/exercicio_calculo_subredes.sh"
    "/Users/imac/LinuxAvançado/modulos/modulo2_redes_seguranca/exercicios/exercicio_controles_acesso.sh"
    "/Users/imac/LinuxAvançado/modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh"
    "/Users/imac/LinuxAvançado/plataforma/exercicios/comandos_basicos_linux.sh"
    "/Users/imac/LinuxAvançado/plataforma/exercicios/modulo1_exercicio_integrado.sh"
)

# Processar cada arquivo
for arquivo in "${arquivos[@]}"; do
    if [ -f "$arquivo" ]; then
        melhorar_arquivo "$arquivo"
    else
        echo "⚠️  Arquivo não encontrado: $arquivo"
    fi
done

echo ""
echo "🎉 FORMATAÇÃO CONCLUÍDA!"
echo "📁 Backups criados com extensão .backup"
echo "✅ Todos os exercícios foram melhorados"
echo ""
