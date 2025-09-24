# 🔄 SISTEMA DE SINCRONIZAÇÃO DE PROJETOS

## 📋 Visão Geral

Este documento explica como manter os dois projetos sempre sincronizados:

1. **Projeto Principal** (`LinuxAvançado`) - Repositório completo com todos os módulos
2. **WiseLearning** (`wiselearning`) - Plataforma frontend dedicada

## 🚀 Scripts de Sincronização

### 1. Script Principal de Sincronização
```bash
./scripts/sincronizar_projetos.sh [comando]
```

**Comandos disponíveis:**
- `sync` - Sincronização bidirecional (padrão)
- `to-wiselearning` - Sincronizar apenas para WiseLearning
- `from-wiselearning` - Sincronizar apenas do WiseLearning
- `status` - Verificar status dos repositórios
- `setup` - Configurar repositórios
- `help` - Mostrar ajuda

### 2. Script de Desenvolvimento
```bash
./scripts/desenvolver_plataforma.sh [comando]
```

**Comandos disponíveis:**
- `start` - Iniciar servidor de desenvolvimento
- `sync` - Sincronizar mudanças
- `status` - Verificar status
- `commit [mensagem]` - Commit rápido com sincronização
- `open` - Abrir no navegador
- `watch` - Monitorar arquivos automaticamente
- `clear-cache` - Limpar cache do navegador

## 📁 Estrutura dos Projetos

### Projeto Principal (LinuxAvançado)
```
LinuxAvançado/
├── plataforma/           # Plataforma frontend
│   ├── index.html
│   ├── assets/
│   ├── modulos/
│   └── exercicios/
├── modulos/             # Conteúdo modular
│   ├── modulo1_fundamentos_linux/
│   ├── modulo2_redes_seguranca/
│   └── ...
├── scripts/             # Scripts de automação
└── exercicios/          # Exercícios práticos
```

### WiseLearning
```
wiselearning/
├── index.html           # Página principal
├── assets/              # CSS e JavaScript
├── modulos/             # Apresentações
├── exercicios/          # Scripts práticos
└── README.md            # Documentação
```

## 🔧 Fluxo de Trabalho Recomendado

### 1. Desenvolvimento Diário
```bash
# Iniciar servidor de desenvolvimento
./scripts/desenvolver_plataforma.sh start

# Em outro terminal, monitorar mudanças
./scripts/desenvolver_plataforma.sh watch
```

### 2. Fazer Mudanças
1. Editar arquivos na pasta `plataforma/`
2. Testar localmente em `http://localhost:8000`
3. As mudanças são sincronizadas automaticamente

### 3. Commit e Push
```bash
# Commit rápido com sincronização automática
./scripts/desenvolver_plataforma.sh commit "feat: nova funcionalidade"

# Ou sincronização manual
./scripts/sincronizar_projetos.sh sync
```

## 🌐 Repositórios

### Repositório Principal
- **URL:** `https://ProfAntonioFigueiredo@dev.azure.com/ProfAntonioFigueiredo/MinFIN%20-%20DevOps/_git/LinuxAvançado`
- **Conteúdo:** Projeto completo com todos os módulos
- **Uso:** Desenvolvimento principal e backup

### Repositório WiseLearning
- **URL:** `https://ProfAntonioFigueiredo@dev.azure.com/ProfAntonioFigueiredo/MinFIN%20-%20DevOps/_git/wiselearning`
- **Conteúdo:** Apenas a plataforma frontend
- **Uso:** Deploy e distribuição

## ⚠️ Importante

### Sempre Sincronizar
- **Antes de fazer mudanças:** Execute `./scripts/sincronizar_projetos.sh status`
- **Após fazer mudanças:** Execute `./scripts/sincronizar_projetos.sh sync`
- **Antes de fazer commit:** Verifique se ambos os projetos estão sincronizados

### Backup Automático
- O script cria backups automáticos antes de fazer mudanças
- Arquivos de backup têm extensão `.backup`
- Sempre verifique se o backup foi criado antes de prosseguir

## 🐛 Solução de Problemas

### Problema: Mudanças não aparecem no navegador
```bash
# Limpar cache do navegador
./scripts/desenvolver_plataforma.sh clear-cache

# Recarregar página com Ctrl+F5
```

### Problema: Conflitos de sincronização
```bash
# Verificar status
./scripts/sincronizar_projetos.sh status

# Resolver conflitos manualmente
git status
git add .
git commit -m "resolve: conflitos de sincronização"
```

### Problema: Servidor não inicia
```bash
# Parar processos existentes
pkill -f "python3 -m http.server"

# Iniciar novamente
./scripts/desenvolver_plataforma.sh start
```

## 📊 Monitoramento

### Verificar Status
```bash
# Status completo
./scripts/sincronizar_projetos.sh status

# Status do desenvolvimento
./scripts/desenvolver_plataforma.sh status
```

### Logs de Sincronização
- Os scripts mostram logs coloridos para facilitar o acompanhamento
- Verde: Sucesso
- Amarelo: Aviso
- Vermelho: Erro
- Azul: Informação

## 🎯 Dicas de Desenvolvimento

1. **Sempre teste localmente** antes de fazer commit
2. **Use o monitoramento automático** para desenvolvimento ativo
3. **Faça commits frequentes** com mensagens descritivas
4. **Mantenha ambos os repositórios sincronizados**
5. **Use o script de desenvolvimento** para facilitar o trabalho

## 📞 Suporte

Se encontrar problemas:
1. Verifique os logs coloridos dos scripts
2. Execute `./scripts/sincronizar_projetos.sh status`
3. Verifique se os repositórios estão configurados corretamente
4. Consulte este documento para soluções comuns

---
**Desenvolvido para o Ministério das Finanças de Angola - 2025**
