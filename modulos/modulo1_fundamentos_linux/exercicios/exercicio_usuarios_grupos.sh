#!/bin/bash

# =============================================================================
# EXERCÍCIO: GESTÃO DE USUÁRIOS E GRUPOS
# Módulo 1 - Treinamento Linux MINFIN Angola
# Ubuntu 24.04 LTS (Noble Numbat) - Comandos otimizados
# =============================================================================

echo "👥 EXERCÍCIO: GESTÃO DE USUÁRIOS E GRUPOS"
echo "========================================"
echo ""

# Verificar se temos privilégios de root
if [ "$EUID" -ne 0 ]; then
    echo "⚠️  Este exercício requer privilégios de root (sudo)."
    echo "Execute com: sudo ./exercicio_usuarios_grupos.sh"
    exit 1
fi

echo "✅ Executando como root. Privilégios adequados confirmados."
echo "📍 Diretório atual: $(pwd)"
echo ""

# Exercício 1: Verificar usuário atual e informações do sistema
echo "📝 EXERCÍCIO 1: Informações do usuário atual"
echo "-------------------------------------------"
echo "👤 Comando: Usuário atual"
echo "👤 Usuário atual:"
whoami
echo ""

echo "🆔 Informações completas do usuário:"
id
echo ""

echo "👥 Grupos do usuário atual:"
groups
echo ""

# Exercício 2: Listar usuários do sistema
echo "📝 EXERCÍCIO 2: Listando usuários do sistema"
echo "-------------------------------------------"
echo "📋 Comando: Todos os usuários do sistema"
echo "📋 Todos os usuários do sistema:"
cut -d: -f1 /etc/passwd | head -10
echo ""

echo "📋 Comando: Usuários com shell de login"
echo "📋 Usuários com shell de login:"
grep -E "/(bash|sh)$" /etc/passwd | cut -d: -f1
echo ""

echo "📋 Comando: Usuários do sistema (UID < 1000)"
echo "📋 Usuários do sistema (UID < 1000):"
awk -F: '$3 < 1000 {print $1}' /etc/passwd
echo ""

# Exercício 3: Listar grupos do sistema
echo "📝 EXERCÍCIO 3: Listando grupos do sistema"
echo "----------------------------------------"
echo "📋 Comando: Todos os grupos do sistema"
echo "📋 Todos os grupos do sistema:"
cut -d: -f1 /etc/group | head -10
echo ""

echo "📋 Comando: Grupos do sistema (GID < 1000)"
echo "📋 Grupos do sistema (GID < 1000):"
awk -F: '$3 < 1000 {print $1}' /etc/group
echo ""

# Exercício 4: Criar grupos departamentais
echo "📝 EXERCÍCIO 4: Criando grupos departamentais"
echo "-------------------------------------------"
echo "🏢 Criando grupos para departamentos:"

# Criar grupos se não existirem
if ! getent group ti > /dev/null 2>&1; then
    groupadd ti
    echo "✅ Grupo 'ti' criado"
else
    echo "ℹ️  Grupo 'ti' já existe"
fi

if ! getent group financeiro > /dev/null 2>&1; then
    groupadd financeiro
    echo "✅ Grupo 'financeiro' criado"
else
    echo "ℹ️  Grupo 'financeiro' já existe"
fi

if ! getent group rh > /dev/null 2>&1; then
    groupadd rh
    echo "✅ Grupo 'rh' criado"
else
    echo "ℹ️  Grupo 'rh' já existe"
fi

echo ""
echo "📋 Comando: Verificando grupos criados"
echo "📋 Verificando grupos criados:"
getent group ti financeiro rh
echo ""

# Exercício 5: Criar usuários para cada departamento
echo "📝 EXERCÍCIO 5: Criando usuários departamentais"
echo "----------------------------------------------"

# Criar usuários se não existirem
if ! getent passwd joao.ti > /dev/null 2>&1; then
    useradd -m -s /bin/bash -g ti joao.ti
    echo "joao.ti:senha123" | chpasswd
    echo "✅ Usuário 'joao.ti' criado"
else
    echo "ℹ️  Usuário 'joao.ti' já existe"
fi

if ! getent passwd maria.fin > /dev/null 2>&1; then
    useradd -m -s /bin/bash -g financeiro maria.fin
    echo "maria.fin:senha123" | chpasswd
    echo "✅ Usuário 'maria.fin' criado"
else
    echo "ℹ️  Usuário 'maria.fin' já existe"
fi

if ! getent passwd pedro.rh > /dev/null 2>&1; then
    useradd -m -s /bin/bash -g rh pedro.rh
    echo "pedro.rh:senha123" | chpasswd
    echo "✅ Usuário 'pedro.rh' criado"
else
    echo "ℹ️  Usuário 'pedro.rh' já existe"
fi

echo ""

# Exercício 6: Verificar informações dos usuários criados
echo "📝 EXERCÍCIO 6: Verificando informações dos usuários"
echo "--------------------------------------------------"
echo "👤 Comando: Informações do usuário joao.ti"
echo "👤 Informações do usuário joao.ti:"
id joao.ti
echo ""

echo "👤 Comando: Informações do usuário maria.fin"
echo "👤 Informações do usuário maria.fin:"
id maria.fin
echo ""

echo "👤 Comando: Informações do usuário pedro.rh"
echo "👤 Informações do usuário pedro.rh:"
id pedro.rh
echo ""

