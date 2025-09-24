#!/bin/bash

# =============================================================================
# EXERCÍCIO 7: GERENCIAMENTO DE LOGS DO SISTEMA
# Slide 18 - Treinamento Linux MINFIN Angola
# =============================================================================

echo "🏦 EXERCÍCIO 7: GERENCIAMENTO DE LOGS DO SISTEMA"
echo "==============================================="
echo ""

# Verificar se estamos no diretório correto
if [ ! -d "dimdim_bank" ]; then
    echo "⚠️  Executando exercícios anteriores primeiro..."
    echo "Execute os exercícios 1-6 antes deste!"
    exit 1
fi

cd dimdim_bank
echo "📍 Diretório atual: $(pwd)"
echo ""

# Navegar para diretório de logs
echo "📝 Criando arquivos de log do sistema:"
cd logs

# Criar arquivos de log
touch sistema_dimdim.log acesso_usuarios.log transacoes_api.log erro_sistema.log
echo "✅ Arquivos de log criados:"
ls -l *.log
echo ""

# Adicionar logs do sistema
echo "📝 Adicionando logs do sistema DimDim:"
echo "2025-01-28 09:15:32 [INFO] Sistema DimDim iniciado com sucesso" > sistema_dimdim.log
echo "2025-01-28 09:16:45 [INFO] Módulo de transações carregado" >> sistema_dimdim.log
echo "2025-01-28 09:17:12 [ERROR] Falha na conexão com banco de dados" >> sistema_dimdim.log
echo "2025-01-28 09:18:00 [INFO] Reconexão com banco estabelecida" >> sistema_dimdim.log
echo "2025-01-28 09:20:15 [WARN] Alto volume de transações detectado" >> sistema_dimdim.log
echo "✅ Logs do sistema adicionados!"
echo ""

# Adicionar logs de acesso de usuários
echo "📝 Adicionando logs de acesso de usuários:"
echo "2025-01-28 08:30:15 LOGIN joao.silva 192.168.1.100 SUCCESS" > acesso_usuarios.log
echo "2025-01-28 08:45:22 LOGIN maria.santos 192.168.1.101 SUCCESS" >> acesso_usuarios.log
echo "2025-01-28 09:12:33 LOGIN pedro.oliveira 192.168.1.102 FAILED" >> acesso_usuarios.log
echo "2025-01-28 09:13:01 LOGIN pedro.oliveira 192.168.1.102 SUCCESS" >> acesso_usuarios.log
echo "2025-01-28 09:45:18 LOGOUT joao.silva 192.168.1.100" >> acesso_usuarios.log
echo "✅ Logs de acesso adicionados!"
echo ""

# Voltar para diretório principal
cd ~/dimdim_bank

echo "🎯 OBJETIVOS DESTE EXERCÍCIO:"
echo "• Criar arquivos de log do sistema"
echo "• Adicionar diferentes tipos de logs"
echo "• Entender estrutura de logs profissionais"
echo "• Usar timestamps em logs"
echo "• Organizar logs por categoria"
echo ""

echo "📊 LOGS CRIADOS:"
echo "• sistema_dimdim.log - Logs gerais do sistema"
echo "• acesso_usuarios.log - Logs de login/logout"
echo "• transacoes_api.log - Logs de API (próximo exercício)"
echo "• erro_sistema.log - Logs de erros (próximo exercício)"
echo ""

echo "💡 ESTRUTURA DE LOGS:"
echo "• Timestamp: 2025-01-28 09:15:32"
echo "• Nível: [INFO], [ERROR], [WARN]"
echo "• Mensagem: Descrição do evento"
echo "• Dados adicionais: IP, usuário, status"
echo ""

echo "✅ Exercício 7 concluído! Logs do sistema criados."
echo "==============================================="
