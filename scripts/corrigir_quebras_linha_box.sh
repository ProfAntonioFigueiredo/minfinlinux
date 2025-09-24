#!/bin/bash

# =====================================================
# SCRIPT: CORRIGIR QUEBRAS DE LINHA NOS BOX DE COMANDOS
# Adiciona quebras de linha adequadas nos BOX de comandos
# =====================================================

echo "🔧 CORRIGINDO QUEBRAS DE LINHA NOS BOX DE COMANDOS"
echo "================================================="
echo ""

# Arquivo a ser corrigido
ARQUIVO="/Users/imac/LinuxAvançado/plataforma/modulos/modulo1_introducao_completa.html"

# Verificar se o arquivo existe
if [ ! -f "$ARQUIVO" ]; then
    echo "❌ Arquivo não encontrado: $ARQUIVO"
    exit 1
fi

# Fazer backup
cp "$ARQUIVO" "${ARQUIVO}.backup"
echo "✅ Backup criado: ${ARQUIVO}.backup"

# Função para corrigir quebras de linha em um BOX
corrigir_box() {
    local arquivo="$1"
    
    echo "🔧 Corrigindo quebras de linha no arquivo: $(basename "$arquivo")"
    
    # Usar sed para adicionar <br> após cada comando (exceto o último)
    sed -i '' '
    # Padrão para comandos com comentários
    s/\(<span class="command">[^<]*<\/span> <span class="comment">[^<]*<\/span>\)$/\1<br>/
    
    # Padrão para comandos sem comentários
    s/\(<span class="command">[^<]*<\/span>\)$/\1<br>/
    
    # Padrão para comentários isolados
    s/\(<span class="comment">[^<]*<\/span>\)$/\1<br>/
    ' "$arquivo"
    
    # Remover <br> da última linha de cada BOX
    sed -i '' '
    # Encontrar o fechamento de </div> e remover <br> da linha anterior
    /^[[:space:]]*<\/div>$/ {
        N
        s/\(.*\)<br>[[:space:]]*<\/div>/\1\n                <\/div>/
    }
    ' "$arquivo"
    
    echo "✅ Quebras de linha corrigidas"
}

# Corrigir o arquivo
corrigir_box "$ARQUIVO"

echo ""
echo "🎉 CORREÇÃO CONCLUÍDA!"
echo "📁 Backup salvo em: ${ARQUIVO}.backup"
echo "✅ Arquivo corrigido: $ARQUIVO"
echo ""
echo "💡 Para testar, acesse: http://localhost:8000/modulos/modulo1_introducao_completa.html"
