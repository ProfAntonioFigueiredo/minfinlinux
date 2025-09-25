#!/bin/bash

# =============================================================================
# SCRIPT DE VERIFICAÇÃO RÁPIDA DO SERVIDOR
# Ministério das Finanças de Angola - Treinamento Linux Avançado
# =============================================================================

echo "🔍 VERIFICAÇÃO RÁPIDA DO SERVIDOR MINFIN"
echo "========================================"
echo ""

# Verificar se estamos no servidor
if [ ! -f "/home/devops/minfinlinux/index.html" ]; then
    echo "❌ Não estamos no servidor correto!"
    echo "Execute este script no servidor Ubuntu em: /home/devops/minfinlinux"
    exit 1
fi

cd /home/devops/minfinlinux

echo "🔧 Comando: Verificar versão atual"
git log --oneline -5
echo ""

echo "🔧 Comando: Verificar módulos disponíveis"
ls -la modulos/
echo ""

echo "🔧 Comando: Verificar se módulos 5 e 6 existem"
if [ -d "modulos/modulo5_seguranca_redes" ]; then
    echo "✅ Módulo 5 (Segurança) encontrado"
else
    echo "❌ Módulo 5 não encontrado"
fi

if [ -d "modulos/modulo6_observabilidade" ]; then
    echo "✅ Módulo 6 (Observabilidade) encontrado"
else
    echo "❌ Módulo 6 não encontrado"
fi
echo ""

echo "🔧 Comando: Verificar GitHub Actions"
if [ -d ".github/workflows" ]; then
    echo "✅ GitHub Actions encontrados"
    ls -la .github/workflows/
else
    echo "❌ GitHub Actions não encontrados"
fi
echo ""

echo "🔧 Comando: Verificar se servidor está rodando"
if pgrep -f "python3 -m http.server" > /dev/null; then
    echo "✅ Servidor está rodando"
    echo "PID: $(pgrep -f "python3 -m http.server")"
    echo "Porta: 8000"
else
    echo "❌ Servidor não está rodando"
    echo "Execute: python3 -m http.server 8000 &"
fi
echo ""

echo "🔧 Comando: Testar acesso à plataforma"
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8000 | grep -q "200"; then
    echo "✅ Plataforma acessível"
    echo "URL: http://localhost:8000"
else
    echo "❌ Plataforma não acessível"
fi
echo ""

echo "📊 RESUMO DA VERIFICAÇÃO:"
echo "========================="
echo "• Diretório: $(pwd)"
echo "• Branch: $(git branch --show-current)"
echo "• Último commit: $(git log -1 --format='%h %s')"
echo "• Módulos: $(ls modulos/ | wc -l) encontrados"
echo "• Servidor: $(pgrep -f "python3 -m http.server" > /dev/null && echo "Rodando" || echo "Parado")"
echo ""
