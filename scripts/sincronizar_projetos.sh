#!/bin/bash

# =====================================================
# SCRIPT: SINCRONIZAÇÃO AUTOMÁTICA DE PROJETOS
# Mantém ambos os repositórios sempre atualizados
# =====================================================

echo "🔄 SINCRONIZAÇÃO AUTOMÁTICA DE PROJETOS"
echo "======================================"
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Diretórios
PROJETO_PRINCIPAL="/Users/imac/LinuxAvançado"
PROJETO_WISELEARNING="/Users/imac/wiselearning-platform"

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

# Função para sincronizar do principal para wiselearning
sync_to_wiselearning() {
    log_info "Sincronizando do projeto principal para WiseLearning..."
    
    # Copiar arquivos da plataforma
    cp -r "$PROJETO_PRINCIPAL/plataforma"/* "$PROJETO_WISELEARNING/"
    
    # Copiar módulos se existirem
    if [ -d "$PROJETO_PRINCIPAL/modulos" ]; then
        cp -r "$PROJETO_PRINCIPAL/modulos" "$PROJETO_WISELEARNING/"
    fi
    
    # Copiar scripts se existirem
    if [ -d "$PROJETO_PRINCIPAL/scripts" ]; then
        cp -r "$PROJETO_PRINCIPAL/scripts" "$PROJETO_WISELEARNING/"
    fi
    
    log_success "Arquivos copiados para WiseLearning"
}

# Função para sincronizar do wiselearning para principal
sync_from_wiselearning() {
    log_info "Sincronizando do WiseLearning para projeto principal..."
    
    # Copiar arquivos da plataforma
    cp -r "$PROJETO_WISELEARNING"/* "$PROJETO_PRINCIPAL/plataforma/"
    
    log_success "Arquivos copiados para projeto principal"
}

# Função para fazer commit e push
commit_and_push() {
    local diretorio="$1"
    local mensagem="$2"
    
    cd "$diretorio"
    
    # Verificar se há mudanças
    if [ -n "$(git status --porcelain)" ]; then
        log_info "Fazendo commit das mudanças em $(basename "$diretorio")..."
        git add .
        git commit -m "$mensagem"
        
        # Push para origin
        log_info "Enviando para repositório principal..."
        git push origin main
        
        # Push para wiselearning se for o projeto principal
        if [ "$diretorio" = "$PROJETO_PRINCIPAL" ]; then
            log_info "Enviando para repositório WiseLearning..."
            git push wiselearning main 2>/dev/null || log_warning "Falha ao enviar para WiseLearning (normal se não configurado)"
        fi
        
        log_success "Mudanças enviadas com sucesso"
    else
        log_info "Nenhuma mudança detectada em $(basename "$diretorio")"
    fi
}

# Função para sincronização bidirecional
sync_bidirectional() {
    log_info "Iniciando sincronização bidirecional..."
    
    # 1. Sincronizar do principal para wiselearning
    sync_to_wiselearning
    
    # 2. Fazer commit no wiselearning
    commit_and_push "$PROJETO_WISELEARNING" "feat: Sincronização automática - $(date '+%Y-%m-%d %H:%M:%S')"
    
    # 3. Fazer commit no principal
    commit_and_push "$PROJETO_PRINCIPAL" "feat: Sincronização automática - $(date '+%Y-%m-%d %H:%M:%S')"
    
    log_success "Sincronização bidirecional concluída"
}

# Função para verificar status
check_status() {
    log_info "Verificando status dos repositórios..."
    
    echo ""
    echo "📊 PROJETO PRINCIPAL:"
    cd "$PROJETO_PRINCIPAL"
    git status --short
    echo ""
    
    echo "📊 WISELEARNING:"
    cd "$PROJETO_WISELEARNING"
    git status --short
    echo ""
}

# Função para configurar repositórios
setup_repos() {
    log_info "Configurando repositórios..."
    
    # Configurar projeto principal
    cd "$PROJETO_PRINCIPAL"
    git remote add wiselearning https://ProfAntonioFigueiredo@dev.azure.com/ProfAntonioFigueiredo/MinFIN%20-%20DevOps/_git/wiselearning 2>/dev/null || log_info "Remote wiselearning já configurado"
    
    # Configurar wiselearning
    cd "$PROJETO_WISELEARNING"
    git remote add origin https://ProfAntonioFigueiredo@dev.azure.com/ProfAntonioFigueiredo/MinFIN%20-%20DevOps/_git/wiselearning 2>/dev/null || log_info "Remote origin já configurado"
    
    log_success "Repositórios configurados"
}

# Menu principal
case "${1:-sync}" in
    "sync")
        sync_bidirectional
        ;;
    "to-wiselearning")
        sync_to_wiselearning
        commit_and_push "$PROJETO_WISELEARNING" "feat: Sincronização do projeto principal - $(date '+%Y-%m-%d %H:%M:%S')"
        ;;
    "from-wiselearning")
        sync_from_wiselearning
        commit_and_push "$PROJETO_PRINCIPAL" "feat: Sincronização do WiseLearning - $(date '+%Y-%m-%d %H:%M:%S')"
        ;;
    "status")
        check_status
        ;;
    "setup")
        setup_repos
        ;;
    "help")
        echo "Uso: $0 [comando]"
        echo ""
        echo "Comandos disponíveis:"
        echo "  sync                - Sincronização bidirecional (padrão)"
        echo "  to-wiselearning     - Sincronizar apenas para WiseLearning"
        echo "  from-wiselearning   - Sincronizar apenas do WiseLearning"
        echo "  status              - Verificar status dos repositórios"
        echo "  setup               - Configurar repositórios"
        echo "  help                - Mostrar esta ajuda"
        ;;
    *)
        log_error "Comando inválido: $1"
        echo "Use '$0 help' para ver os comandos disponíveis"
        exit 1
        ;;
esac

echo ""
log_success "Script de sincronização concluído!"
echo ""
