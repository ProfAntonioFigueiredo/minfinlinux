# 🏦 PROJETO DIMDIM BANK - EXERCÍCIOS PRÁTICOS
## Treinamento Linux - Ministério das Finanças de Angola

---

## 📋 **INFORMAÇÕES GERAIS**

Este conjunto de exercícios práticos simula a administração de um sistema bancário fictício chamado **DimDim Bank**, permitindo aos alunos praticarem comandos Linux essenciais em um contexto realista e profissional.

### **Objetivos dos Exercícios:**
- Praticar comandos básicos de navegação e manipulação de arquivos
- Trabalhar com estrutura de diretórios complexa
- Aprender comandos de busca e filtragem
- Monitorar processos e uso do sistema
- Gerenciar logs e arquivos de sistema

---

## 📁 **ESTRUTURA DOS EXERCÍCIOS**

### **Exercício 1 (Slide 11):** Configuração Inicial
- **Arquivo:** `exercicio_01_configuracao_inicial.sh`
- **Descrição:** Criação do diretório principal e navegação básica

### **Exercício 2 (Slide 12):** Estrutura de Diretórios
- **Arquivo:** `exercicio_02_estrutura_diretorios.sh`
- **Descrição:** Criação da estrutura organizacional do banco

### **Exercício 3 (Slide 13):** Criação de Arquivos e Dados
- **Arquivo:** `exercicio_03_criacao_arquivos_dados.sh`
- **Descrição:** Criação de arquivos de clientes e transações

### **Exercício 4 (Slide 14):** Visualização e Backup
- **Arquivo:** `exercicio_04_visualizacao_backup.sh`
- **Descrição:** Visualização de conteúdo e operações de backup

### **Exercício 5 (Slide 15):** Manipulação de Dados
- **Arquivo:** `exercicio_05_manipulacao_dados.sh`
- **Descrição:** Adição de dados e operações de arquivo

### **Exercício 6 (Slide 16):** Listagem Detalhada
- **Arquivo:** `exercicio_06_listagem_detalhada.sh`
- **Descrição:** Comandos avançados de listagem

### **Exercício 7 (Slide 18):** Gerenciamento de Logs
- **Arquivo:** `exercicio_07_gerenciamento_logs.sh`
- **Descrição:** Criação e gerenciamento de arquivos de log

### **Exercício 8 (Slide 19):** Logs de Sistema e API
- **Arquivo:** `exercicio_08_logs_sistema_api.sh`
- **Descrição:** Logs de transações e erros do sistema

### **Exercício 9 (Slide 20):** Busca e Filtragem
- **Arquivo:** `exercicio_09_busca_filtragem.sh`
- **Descrição:** Comandos find e grep para busca de dados

### **Exercício 10 (Slide 21):** Monitoramento de Disco
- **Arquivo:** `exercicio_10_monitoramento_disco.sh`
- **Descrição:** Verificação de uso de espaço em disco

### **Exercício 11 (Slide 22):** Monitoramento de Processos
- **Arquivo:** `exercicio_11_monitoramento_processos.sh`
- **Descrição:** Gerenciamento e monitoramento de processos

### **Exercício 12 (Slide 23):** Limpeza Final
- **Arquivo:** `exercicio_12_limpeza_final.sh`
- **Descrição:** Remoção completa do ambiente de teste

### **Exercícios Complementares do Módulo 1:**

### **Exercício Permissões:** Permissões de Arquivos e Diretórios
- **Arquivo:** `exercicio_permissoes_arquivos.sh`
- **Descrição:** Comandos chmod, chown, chgrp, notação simbólica e numérica

### **Exercício Usuários:** Gestão de Usuários e Grupos
- **Arquivo:** `exercicio_usuarios_grupos.sh`
- **Descrição:** Criação de usuários, grupos, comandos useradd, groupadd, usermod

### **Exercício Processos:** Processos e Serviços
- **Arquivo:** `exercicio_processos_servicos.sh`
- **Descrição:** Comandos ps, top, kill, systemd, systemctl, journalctl

---

## 🚀 **COMO EXECUTAR OS EXERCÍCIOS**

### **Método 1: Execução Individual**
```bash
# Tornar o script executável
chmod +x exercicio_XX_nome.sh

# Executar o script
./exercicio_XX_nome.sh
```

### **Método 2: Execução Sequencial**
```bash
# Executar todos os exercícios em sequência
for i in {01..12}; do
    echo "Executando Exercício $i..."
    chmod +x exercicio_${i}_*.sh
    ./exercicio_${i}_*.sh
    echo "Exercício $i concluído!"
    echo "---"
done
```

### **Método 3: Execução Manual**
```bash
# Copiar e colar os comandos diretamente no terminal
# Cada script contém comentários explicativos
```

---

## 📚 **COMANDOS APRENDIDOS**

### **Navegação e Diretórios:**
- `pwd` - Mostrar diretório atual
- `mkdir` - Criar diretórios
- `cd` - Navegar entre diretórios
- `ls` - Listar arquivos e diretórios

### **Manipulação de Arquivos:**
- `touch` - Criar arquivos vazios
- `echo` - Criar conteúdo em arquivos
- `cat` - Visualizar conteúdo de arquivos
- `cp` - Copiar arquivos
- `mv` - Mover/renomear arquivos
- `rm` - Remover arquivos

### **Busca e Filtragem:**
- `find` - Buscar arquivos e diretórios
- `grep` - Buscar conteúdo em arquivos
- `tail` - Mostrar últimas linhas de arquivo

### **Monitoramento:**
- `df` - Verificar uso de disco
- `ps` - Listar processos
- `top` - Monitorar processos em tempo real

---

## ⚠️ **IMPORTANTE**

- **Execute os exercícios em sequência** para manter a continuidade do projeto
- **Leia os comentários** em cada script antes da execução
- **Verifique os resultados** após cada comando
- **Use o exercício 12** para limpar o ambiente após os testes

---

**Desenvolvido para o Treinamento Linux - Ministério das Finanças de Angola - 2025**
