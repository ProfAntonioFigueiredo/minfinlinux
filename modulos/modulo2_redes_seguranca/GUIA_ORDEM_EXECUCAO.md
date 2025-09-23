# 📋 GUIA DE ORDEM DE EXECUÇÃO - MÓDULO 2
## Fundamentos de Redes e Segurança - MINFIN Angola

---

## 🎯 **ORIENTAÇÕES GERAIS**

Este guia define a **ordem recomendada** para executar as apresentações e exercícios do Módulo 2, garantindo uma progressão lógica e eficaz do aprendizado em redes e segurança.

---

## 📚 **SEQUÊNCIA DAS APRESENTAÇÕES**

### **1️⃣ Modelos OSI e TCP/IP**
- **Arquivo:** `modulo2_modelos_osi_tcpip.html`
- **Duração:** 1.5 horas
- **Conteúdo:** Comparação entre modelos, 7 camadas OSI, 4 camadas TCP/IP, fluxo de dados
- **Objetivo:** Compreender fundamentos teóricos de redes

### **2️⃣ Endereçamento IP e Subnetting**
- **Arquivo:** `modulo2_enderecamento_ip_subnetting.html`
- **Duração:** 2 horas
- **Conteúdo:** IPv4 vs IPv6, classes, notação CIDR, cálculo de sub-redes
- **Objetivo:** Dominar endereçamento e divisão de redes

### **3️⃣ Roteamento Básico**
- **Arquivo:** `modulo2_roteamento_basico.html`
- **Duração:** 1 hora
- **Conteúdo:** Tipos de roteamento, tabela de roteamento, protocolos, troubleshooting
- **Objetivo:** Entender funcionamento do roteamento

### **4️⃣ Segurança da Informação**
- **Arquivo:** `modulo2_seguranca_informacao.html`
- **Duração:** 1.5 horas
- **Conteúdo:** Triade CIA, ameaças, controles, políticas, auditoria
- **Objetivo:** Estabelecer fundamentos de segurança

---

## 🧪 **SEQUÊNCIA DOS EXERCÍCIOS**

### **FASE 1: Cálculo de Sub-redes (Fundamentos de Redes)**
**Duração Total:** 2 horas

#### **1️⃣ Cálculo de Sub-redes**
- **Arquivo:** `exercicio_calculo_subredes.sh`
- **Duração:** 2 horas
- **Objetivo:** Prática intensiva de cálculo de sub-redes
- **Requisito:** Apresentação de Endereçamento IP e Subnetting
- **Conteúdo:**
  - Conversão decimal para binário
  - Cálculo de sub-redes com CIDR
  - Cenários empresariais
  - Configuração prática de rede

### **FASE 2: Controles de Acesso (Segurança)**
**Duração Total:** 2 horas

#### **2️⃣ Controles de Acesso**
- **Arquivo:** `exercicio_controles_acesso.sh`
- **Duração:** 2 horas
- **Objetivo:** Implementar controles de segurança completos
- **Requisito:** Apresentação de Segurança da Informação
- **Conteúdo:**
  - Políticas de senhas seguras
  - Grupos departamentais
  - Auditoria de atividades
  - Monitoramento de segurança
  - Backup de configurações

### **FASE 3: Cenários Práticos (Integração)**
**Duração Total:** 2 horas

#### **3️⃣ Cenários Práticos**
- **Arquivo:** `exercicio_cenarios_praticos.sh`
- **Duração:** 2 horas
- **Objetivo:** Integrar conceitos de redes e segurança
- **Requisito:** Todas as apresentações
- **Conteúdo:**
  - Diagnóstico de problemas de conectividade
  - Configuração de rede para departamentos
  - Implementação de firewall básico
  - Monitoramento de segurança
  - Resposta a incidentes
  - Teste de penetração básico
  - Simulação de ataque DDoS
  - Geração de relatório de segurança

---

## ⏰ **CRONOGRAMA SUGERIDO (6 HORAS)**

### **MANHÃ (3 horas)**
- **08:00 - 09:30:** Apresentação OSI/TCP-IP + Endereçamento IP
- **09:30 - 09:45:** Intervalo
- **09:45 - 11:45:** Exercício de Cálculo de Sub-redes

