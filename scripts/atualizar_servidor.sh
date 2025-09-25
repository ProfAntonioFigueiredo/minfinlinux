#!/bin/bash

# =============================================================================
# SCRIPT PARA ATUALIZAR SERVIDOR MINFIN
# Ministério das Finanças de Angola - Treinamento Linux Avançado
# =============================================================================

echo "🔄 ATUALIZANDO SERVIDOR MINFIN"
echo "=============================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "/home/devops/minfinlinux" ]; then
    echo "❌ Diretório /home/devops/minfinlinux não encontrado!"
    echo "Execute: cd /home/devops && git clone https://github.com/ProfAntonioFigueiredo/minfinlinux.git"
    exit 1
fi

cd /home/devops/minfinlinux

echo "🔧 Comando: Verificar status atual do repositório"
git status
echo ""

echo "🔧 Comando: Verificar branch atual"
git branch
echo ""

echo "🔧 Comando: Verificar remotes configurados"
git remote -v
echo ""

echo "🔧 Comando: Buscar atualizações do GitHub"
git fetch origin
echo ""

echo "🔧 Comando: Verificar diferenças com o repositório remoto"
git log HEAD..origin/main --oneline
echo ""

echo "🔧 Comando: Atualizar repositório local"
git pull origin main
echo ""

echo "🔧 Comando: Verificar arquivos atualizados"
ls -la modulos/
echo ""

echo "🔧 Comando: Verificar se os novos módulos estão presentes"
ls -la modulos/modulo5_seguranca_redes/ 2>/dev/null || echo "Módulo 5 não encontrado"
ls -la modulos/modulo6_observabilidade/ 2>/dev/null || echo "Módulo 6 não encontrado"
echo ""

echo "🔧 Comando: Verificar GitHub Actions"
ls -la .github/workflows/ 2>/dev/null || echo "GitHub Actions não encontrados"
echo ""

echo "🔧 Comando: Verificar estrutura da plataforma"
find plataforma/modulos -name "*.html" | wc -l
echo "Arquivos HTML encontrados: $(find plataforma/modulos -name "*.html" | wc -l)"
echo ""

echo "🔧 Comando: Testar servidor local"
if pgrep -f "python3 -m http.server" > /dev/null; then
    echo "✅ Servidor já está rodando"
    echo "PID: $(pgrep -f "python3 -m http.server")"
else
    echo "🚀 Iniciando servidor..."
    nohup python3 -m http.server 8000 > /dev/null 2>&1 &
    echo "✅ Servidor iniciado na porta 8000"
fi
echo ""

echo "🔧 Comando: Verificar se o servidor está respondendo"
sleep 2
curl -s -o /dev/null -w "%{http_code}" http://localhost:8000
echo ""
echo ""

echo "✅ ATUALIZAÇÃO CONCLUÍDA!"
echo "========================"
echo ""
echo "📋 RESUMO:"
echo "• Repositório atualizado com sucesso"
echo "• Servidor rodando na porta 8000"
echo "• Acesse: http://seu-servidor:8000"
echo ""
echo "🎯 PRÓXIMOS PASSOS:"
echo "• Testar navegação na plataforma"
echo "• Verificar se todos os módulos carregam"
echo "• Configurar deployment automático"
echo ""
