#!/bin/bash

# =============================================================================
# EXERCÍCIO: PERMISSÕES DE ARQUIVOS E DIRETÓRIOS
# Módulo 1 - Treinamento Linux MINFIN Angola
# Ubuntu 24.04 LTS (Noble Numbat) - Comandos otimizados
# =============================================================================

echo "🔐 EXERCÍCIO: PERMISSÕES DE ARQUIVOS E DIRETÓRIOS"
echo "================================================"
echo ""

# Verificar se temos privilégios adequados
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  Executando como root. Cuidado com as permissões!"
else
    echo "✅ Executando como usuário normal. Alguns comandos podem precisar de sudo."
fi

echo "📍 Diretório atual: $(pwd)"
echo ""

# Criar diretório de trabalho
echo "📁 Comando: Criando diretório de trabalho para exercícios de permissões"
echo "📁 Criando diretório de trabalho para exercícios de permissões:"
mkdir -p exercicios_permissoes
cd exercicios_permissoes
echo "✅ Diretório criado: $(pwd)"
echo ""

# Exercício 1: Criar arquivos e verificar permissões padrão
echo "📝 EXERCÍCIO 1: Verificando permissões padrão"
echo "--------------------------------------------"
echo ""

echo "🔧 Comando: touch arquivo_teste.txt"
touch arquivo_teste.txt
echo ""

echo "🔧 Comando: mkdir diretorio_teste"
mkdir diretorio_teste
echo ""

echo "🔧 Comando: echo 'Conteúdo de teste' > arquivo_teste.txt"
echo "Conteúdo de teste" > arquivo_teste.txt
echo ""

echo "📋 Comando: ls -l arquivo_teste.txt"
echo "📋 Comando: Permissões do arquivo"
echo "📋 Permissões do arquivo:"
ls -l arquivo_teste.txt
echo ""

echo "📋 Comando: ls -ld diretorio_teste"
echo "📋 Comando: Permissões do diretório"
echo "📋 Permissões do diretório:"
ls -ld diretorio_teste
echo ""

# Exercício 2: Alterar permissões usando notação simbólica
echo "📝 EXERCÍCIO 2: Alterando permissões com notação simbólica"
echo "--------------------------------------------------------"
echo "🔧 Comando: Adicionando execução para o usuário"
echo ""
Adicionando execução para o usuário
chmod u+x arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

echo "🔧 Comando: Removendo escrita do grupo"
echo ""
Removendo escrita do grupo
chmod g-w arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

echo "🔧 Comando: Adicionando leitura para outros"
echo ""
Adicionando leitura para outros
chmod o+r arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

echo "🔧 Comando: Definindo permissões específicas"
echo ""
Definindo permissões específicas
chmod u=rwx,g=rx,o=r arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

# Exercício 3: Alterar permissões usando notação numérica
echo "📝 EXERCÍCIO 3: Alterando permissões com notação numérica"
echo "-------------------------------------------------------"
echo "🔧 Comando: Permissões 755 (rwxr-xr-x)"
echo ""
Permissões 755 (rwxr-xr-x)
chmod 755 arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

echo "🔧 Comando: Permissões 644 (rw-r--r--)"
echo ""
Permissões 644 (rw-r--r--)
chmod 644 arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

echo "🔧 Comando: Permissões 600 (rw-------)"
echo ""
Permissões 600 (rw-------)
chmod 600 arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

echo "🔧 Comando: Permissões 777 (rwxrwxrwx)"
echo ""
Permissões 777 (rwxrwxrwx)
chmod 777 arquivo_teste.txt
ls -l arquivo_teste.txt
echo ""

# Exercício 4: Trabalhar com diretórios
echo "📝 EXERCÍCIO 4: Permissões de diretórios"
echo "--------------------------------------"
echo "🔧 Comando: Permissões 755 no diretório"
echo ""
Permissões 755 no diretório
chmod 755 diretorio_teste
ls -ld diretorio_teste
echo ""

echo "🔧 Comando: Permissões 700 no diretório"
echo ""
Permissões 700 no diretório
chmod 700 diretorio_teste
ls -ld diretorio_teste
echo ""

# Exercício 5: Aplicar permissões recursivamente
echo "📝 EXERCÍCIO 5: Permissões recursivas"
echo "-----------------------------------"
echo "🔧 Comando: Criando estrutura de diretórios"
echo ""
Criando estrutura de diretórios
mkdir -p subdir1/subdir2
touch subdir1/arquivo1.txt
touch subdir1/subdir2/arquivo2.txt
echo "Conteúdo 1" > subdir1/arquivo1.txt
echo "Conteúdo 2" > subdir1/subdir2/arquivo2.txt

echo "📋 Comando: Estrutura antes da alteração"
echo "📋 Estrutura antes da alteração:"
find . -type f -exec ls -l {} \;
echo ""

echo "🔧 Comando: Aplicando permissões 644 recursivamente"
echo ""
Aplicando permissões 644 recursivamente
chmod -R 644 subdir1
find . -type f -exec ls -l {} \;
echo ""

# Exercício 6: Comandos de verificação
echo "📝 EXERCÍCIO 6: Comandos de verificação"
echo "-------------------------------------"
echo "📋 Comando: Informações detalhadas com stat"
echo "📋 Informações detalhadas com stat:"
stat arquivo_teste.txt
echo ""

echo "📋 Comando: Verificando permissões de todos os arquivos"
echo "📋 Verificando permissões de todos os arquivos:"
find . -type f -exec ls -l {} \;
echo ""

echo "📋 Comando: Verificando permissões de todos os diretórios"
echo "📋 Verificando permissões de todos os diretórios:"
find . -type d -exec ls -ld {} \;
echo ""

# Exercício 7: Cenário prático
echo "📝 EXERCÍCIO 7: Cenário prático - Arquivos sensíveis"
echo "--------------------------------------------------"
echo "🔧 Comando: Criando arquivo com dados sensíveis"
echo ""
Criando arquivo com dados sensíveis
echo "Dados confidenciais do banco" > dados_sensiveis.txt
chmod 600 dados_sensiveis.txt
ls -l dados_sensiveis.txt
echo ""

echo "🔧 Comando: Criando arquivo público"
echo ""
Criando arquivo público
echo "Informações públicas" > info_publica.txt
chmod 644 info_publica.txt
ls -l info_publica.txt
echo ""

echo "🔧 Comando: Criando script executável"
echo ""
Criando script executável
echo "#!/bin/bash" > script_teste.sh
echo "echo 'Script executado com sucesso!'" >> script_teste.sh
chmod 755 script_teste.sh
ls -l script_teste.sh
echo ""

echo "🧪 Testando execução do script:"
./script_teste.sh
echo ""

# Limpeza
echo "🧹 Limpando arquivos de teste:"
cd ..
rm -rf exercicios_permissoes
echo "✅ Limpeza concluída!"
echo ""

echo "🎯 RESUMO DOS COMANDOS APRENDIDOS:"
echo "• chmod u+x arquivo     - Adiciona execução para usuário"
echo "• chmod g-w arquivo     - Remove escrita do grupo"
echo "• chmod o+r arquivo     - Adiciona leitura para outros"
echo "• chmod 755 arquivo     - Permissões rwxr-xr-x"
echo "• chmod 644 arquivo     - Permissões rw-r--r--"
echo "• chmod 600 arquivo     - Permissões rw-------"
echo "• chmod -R 644 diretorio - Aplica recursivamente"
echo "• ls -l arquivo         - Mostra permissões detalhadas"
echo "• stat arquivo          - Informações completas"
echo ""

echo "✅ Exercício de permissões concluído!"
echo "================================================"
