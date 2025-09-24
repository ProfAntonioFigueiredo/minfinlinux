#!/bin/bash

# =============================================================================
# EXERCÍCIO 11: MONITORAMENTO DE PROCESSOS
# Slide 22 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 11: MONITORAMENTO DE PROCESSOS"
echo "=========================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1-10 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

echo "⚙️  DEMONSTRANDO COMANDOS DE MONITORAMENTO DE PROCESSOS:"
echo ""

# Listar processos do usuário atual
echo "👤 Listando processos do usuário atual:"
ps
echo ""

# Listar todos os processos detalhadamente
echo "📋 Listando todos os processos detalhadamente:"
ps -aux
echo ""

# Buscar processos específicos (bash)
echo "🔍 Buscando processos bash:"
ps -aux | grep bash
echo ""

# Buscar processos relacionados ao sistema
echo "🖥️  Buscando processos do sistema:"
ps -aux | grep -E "(systemd|kernel)" | head -5
echo ""

# Mostrar processos em tempo real (por 5 segundos)
echo "⏱️  Mostrando processos em tempo real (5 segundos):"
echo "Pressione 'q' para sair do top ou aguarde 5 segundos..."
timeout 5s top -n 1
echo ""

# Mostrar informações do sistema
echo "📊 Informações do sistema:"
echo "Usuário atual: $(whoami)"
echo "Data/Hora: $(date)"
echo "Uptime: $(uptime)"
echo ""

# Mostrar processos por CPU
echo "🔥 Processos ordenados por uso de CPU:"
ps -aux --sort=-%cpu | head -10
echo ""

# Mostrar processos por memória
echo "🧠 Processos ordenados por uso de memória:"
ps -aux --sort=-%mem | head -10
echo ""

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Usar 'ps' para listar processos"
echo "• Usar 'ps -aux' para listagem detalhada"
echo "• Usar 'grep' para filtrar processos"
echo "• Usar 'top' para monitoramento em tempo real"
echo "• Entender informações de processos"
echo "• Monitorar uso de CPU e memória"
echo ""

echo "📊 INFORMAÇÕES MOSTRADAS:"
echo "• Processos do usuário atual"
echo "• Todos os processos do sistema"
echo "• Processos específicos (bash)"
echo "• Processos do sistema"
echo "• Monitoramento em tempo real"
echo "• Informações do sistema"
echo "• Processos por CPU"
echo "• Processos por memória"
echo ""

echo "💡 COMANDOS APRENDIDOS:"
echo "• 'ps' - Lista processos do usuário"
echo "• 'ps -aux' - Lista todos os processos"
echo "• 'ps -aux | grep texto' - Filtra processos"
echo "• 'top' - Monitoramento em tempo real"
echo "• 'ps -aux --sort=-%cpu' - Ordena por CPU"
echo "• 'ps -aux --sort=-%mem' - Ordena por memória"
echo "• 'whoami' - Usuário atual"
echo "• 'date' - Data e hora"
echo "• 'uptime' - Tempo de atividade"
echo ""

echo "⚠️  IMPORTANTE:"
echo "• Monitore processos regularmente"
echo "• Identifique processos que consomem muitos recursos"
echo "• Use 'top' para monitoramento contínuo"
echo "• Use 'ps' para listagens pontuais"
echo ""

echo "✅ Exercício 11 concluído! Monitoramento de processos realizado."
echo "=========================================="
