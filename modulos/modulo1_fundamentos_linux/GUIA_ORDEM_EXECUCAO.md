# 📋 GUIA DE ORDEM DE EXECUÇÃO - MÓDULO 1
## Fundamentos de Linux - MINFIN Angola

---

## 🎯 **ORIENTAÇÕES GERAIS**

Este guia define a **ordem recomendada** para executar as apresentações e exercícios do Módulo 1, garantindo uma progressão lógica e eficaz do aprendizado.

---

## 📚 **SEQUÊNCIA DAS APRESENTAÇÕES**

### **1️⃣ Apresentação Principal (Teoria Geral)**
- **Arquivo:** `modulo1_introducao_linux.html`
- **Duração:** 2 horas
- **Conteúdo:** História do Linux, distribuições, estrutura de diretórios, comandos básicos
- **Objetivo:** Estabelecer base teórica sólida

### **2️⃣ Permissões de Arquivos e Diretórios**
- **Arquivo:** `modulo1_permissoes_arquivos.html`
- **Duração:** 1.5 horas
- **Conteúdo:** chmod, chown, chgrp, notação simbólica e numérica
- **Objetivo:** Dominar controle de acesso a arquivos

### **3️⃣ Gestão de Usuários e Grupos**
- **Arquivo:** `modulo1_gestao_usuarios_grupos.html`
- **Duração:** 1.5 horas
- **Conteúdo:** useradd, groupadd, usermod, passwd, cenários empresariais
- **Objetivo:** Administrar usuários e grupos eficientemente

### **4️⃣ Processos e Serviços**
- **Arquivo:** `modulo1_processos_servicos.html`
- **Duração:** 1 hora
- **Conteúdo:** ps, top, kill, systemd, systemctl, journalctl
- **Objetivo:** Monitorar e gerenciar processos

---

## 🧪 **SEQUÊNCIA DOS EXERCÍCIOS**

### **FASE 1: Projeto DimDim Bank (Fundamentos)**
**Duração Total:** 3 horas

#### **1️⃣ Configuração Inicial**
- **Arquivo:** `exercicio_01_configuracao_inicial.sh`
- **Duração:** 15 minutos
- **Objetivo:** Criar ambiente de trabalho

#### **2️⃣ Estrutura de Diretórios**
- **Arquivo:** `exercicio_02_estrutura_diretorios.sh`
- **Duração:** 15 minutos
- **Objetivo:** Organizar arquivos e diretórios

#### **3️⃣ Criação de Arquivos de Dados**
- **Arquivo:** `exercicio_03_criacao_arquivos_dados.sh`
- **Duração:** 20 minutos
- **Objetivo:** Manipular arquivos de dados

#### **4️⃣ Visualização e Backup**
- **Arquivo:** `exercicio_04_visualizacao_backup.sh`
- **Duração:** 20 minutos
- **Objetivo:** Operações de backup e movimentação

#### **5️⃣ Manipulação de Dados**
- **Arquivo:** `exercicio_05_manipulacao_dados.sh`
- **Duração:** 20 minutos
- **Objetivo:** Adicionar e remover dados

#### **6️⃣ Listagem Detalhada**
- **Arquivo:** `exercicio_06_listagem_detalhada.sh`
- **Duração:** 15 minutos
- **Objetivo:** Comandos de listagem avançados

#### **7️⃣ Gerenciamento de Logs**
- **Arquivo:** `exercicio_07_gerenciamento_logs.sh`
- **Duração:** 20 minutos
- **Objetivo:** Criar e gerenciar logs

#### **8️⃣ Logs do Sistema e API**
- **Arquivo:** `exercicio_08_logs_sistema_api.sh`
- **Duração:** 20 minutos
- **Objetivo:** Logs de aplicação e busca

#### **9️⃣ Busca e Filtragem**
- **Arquivo:** `exercicio_09_busca_filtragem.sh`
- **Duração:** 20 minutos
- **Objetivo:** Comandos grep e find

#### **🔟 Monitoramento de Disco**
- **Arquivo:** `exercicio_10_monitoramento_disco.sh`
- **Duração:** 15 minutos
- **Objetivo:** Comando df e monitoramento

#### **1️⃣1️⃣ Monitoramento de Processos**
- **Arquivo:** `exercicio_11_monitoramento_processos.sh`
- **Duração:** 15 minutos
- **Objetivo:** Comandos ps e top