# Exercício 7: Adicionar usuários a grupos secundários
echo "📝 EXERCÍCIO 7: Adicionando usuários a grupos secundários"
echo "-------------------------------------------------------"
echo "🔧 Comando: Adicionando joao.ti ao grupo administradores"
echo ""
Adicionando joao.ti ao grupo administradores
if getent group administradores > /dev/null 2>&1; then
    usermod -a -G administradores joao.ti
    echo "✅ joao.ti adicionado ao grupo administradores"
else
    groupadd administradores
    usermod -a -G administradores joao.ti
    echo "✅ Grupo administradores criado e joao.ti adicionado"
fi

echo "🔧 Comando: Adicionando maria.fin ao grupo contadores"
echo ""
Adicionando maria.fin ao grupo contadores
if getent group contadores > /dev/null 2>&1; then
    usermod -a -G contadores maria.fin
    echo "✅ maria.fin adicionado ao grupo contadores"
else
    groupadd contadores
    usermod -a -G contadores maria.fin
    echo "✅ Grupo contadores criado e maria.fin adicionado"
fi

echo ""

# Exercício 8: Verificar grupos dos usuários
echo "📝 EXERCÍCIO 8: Verificando grupos dos usuários"
echo "---------------------------------------------"
echo "👥 Grupos do joao.ti:"
groups joao.ti
echo ""

echo "👥 Grupos do maria.fin:"
groups maria.fin
echo ""

echo "👥 Grupos do pedro.rh:"
groups pedro.rh
echo ""

# Exercício 9: Modificar propriedades dos usuários
echo "📝 EXERCÍCIO 9: Modificando propriedades dos usuários"
echo "---------------------------------------------------"
echo "🔧 Comando: Alterando shell do joao.ti para zsh"
echo ""
Alterando shell do joao.ti para zsh
usermod -s /bin/zsh joao.ti
echo "✅ Shell alterado para zsh"

echo "🔧 Comando: Adicionando comentário ao maria.fin"
echo ""
Adicionando comentário ao maria.fin
usermod -c "Maria Santos - Departamento Financeiro" maria.fin
echo "✅ Comentário adicionado"

echo "🔧 Comando: Alterando diretório home do pedro.rh"
echo ""
Alterando diretório home do pedro.rh
usermod -d /home/pedro_rh pedro.rh
echo "✅ Diretório home alterado"

echo ""

# Exercício 10: Verificar modificações
echo "📝 EXERCÍCIO 10: Verificando modificações"
echo "----------------------------------------"
echo "📋 Comando: Informações atualizadas do joao.ti"
echo "📋 Informações atualizadas do joao.ti:"
getent passwd joao.ti
echo ""

echo "📋 Comando: Informações atualizadas do maria.fin"
echo "📋 Informações atualizadas do maria.fin:"
getent passwd maria.fin
echo ""

echo "📋 Comando: Informações atualizadas do pedro.rh"
echo "📋 Informações atualizadas do pedro.rh:"
getent passwd pedro.rh
echo ""

# Exercício 11: Trabalhar com senhas
echo "📝 EXERCÍCIO 11: Gerenciamento de senhas"
echo "--------------------------------------"
echo "🔧 Comando: Verificando status das senhas"
echo ""
Verificando status das senhas
passwd -S joao.ti
passwd -S maria.fin
passwd -S pedro.rh
echo ""

echo "🔧 Comando: Bloqueando conta do pedro.rh temporariamente"
echo ""
Bloqueando conta do pedro.rh temporariamente
passwd -l pedro.rh
passwd -S pedro.rh
echo ""

echo "🔧 Comando: Desbloqueando conta do pedro.rh"
echo ""
Desbloqueando conta do pedro.rh
passwd -u pedro.rh
passwd -S pedro.rh
echo ""

# Exercício 12: Limpeza (opcional)
echo "📝 EXERCÍCIO 12: Limpeza (opcional)"
echo "---------------------------------"
echo "⚠️  ATENÇÃO: Os usuários e grupos criados serão mantidos no sistema."
echo "Se desejar removê-los, execute os comandos abaixo manualmente:"
echo ""
echo "# Remover usuários:"
echo "userdel -r joao.ti"
echo "userdel -r maria.fin"
echo "userdel -r pedro.rh"
echo ""
echo "# Remover grupos:"
echo "groupdel ti"
echo "groupdel financeiro"
echo "groupdel rh"
echo "groupdel administradores"
echo "groupdel contadores"
echo ""

echo "🎯 RESUMO DOS COMANDOS APRENDIDOS:"
echo "• useradd -m -s /bin/bash usuario    - Criar usuário"
echo "• groupadd grupo                     - Criar grupo"
echo "• passwd usuario                     - Alterar senha"
echo "• usermod -a -G grupo usuario        - Adicionar ao grupo"
echo "• usermod -s /bin/zsh usuario        - Alterar shell"
echo "• usermod -c 'comentário' usuario    - Adicionar comentário"
echo "• passwd -l usuario                  - Bloquear conta"
echo "• passwd -u usuario                  - Desbloquear conta"
echo "• id usuario                         - Informações do usuário"
echo "• groups usuario                      - Grupos do usuário"
echo "• getent passwd usuario              - Dados completos"
echo ""

echo "✅ Exercício de usuários e grupos concluído!"
echo "========================================"