### **TARDE (3 horas)**
- **14:00 - 15:30:** Apresentações Roteamento + Segurança
- **15:30 - 15:45:** Intervalo
- **15:45 - 17:45:** Exercícios Controles de Acesso + Cenários Práticos

---

## 🚀 **EXECUÇÃO RÁPIDA**

### **Para Executar Todos os Exercícios em Sequência:**
```bash
# Dar permissão de execução
chmod +x exercicio_*.sh

# Executar exercício de cálculo de sub-redes
./exercicio_calculo_subredes.sh

# Executar exercício de controles de acesso (requer sudo)
sudo ./exercicio_controles_acesso.sh

# Executar cenários práticos
./exercicio_cenarios_praticos.sh
```

### **Para Executar Exercícios Individuais:**
```bash
# Cálculo de sub-redes (sem privilégios especiais)
./exercicio_calculo_subredes.sh

# Controles de acesso (requer privilégios de root)
sudo ./exercicio_controles_acesso.sh

# Cenários práticos (sem privilégios especiais)
./exercicio_cenarios_praticos.sh
```

---

## 📊 **CHECKLIST DE PROGRESSO**

### **Apresentações:**
- [ ] Modelos OSI e TCP/IP
- [ ] Endereçamento IP e Subnetting
- [ ] Roteamento Básico
- [ ] Segurança da Informação

### **Exercícios:**
- [ ] Cálculo de Sub-redes
- [ ] Controles de Acesso
- [ ] Cenários Práticos

---

## 🎯 **MAPEAMENTO APRESENTAÇÃO ↔ EXERCÍCIO**

### **Apresentação → Exercício Correspondente:**
- **OSI/TCP-IP** → Cenários Práticos (diagnóstico de rede)
- **Endereçamento IP** → Cálculo de Sub-redes
- **Roteamento** → Cenários Práticos (configuração de rede)
- **Segurança** → Controles de Acesso + Cenários Práticos

---

## 💡 **DICAS PARA PROFESSORES**

1. **Execute** as apresentações na ordem recomendada
2. **Demonstre** cálculos de sub-redes na prática
3. **Supervisione** a execução dos exercícios
4. **Adapte** o tempo conforme o ritmo da turma
5. **Use** os cenários práticos para integração de conceitos
6. **Enfatize** a importância da segurança em redes

---

## 🎯 **DICAS PARA ALUNOS**

1. **Siga a ordem** das apresentações para melhor compreensão
2. **Pratique** os cálculos de sub-redes até dominar
3. **Execute** os exercícios após cada apresentação
4. **Leia** os comentários nos scripts
5. **Experimente** os cenários práticos
6. **Consulte** a documentação quando necessário

---

## ⚠️ **OBSERVAÇÕES IMPORTANTES**

### **Privilégios Necessários:**
- **Cálculo de Sub-redes:** Nenhum privilégio especial
- **Controles de Acesso:** Requer sudo/root
- **Cenários Práticos:** Nenhum privilégio especial

### **Dependências:**
- **ipcalc:** Para cálculos de sub-rede (opcional)
- **auditd:** Para auditoria de segurança
- **libpam-pwquality:** Para políticas de senhas

### **Ambiente Recomendado:**
- **Sistema:** Linux (Ubuntu/Debian/CentOS)
- **Usuário:** Com acesso sudo para exercícios de segurança
- **Rede:** Ambiente isolado para testes

---

## 🔗 **RECURSOS COMPLEMENTARES**

### **Ferramentas Úteis:**
- **ipcalc:** Calculadora de sub-redes
- **nmap:** Scanner de rede
- **tcpdump:** Análise de tráfego
- **wireshark:** Análise de protocolos

### **Documentação:**
- **RFCs:** Documentos técnicos de protocolos
- **Manuais:** `man comando` para ajuda
- **Logs:** `/var/log/` para análise de eventos

---

**Desenvolvido para o Treinamento Linux - Ministério das Finanças de Angola - 2025**