#### **1️⃣2️⃣ Limpeza Final**
- **Arquivo:** `exercicio_12_limpeza_final.sh`
- **Duração:** 10 minutos
- **Objetivo:** Limpeza do ambiente

### **FASE 2: Exercícios Complementares (Aprofundamento)**
**Duração Total:** 3 horas

#### **1️⃣ Permissões de Arquivos**
- **Arquivo:** `exercicio_permissoes_arquivos.sh`
- **Duração:** 1 hora
- **Objetivo:** Prática intensiva de permissões
- **Requisito:** Apresentação de permissões

#### **2️⃣ Gestão de Usuários e Grupos**
- **Arquivo:** `exercicio_usuarios_grupos.sh`
- **Duração:** 1 hora
- **Objetivo:** Cenários empresariais de usuários
- **Requisito:** Apresentação de usuários e grupos

#### **3️⃣ Processos e Serviços**
- **Arquivo:** `exercicio_processos_servicos.sh`
- **Duração:** 1 hora
- **Objetivo:** Monitoramento e gerenciamento avançado
- **Requisito:** Apresentação de processos e serviços

---

## ⏰ **CRONOGRAMA SUGERIDO (6 HORAS)**

### **MANHÃ (3 horas)**
- **08:00 - 10:00:** Apresentação Principal + Permissões
- **10:00 - 10:15:** Intervalo
- **10:15 - 11:15:** Exercícios 01-06 (Projeto DimDim Bank)

### **TARDE (3 horas)**
- **14:00 - 15:00:** Apresentações Usuários/Grupos + Processos
- **15:00 - 15:15:** Intervalo
- **15:15 - 17:15:** Exercícios 07-12 + Exercícios Complementares

---

## 🚀 **EXECUÇÃO RÁPIDA**

### **Para Executar Todos os Exercícios em Sequência:**
```bash
# Executar projeto DimDim Bank completo
./executar_todos_exercicios.sh

# Executar exercícios complementares
./exercicio_permissoes_arquivos.sh
./exercicio_usuarios_grupos.sh
./exercicio_processos_servicos.sh
```

### **Para Executar Exercícios Individuais:**
```bash
# Dar permissão de execução
chmod +x exercicio_*.sh

# Executar exercício específico
./exercicio_01_configuracao_inicial.sh
```

---

## 📊 **CHECKLIST DE PROGRESSO**

### **Apresentações:**
- [ ] Introdução ao Linux
- [ ] Permissões de Arquivos
- [ ] Gestão de Usuários e Grupos
- [ ] Processos e Serviços

### **Exercícios DimDim Bank:**
- [ ] Exercício 01: Configuração Inicial
- [ ] Exercício 02: Estrutura de Diretórios
- [ ] Exercício 03: Criação de Arquivos
- [ ] Exercício 04: Visualização e Backup
- [ ] Exercício 05: Manipulação de Dados
- [ ] Exercício 06: Listagem Detalhada
- [ ] Exercício 07: Gerenciamento de Logs
- [ ] Exercício 08: Logs do Sistema
- [ ] Exercício 09: Busca e Filtragem
- [ ] Exercício 10: Monitoramento de Disco
- [ ] Exercício 11: Monitoramento de Processos
- [ ] Exercício 12: Limpeza Final

### **Exercícios Complementares:**
- [ ] Permissões de Arquivos
- [ ] Usuários e Grupos
- [ ] Processos e Serviços

---

## 💡 **DICAS PARA PROFESSORES**

1. **Sempre execute** as apresentações antes dos exercícios correspondentes
2. **Demonstre** os comandos na prática durante as apresentações
3. **Supervisione** a execução dos exercícios pelos alunos
4. **Adapte** o tempo conforme o ritmo da turma
5. **Use** os exercícios complementares para reforçar conceitos

---

## 🎯 **DICAS PARA ALUNOS**

1. **Siga a ordem** recomendada para melhor compreensão
2. **Execute** os exercícios após cada apresentação
3. **Leia** os comentários nos scripts para entender o que está sendo feito
4. **Pratique** os comandos aprendidos
5. **Consulte** a documentação quando necessário

---

**Desenvolvido para o Treinamento Linux - Ministério das Finanças de Angola - 2025**
