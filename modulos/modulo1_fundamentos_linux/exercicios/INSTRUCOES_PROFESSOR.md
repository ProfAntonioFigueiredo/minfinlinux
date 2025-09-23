# 👨‍🏫 INSTRUÇÕES PARA O PROFESSOR
## Projeto DimDim Bank - Exercícios Práticos Linux

---

## 📋 **INFORMAÇÕES GERAIS**

Este conjunto de exercícios práticos foi desenvolvido especificamente para o treinamento Linux do Ministério das Finanças de Angola. Os exercícios simulam a administração de um sistema bancário fictício, permitindo aos alunos praticarem comandos Linux essenciais em um contexto realista.

### **Objetivos Pedagógicos:**
- **Aprendizagem Prática:** Comandos Linux através de cenários reais
- **Estrutura Organizacional:** Criação e gerenciamento de diretórios complexos
- **Manipulação de Dados:** Criação, edição e organização de arquivos
- **Monitoramento:** Uso de ferramentas de sistema e logs
- **Busca e Filtragem:** Comandos find e grep para análise de dados

---

## 🎯 **ESTRUTURA DOS EXERCÍCIOS**

### **Exercícios 1-3: Configuração Base**
- **Foco:** Comandos básicos de navegação e criação
- **Comandos:** `pwd`, `mkdir`, `cd`, `touch`, `echo`
- **Duração:** 15-20 minutos

### **Exercícios 4-6: Manipulação Avançada**
- **Foco:** Operações de arquivo e listagem
- **Comandos:** `cat`, `cp`, `mv`, `rm`, `ls -la`
- **Duração:** 20-25 minutos

### **Exercícios 7-9: Logs e Busca**
- **Foco:** Gerenciamento de logs e busca de dados
- **Comandos:** `find`, `grep`, `tail`
- **Duração:** 25-30 minutos

### **Exercícios 10-12: Monitoramento e Limpeza**
- **Foco:** Monitoramento de sistema e limpeza
- **Comandos:** `df`, `du`, `ps`, `top`, `rm -rf`
- **Duração:** 20-25 minutos

---

## 🚀 **COMO USAR EM SALA DE AULA**

### **Método 1: Execução Individual**
```bash
# Para cada exercício
chmod +x exercicio_XX_nome.sh
./exercicio_XX_nome.sh
```

### **Método 2: Execução Sequencial**
```bash
# Executar todos de uma vez
chmod +x executar_todos_exercicios.sh
./executar_todos_exercicios.sh
```

### **Método 3: Demonstração Interativa**
- Execute cada comando manualmente
- Explique cada parâmetro e opção
- Demonstre variações dos comandos
- Responda perguntas dos alunos

---

## 📚 **PONTOS DE ENSINO IMPORTANTES**

### **Comandos Críticos:**
1. **`pwd`** - Sempre verificar localização
2. **`ls -la`** - Listagem detalhada com permissões
3. **`find`** - Busca poderosa de arquivos
4. **`grep`** - Filtragem de conteúdo
5. **`df -h`** - Monitoramento de disco
6. **`ps -aux`** - Monitoramento de processos

### **Conceitos Fundamentais:**
- **Estrutura de Diretórios:** Organização hierárquica
- **Permissões:** Controle de acesso a arquivos
- **Redirecionamento:** `>`, `>>`, `|`
- **Expressões Regulares:** Padrões de busca
- **Monitoramento:** Uso de recursos do sistema

---

## ⚠️ **CUIDADOS E PRECAUÇÕES**

### **Comandos Perigosos:**
- **`rm -rf`** - Remoção recursiva (Exercício 12)
- **`>`** - Sobrescreve arquivos existentes
- **`find`** - Pode afetar muitos arquivos

### **Boas Práticas:**
- Sempre verificar diretório atual com `pwd`
- Usar `ls` antes de operações destrutivas
- Confirmar ações importantes
- Fazer backup antes de operações críticas

---

## 🎓 **AVALIAÇÃO E FEEDBACK**

### **Critérios de Avaliação:**
- **Execução Correta:** Comandos executados sem erro
- **Compreensão:** Explicação do que cada comando faz
- **Aplicação:** Uso correto dos parâmetros
- **Troubleshooting:** Resolução de problemas

### **Perguntas para Discussão:**
1. Qual a diferença entre `>` e `>>`?
2. Como buscar arquivos por tamanho?
3. Qual a diferença entre `ps` e `top`?
4. Como monitorar uso de memória?
5. Qual a importância dos logs de sistema?

---

## 🔧 **CONFIGURAÇÃO DO AMBIENTE**

### **Requisitos Mínimos:**
- **Sistema:** Linux (Ubuntu, CentOS, Debian)
- **Usuário:** Permissões de escrita no diretório home
- **Espaço:** Mínimo 100MB livres
- **Terminal:** Bash ou compatível

### **Verificações Pré-Exercício:**
```bash
# Verificar espaço disponível
df -h

# Verificar permissões
ls -la ~

# Verificar comandos disponíveis
which find grep ps df du
```

---

## 📖 **MATERIAIS DE APOIO**

### **Documentação Linux:**
- **man pages:** `man comando`
- **help:** `comando --help`
- **info:** `info comando`

### **Recursos Online:**
- Linux Documentation Project
- GNU Coreutils Manual
- Bash Reference Manual

### **Comandos de Referência:**
- **Navegação:** `pwd`, `cd`, `ls`
- **Arquivos:** `touch`, `cat`, `cp`, `mv`, `rm`
- **Busca:** `find`, `grep`, `locate`
- **Sistema:** `ps`, `top`, `df`, `du`, `free`

---

## 🎯 **OBJETIVOS DE APRENDIZAGEM**

Ao final dos exercícios, os alunos devem ser capazes de:

✅ **Navegar** eficientemente no sistema de arquivos  
✅ **Criar e gerenciar** estrutura de diretórios  
✅ **Manipular arquivos** com comandos básicos  
✅ **Buscar e filtrar** informações em arquivos  
✅ **Monitorar** uso de recursos do sistema  
✅ **Gerenciar logs** e arquivos de sistema  
✅ **Aplicar** comandos Linux em cenários reais  

---

## 📞 **SUPORTE E DÚVIDAS**

### **Problemas Comuns:**
1. **Permissão negada:** Verificar usuário e permissões
2. **Arquivo não encontrado:** Verificar diretório atual
3. **Comando não encontrado:** Verificar PATH e instalação
4. **Espaço insuficiente:** Verificar com `df -h`

### **Soluções:**
- Usar `sudo` quando necessário
- Verificar com `pwd` e `ls`
- Instalar pacotes necessários
- Limpar espaço em disco

---

**Desenvolvido para o Treinamento Linux - Ministério das Finanças de Angola - 2025**
