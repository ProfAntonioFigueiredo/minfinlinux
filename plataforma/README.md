# 🐧 Plataforma de Treinamento Linux - MINFIN Angola

## 📋 Visão Geral

Esta é uma plataforma web moderna e responsiva desenvolvida para o treinamento Linux do Ministério das Finanças de Angola. A plataforma oferece uma experiência completa de aprendizado com apresentações interativas, exercícios práticos e recursos educacionais.

## ✨ Características Principais

### 🎨 **Interface Moderna e Responsiva**
- Design responsivo que se adapta a qualquer tamanho de tela
- Tema claro/escuro com alternância automática
- Interface intuitiva e fácil de navegar
- Suporte a tela cheia para melhor experiência

### 📚 **Conteúdo Estruturado**
- 6 módulos completos de treinamento
- Apresentações HTML interativas
- Exercícios práticos com scripts executáveis
- Recursos complementares e documentação

### 🛠️ **Funcionalidades Avançadas**
- Terminal Linux simulado
- Copiar código com um clique
- Download de scripts e materiais
- Sistema de progresso e estatísticas
- Notas pessoais e favoritos
- Cache inteligente para melhor performance

### 🎯 **Foco Prático**
- 60% prático - 40% teórico
- Exercícios hands-on em Ubuntu 24.04 LTS
- Casos reais do Ministério das Finanças
- Ambiente de terminal integrado

## 🚀 Como Usar

### **Instalação Local**
1. Clone o repositório:
   ```bash
   git clone https://ProfAntonioFigueiredo@dev.azure.com/ProfAntonioFigueiredo/MinFIN%20-%20DevOps/_git/LinuxAvan%C3%A7ado
   ```

2. Navegue para a pasta da plataforma:
   ```bash
   cd LinuxAvançado/plataforma
   ```

3. Abra o arquivo `index.html` no navegador:
   ```bash
   # Linux/Mac
   open index.html
   
   # Windows
   start index.html
   ```

### **Servidor Local (Recomendado)**
Para melhor experiência, use um servidor local:

```bash
# Python 3
python -m http.server 8000

# Node.js (se tiver http-server instalado)
npx http-server -p 8000

# PHP
php -S localhost:8000
```

Acesse: `http://localhost:8000`

## 📁 Estrutura do Projeto

```
plataforma/
├── index.html                 # Página principal
├── assets/
│   ├── css/
│   │   ├── main.css          # Estilos principais
│   │   └── responsive.css    # Estilos responsivos
│   └── js/
│       ├── main.js           # JavaScript principal
│       ├── modules.js        # Gerenciamento de módulos
│       ├── exercises.js      # Gerenciamento de exercícios
│       └── utils.js          # Utilitários avançados
├── README.md                 # Este arquivo
└── ../modulos/              # Conteúdo dos módulos (link simbólico)
```

## 🎓 Módulos Disponíveis

### **Módulo 1: Fundamentos Linux**
- Introdução ao Linux
- Permissões de arquivos e diretórios
- Gestão de usuários e grupos
- Processos e serviços

### **Módulo 2: Redes e Segurança**
- Modelos OSI e TCP/IP
- Endereçamento IP e Subnetting
- Roteamento básico
- Segurança da informação

### **Módulos 3-6: Em Desenvolvimento**
- Administração de Redes
- Administração de Sistemas
- Segurança de Redes
- Observabilidade

## 🛠️ Tecnologias Utilizadas

- **HTML5** - Estrutura semântica
- **CSS3** - Estilos modernos com Grid e Flexbox
- **JavaScript ES6+** - Funcionalidades interativas
- **Font Awesome** - Ícones
- **Google Fonts** - Tipografia (Inter)

## 📱 Compatibilidade

### **Navegadores Suportados**
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

### **Dispositivos**
- Desktop (1920x1080+)
- Laptop (1366x768+)
- Tablet (768x1024+)
- Mobile (375x667+)

## 🎨 Personalização

### **Temas**
A plataforma suporta temas claro e escuro. O tema é salvo automaticamente no navegador.

### **Configurações**
As configurações são salvas localmente e incluem:
- Tema preferido
- Progresso do curso
- Notas pessoais
- Favoritos
- Estatísticas de estudo

## 📊 Funcionalidades Avançadas

### **Sistema de Progresso**
- Acompanhamento por módulo
- Estatísticas de tempo de estudo
- Exercícios completados
- Pontuação por exercício

### **Terminal Simulado**
- Terminal Linux virtual
- Comandos básicos simulados
- Interface realística
- Histórico de comandos

### **Gerenciamento de Código**
- Copiar código com um clique
- Download de scripts
- Syntax highlighting
- Formatação automática

## 🔧 Desenvolvimento

### **Estrutura de Módulos**
Para adicionar novos módulos, edite o arquivo `assets/js/main.js` e adicione o módulo ao objeto `AppState.modules`.

### **Adicionar Exercícios**
1. Crie o arquivo do exercício na pasta `../modulos/moduloX/exercicios/`
2. Adicione o exercício ao objeto `AppState.modules[moduleId].exercises`
3. O sistema carregará automaticamente o exercício

### **Personalizar Estilos**
- Edite `assets/css/main.css` para estilos principais
- Edite `assets/css/responsive.css` para responsividade
- Use variáveis CSS para cores e espaçamentos

## 🐛 Solução de Problemas

### **Problemas Comuns**

1. **Conteúdo não carrega**
   - Verifique se está usando um servidor local
   - Confirme que os arquivos dos módulos existem

2. **Estilos não aplicam**
   - Limpe o cache do navegador
   - Verifique se os arquivos CSS estão carregando

3. **JavaScript não funciona**
   - Abra o console do navegador (F12)
   - Verifique se há erros JavaScript

### **Logs de Erro**
A plataforma registra erros automaticamente. Para visualizar:
```javascript
console.log(Utils.error.getLog());
```

## 📈 Performance

### **Otimizações Implementadas**
- Lazy loading de conteúdo
- Cache inteligente
- Debounce em eventos
- Throttle em scroll
- Compressão de imagens

### **Métricas**
- Tempo de carregamento: < 2s
- Tamanho total: < 1MB
- Compatibilidade: 95%+ navegadores

## 🤝 Contribuição

### **Como Contribuir**
1. Faça um fork do projeto
2. Crie uma branch para sua feature
3. Faça commit das mudanças
4. Abra um Pull Request

### **Padrões de Código**
- Use ESLint para JavaScript
- Siga as convenções de CSS
- Documente funções complexas
- Teste em múltiplos navegadores

## 📄 Licença

Este projeto é propriedade do Ministério das Finanças de Angola e é destinado exclusivamente para fins educacionais.

## 📞 Suporte

Para suporte técnico ou dúvidas:
- Email: suporte@minfin.gov.ao
- Telefone: +244 XXX XXX XXX
- Horário: Segunda a Sexta, 8h às 17h

## 🔄 Atualizações

### **Versão Atual: 1.0.0**
- Interface inicial
- Módulos 1 e 2 completos
- Sistema de exercícios
- Terminal simulado

### **Próximas Versões**
- Módulos 3-6
- Sistema de avaliação
- Certificados digitais
- Integração com LMS

---

**Desenvolvido com ❤️ para o Ministério das Finanças de Angola - 2025**
