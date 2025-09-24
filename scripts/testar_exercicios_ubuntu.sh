#!/bin/bash

# =============================================================================
# TESTE DOS EXERCÍCIOS - UBUNTU 24.04 LTS
# Treinamento Linux - Ministério das Finanças de Angola
# =============================================================================

echo "🧪 TESTANDO EXERCÍCIOS - UBUNTU 24.04 LTS"
echo "========================================="
echo ""

# Verificar se está no diretório correto
if [ ! -d "modulos" ]; then
    echo "❌ Execute este script no diretório raiz do projeto"
    exit 1
fi

echo "✅ Diretório correto detectado"
echo "📍 Diretório atual: $(pwd)"
echo ""

# Função para testar script
test_script() {
    local script=$1
    local module=$2
    
    if [ -f "$script" ]; then
        echo "🧪 Testando: $script"
        
        # Tornar executável
        chmod +x "$script"
        
        # Executar com timeout (30 segundos)
        if timeout 30s "$script" >/dev/null 2>&1; then
            echo "✅ $script - OK"
        else
            echo "⚠️  $script - Timeout ou erro"
        fi
    else
        echo "❌ $script - Não encontrado"
    fi
    echo ""
}

# Testar scripts do Módulo 1
echo "📝 Testando scripts do Módulo 1..."
test_script "modulos/modulo1_fundamentos_linux/exercicios/exercicio_permissoes_arquivos.sh" "Módulo 1"
test_script "modulos/modulo1_fundamentos_linux/exercicios/exercicio_usuarios_grupos.sh" "Módulo 1"
test_script "modulos/modulo1_fundamentos_linux/exercicios/exercicio_processos_servicos.sh" "Módulo 1"

# Testar scripts do Módulo 2
echo "📝 Testando scripts do Módulo 2..."
test_script "modulos/modulo2_redes_seguranca/exercicios/exercicio_calculo_subredes.sh" "Módulo 2"
test_script "modulos/modulo2_redes_seguranca/exercicios/exercicio_controles_acesso.sh" "Módulo 2"
test_script "modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh" "Módulo 2"

echo "✅ Teste dos exercícios concluído!"
echo "========================================="
