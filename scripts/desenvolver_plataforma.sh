#!/bin/bash

# =====================================================
# SCRIPT: DESENVOLVIMENTO DA PLATAFORMA
# Facilita o desenvolvimento e teste da plataforma
# =====================================================

echo "🚀 DESENVOLVIMENTO DA PLATAFORMA WISELEARNING"
echo "============================================="
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Diretórios
PROJETO_PRINCIPAL="/Users/imac/LinuxAvançado"
PLATAFORMA_DIR="$PROJETO_PRINCIPAL/plataforma"
WISELEARNING_DIR="/Users/imac/wiselearning-platform"

# Função para log colorido
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_dev() {
    echo -e "${PURPLE}🔧 $1${NC}"
}

# Função para iniciar servidor de desenvolvimento
start_server() {
    log_info "Iniciando servidor de desenvolvimento..."
    
    # Parar servidor existente se estiver rodando
    pkill -f "python3 -m http.server" 2>/dev/null || true
    
    # Iniciar servidor na porta 8000
    cd "$PLATAFORMA_DIR"
    log_dev "Servidor rodando em: http://localhost:8000"
    log_dev "Pressione Ctrl+C para parar o servidor"
    echo ""
    
    python3 -m http.server 8000
}

# Função para sincronizar mudanças
sync_changes() {
    log_info "Sincronizando mudanças..."
    
    # Executar script de sincronização
    cd "$PROJETO_PRINCIPAL"
    ./scripts/sincronizar_projetos.sh sync
    
    log_success "Mudanças sincronizadas"
}

# Função para verificar status
check_status() {
    log_info "Verificando status dos projetos..."
    
    echo ""
    echo "📊 PROJETO PRINCIPAL:"
    cd "$PROJETO_PRINCIPAL"
    git status --short
    
    echo ""
    echo "📊 WISELEARNING:"
    cd "$WISELEARNING_DIR"
    git status --short
    
    echo ""
    echo "🌐 SERVIDOR:"
    if pgrep -f "python3 -m http.server" > /dev/null; then
        log_success "Servidor rodando em http://localhost:8000"
    else
        log_warning "Servidor não está rodando"
    fi
    echo ""
}

# Função para fazer commit rápido
quick_commit() {
    local mensagem="${1:-feat: Mudanças de desenvolvimento}"
    
    log_info "Fazendo commit rápido..."
    
    cd "$PROJETO_PRINCIPAL"
    git add .
    git commit -m "$mensagem"
    
    # Sincronizar automaticamente
    sync_changes
    
    log_success "Commit e sincronização concluídos"
}

# Função para abrir no navegador
open_browser() {
    log_info "Abrindo plataforma no navegador..."
    
    if command -v open > /dev/null; then
        open "http://localhost:8000"
    elif command -v xdg-open > /dev/null; then
        xdg-open "http://localhost:8000"
    else
        log_warning "Não foi possível abrir o navegador automaticamente"
        log_info "Acesse manualmente: http://localhost:8000"
    fi
}

# Função para monitorar arquivos
watch_files() {
    log_info "Iniciando monitoramento de arquivos..."
    log_dev "Pressione Ctrl+C para parar o monitoramento"
    echo ""
    
    # Instalar fswatch se não estiver instalado
    if ! command -v fswatch > /dev/null; then
        log_warning "fswatch não encontrado. Instalando..."
        if command -v brew > /dev/null; then
            brew install fswatch
        else
            log_error "Por favor, instale fswatch manualmente"
            exit 1
        fi
    fi
    
    # Monitorar arquivos da plataforma
    fswatch -o "$PLATAFORMA_DIR" | while read; do
        log_info "Arquivo alterado detectado. Sincronizando..."
        sync_changes
    done
}

# Função para limpar cache
clear_cache() {
    log_info "Limpando cache do navegador..."
    
    # Limpar cache do Chrome (macOS)
    if [ -d "$HOME/Library/Caches/Google/Chrome" ]; then
        rm -rf "$HOME/Library/Caches/Google/Chrome/Default/Cache"/*
        log_success "Cache do Chrome limpo"
    fi
    
    # Limpar cache do Safari (macOS)
    if [ -d "$HOME/Library/Caches/com.apple.Safari" ]; then
        rm -rf "$HOME/Library/Caches/com.apple.Safari"/*
        log_success "Cache do Safari limpo"
    fi
    
    log_success "Cache limpo. Recarregue a página no navegador"
}

# Função para mostrar ajuda
show_help() {
    echo "Uso: $0 [comando]"
    echo ""
    echo "Comandos disponíveis:"
    echo "  start              - Iniciar servidor de desenvolvimento"
    echo "  sync               - Sincronizar mudanças entre projetos"
    echo "  status             - Verificar status dos projetos"
    echo "  commit [mensagem]  - Fazer commit rápido com sincronização"
    echo "  open               - Abrir plataforma no navegador"
    echo "  watch              - Monitorar arquivos e sincronizar automaticamente"
    echo "  clear-cache        - Limpar cache do navegador"
    echo "  help               - Mostrar esta ajuda"
    echo ""
    echo "Exemplos:"
    echo "  $0 start                    # Iniciar servidor"
    echo "  $0 commit 'fix: bug corrigido'  # Commit com mensagem específica"
    echo "  $0 watch                    # Monitorar arquivos"
}

# Menu principal
case "${1:-start}" in
    "start")
        start_server
        ;;
    "sync")
        sync_changes
        ;;
    "status")
        check_status
        ;;
    "commit")
        quick_commit "$2"
        ;;
    "open")
        open_browser
        ;;
    "watch")
        watch_files
        ;;
    "clear-cache")
        clear_cache
        ;;
    "help")
        show_help
        ;;
    *)
        log_error "Comando inválido: $1"
        show_help
        exit 1
        ;;
esac
