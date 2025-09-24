/* =============================================================================
   PLATAFORMA DE TREINAMENTO LINUX - JAVASCRIPT PRINCIPAL
   Ministério das Finanças de Angola
   ============================================================================= */

// Estado da aplicação
const AppState = {
    currentSection: 'home',
    currentModule: null,
    currentTab: 'presentation',
    theme: 'light',
    fullscreen: false,
    modules: {
        1: {
            title: 'Módulo 1: Fundamentos Linux',
            description: 'Introdução ao Linux, permissões, usuários, grupos, processos e serviços',
            duration: '10 horas',
            level: 'Básico',
            presentations: [
                {
                    id: 'intro-linux',
                    title: 'Introdução Completa ao Linux',
                    file: '../modulos/modulo1_introducao_completa.html'
                },
                {
                    id: 'permissoes',
                    title: 'Permissões de Arquivos e Diretórios',
                    file: '../modulos/modulo1_permissoes_completo.html'
                },
                {
                    id: 'usuarios-grupos',
                    title: 'Gestão de Usuários e Grupos',
                    file: '../modulos/modulo1_fundamentos_linux/apresentacoes/modulo1_gestao_usuarios_grupos.html'
                },
                {
                    id: 'processos-servicos',
                    title: 'Processos e Serviços',
                    file: '../modulos/modulo1_fundamentos_linux/apresentacoes/modulo1_processos_servicos.html'
                }
            ],
            exercises: [
                {
                    id: 'exercicio-permissoes',
                    title: 'Exercício: Permissões de Arquivos',
                    description: 'Prática com chmod, chown, chgrp',
                    file: '../modulos/modulo1_fundamentos_linux/exercicios/exercicio_permissoes_arquivos.sh'
                },
                {
                    id: 'exercicio-usuarios',
                    title: 'Exercício: Usuários e Grupos',
                    description: 'Criação e gerenciamento de usuários',
                    file: '../modulos/modulo1_fundamentos_linux/exercicios/exercicio_usuarios_grupos.sh'
                },
                {
                    id: 'exercicio-processos',
                    title: 'Exercício: Processos e Serviços',
                    description: 'Gerenciamento com ps, top, kill, systemd',
                    file: '../modulos/modulo1_fundamentos_linux/exercicios/exercicio_processos_servicos.sh'
                },
                {
                    id: 'comandos-basicos',
                    title: 'Comandos Básicos do Linux',
                    description: 'Navegação, manipulação de arquivos e diretórios',
                    file: '../exercicios/comandos_basicos_linux.sh'
                }
            ]
        },
        2: {
            title: 'Módulo 2: Redes e Segurança',
            description: 'Fundamentos de redes, modelos OSI/TCP-IP, subnetting e segurança da informação',
            duration: '10 horas',
            level: 'Intermediário',
            presentations: [
                {
                    id: 'redes-seguranca-completo',
                    title: 'Redes e Segurança - Completo',
                    file: '../modulos/modulo2_redes_seguranca_completo.html'
                },
                {
                    id: 'modelos-osi-tcpip',
                    title: 'Modelos OSI e TCP/IP',
                    file: '../modulos/modulo2_redes_seguranca/apresentacoes/modulo2_modelos_osi_tcpip.html'
                },
                {
                    id: 'enderecamento-ip',
                    title: 'Endereçamento IP e Subnetting',
                    file: '../modulos/modulo2_redes_seguranca/apresentacoes/modulo2_enderecamento_ip_subnetting.html'
                },
                {
                    id: 'roteamento-basico',
                    title: 'Roteamento Básico',
                    file: '../modulos/modulo2_redes_seguranca/apresentacoes/modulo2_roteamento_basico.html'
                },
                {
                    id: 'seguranca-informacao',
                    title: 'Segurança da Informação',
                    file: '../modulos/modulo2_redes_seguranca/apresentacoes/modulo2_seguranca_informacao.html'
                }
            ],
            exercises: [
                {
                    id: 'exercicio-subredes',
                    title: 'Exercício: Cálculo de Sub-redes',
                    description: 'Prática com cálculos de subnetting',
                    file: '../modulos/modulo2_redes_seguranca/exercicios/exercicio_calculo_subredes.sh'
                },
                {
                    id: 'exercicio-controles',
                    title: 'Exercício: Controles de Acesso',
                    description: 'Implementação de controles de segurança',
                    file: '../modulos/modulo2_redes_seguranca/exercicios/exercicio_controles_acesso.sh'
                },
                {
                    id: 'exercicio-cenarios',
                    title: 'Exercício: Cenários Práticos',
                    description: 'Cenários reais de redes e segurança',
                    file: '../modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh'
                }
            ]
        },
        3: {
            title: 'Módulo 3: Administração de Redes',
            description: 'Configuração avançada de redes, servidores DNS, DHCP, Web e serviços',
            duration: '10 horas',
            level: 'Avançado',
            presentations: [
                {
                    id: 'redes-completo',
                    title: 'Administração de Redes - Completo',
                    file: '../modulos/modulo3_administracao_redes_completo.html'
                }
            ],
            exercises: [
                {
                    id: 'configuracao-rede-avancada',
                    title: 'Configuração de Rede Avançada',
                    description: 'VLANs, bonding e interfaces múltiplas',
                    file: '../modulos/modulo3_administracao_redes/exercicios/exercicio_rede_avancada.sh'
                },
                {
                    id: 'servidor-dns',
                    title: 'Configuração de Servidor DNS',
                    description: 'BIND9 e resolução de nomes',
                    file: '../modulos/modulo3_administracao_redes/exercicios/exercicio_dns.sh'
                },
                {
                    id: 'servidor-dhcp',
                    title: 'Configuração de Servidor DHCP',
                    description: 'ISC DHCP e pools de IP',
                    file: '../modulos/modulo3_administracao_redes/exercicios/exercicio_dhcp.sh'
                },
                {
                    id: 'servidor-web',
                    title: 'Configuração de Servidor Web',
                    description: 'Apache e Nginx',
                    file: '../modulos/modulo3_administracao_redes/exercicios/exercicio_web.sh'
                }
            ]
        },
        4: {
            title: 'Módulo 4: Administração de Sistemas',
            description: 'Gerenciamento de pacotes, automação, virtualização e containers',
            duration: '10 horas',
            level: 'Avançado',
            presentations: [
                {
                    id: 'sistemas-completo',
                    title: 'Administração de Sistemas - Completo',
                    file: '../modulos/modulo4_administracao_sistemas_completo.html'
                }
            ],
            exercises: [
                {
                    id: 'gerenciamento-pacotes',
                    title: 'Gerenciamento de Pacotes',
                    description: 'APT, repositórios e dependências',
                    file: '../modulos/modulo4_administracao_sistemas/exercicios/exercicio_pacotes.sh'
                },
                {
                    id: 'automacao-tarefas',
                    title: 'Automação de Tarefas',
                    description: 'Cron, systemd timers e scripts',
                    file: '../modulos/modulo4_administracao_sistemas/exercicios/exercicio_automacao.sh'
                },
                {
                    id: 'bash-scripting',
                    title: 'Bash Scripting Avançado',
                    description: 'Scripts, funções e automação',
                    file: '../modulos/modulo4_administracao_sistemas/exercicios/exercicio_scripting.sh'
                },
                {
                    id: 'containers-docker',
                    title: 'Containers e Docker',
                    description: 'Virtualização e containers',
                    file: '../modulos/modulo4_administracao_sistemas/exercicios/exercicio_containers.sh'
                }
            ]
        }
        // Módulos 5-6 serão adicionados posteriormente
    }
};

// Utilitários
const Utils = {
    // Debounce para otimizar performance
    debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    },

    // Throttle para scroll
    throttle(func, limit) {
        let inThrottle;
        return function() {
            const args = arguments;
            const context = this;
            if (!inThrottle) {
                func.apply(context, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
    },

    // Animar elemento
    animateElement(element, animation, duration = 300) {
        element.style.animation = `${animation} ${duration}ms ease-in-out`;
        setTimeout(() => {
            element.style.animation = '';
        }, duration);
    },

    // Mostrar notificação
    showNotification(message, type = 'info', duration = 3000) {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : 'info-circle'}"></i>
                <span>${message}</span>
            </div>
        `;
        
        // Adicionar estilos se não existirem
        if (!document.querySelector('#notification-styles')) {
            const styles = document.createElement('style');
            styles.id = 'notification-styles';
            styles.textContent = `
                .notification {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    background: var(--bg-primary);
                    border: 1px solid var(--bg-tertiary);
                    border-radius: var(--border-radius);
                    padding: var(--spacing-md);
                    box-shadow: var(--shadow-lg);
                    z-index: 3000;
                    animation: slideInRight 0.3s ease-out;
                }
                .notification-success {
                    border-left: 4px solid var(--success-color);
                }
                .notification-error {
                    border-left: 4px solid var(--error-color);
                }
                .notification-info {
                    border-left: 4px solid var(--info-color);
                }
                .notification-content {
                    display: flex;
                    align-items: center;
                    gap: var(--spacing-sm);
                }
                @keyframes slideInRight {
                    from { transform: translateX(100%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
            `;
            document.head.appendChild(styles);
        }
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.animation = 'slideInRight 0.3s ease-out reverse';
            setTimeout(() => notification.remove(), 300);
        }, duration);
    },

    // Copiar texto para clipboard
    async copyToClipboard(text) {
        try {
            await navigator.clipboard.writeText(text);
            this.showNotification('Código copiado para a área de transferência!', 'success');
        } catch (err) {
            // Fallback para navegadores mais antigos
            const textArea = document.createElement('textarea');
            textArea.value = text;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand('copy');
            document.body.removeChild(textArea);
            this.showNotification('Código copiado para a área de transferência!', 'success');
        }
    },

    // Baixar arquivo
    downloadFile(content, filename, mimeType = 'text/plain') {
        const blob = new Blob([content], { type: mimeType });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = filename;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(url);
    }
};

// Navegação principal
const Navigation = {
    // Mostrar seção
    showSection(sectionId) {
        // Esconder todas as seções
        document.querySelectorAll('.section').forEach(section => {
            section.classList.remove('active');
        });
        
        // Mostrar seção selecionada
        const targetSection = document.getElementById(sectionId);
        if (targetSection) {
            targetSection.classList.add('active');
            AppState.currentSection = sectionId;
            
            // Atualizar navegação
            this.updateNavigation(sectionId);
            
            // Scroll para o topo
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    },

    // Atualizar navegação ativa
    updateNavigation(activeSection) {
        document.querySelectorAll('.nav-link').forEach(link => {
            link.classList.remove('active');
        });
        
        const activeLink = document.querySelector(`[href="#${activeSection}"]`);
        if (activeLink) {
            activeLink.classList.add('active');
        }
    },

    // Inicializar navegação
    init() {
        // Event listeners para links de navegação
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const sectionId = link.getAttribute('href').substring(1);
                this.showSection(sectionId);
            });
        });

        // Event listener para botões de ação do header
        document.getElementById('theme-toggle')?.addEventListener('click', this.toggleTheme);
        document.getElementById('fullscreen-toggle')?.addEventListener('click', this.toggleFullscreen);
    },

    // Alternar tema
    toggleTheme() {
        AppState.theme = AppState.theme === 'light' ? 'dark' : 'light';
        document.documentElement.setAttribute('data-theme', AppState.theme);
        
        const icon = document.querySelector('#theme-toggle i');
        icon.className = AppState.theme === 'light' ? 'fas fa-moon' : 'fas fa-sun';
        
        // Salvar preferência
        localStorage.setItem('theme', AppState.theme);
        
        Utils.showNotification(`Tema ${AppState.theme === 'light' ? 'claro' : 'escuro'} ativado`, 'info');
    },

    // Alternar tela cheia
    toggleFullscreen() {
        if (!AppState.fullscreen) {
            if (document.documentElement.requestFullscreen) {
                document.documentElement.requestFullscreen();
            } else if (document.documentElement.webkitRequestFullscreen) {
                document.documentElement.webkitRequestFullscreen();
            } else if (document.documentElement.msRequestFullscreen) {
                document.documentElement.msRequestFullscreen();
            }
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.webkitExitFullscreen) {
                document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) {
                document.msExitFullscreen();
            }
        }
    }
};

// Gerenciamento de módulos
const ModuleManager = {
    // Abrir módulo
    openModule(moduleId) {
        const module = AppState.modules[moduleId];
        if (!module) {
            Utils.showNotification('Módulo não encontrado', 'error');
            return;
        }

        AppState.currentModule = moduleId;
        this.updateModuleViewer(module);
        Navigation.showSection('module-viewer');
    },

    // Preview do módulo
    previewModule(moduleId) {
        const module = AppState.modules[moduleId];
        if (!module) {
            Utils.showNotification('Módulo não encontrado', 'error');
            return;
        }

        // Mostrar modal de preview
        this.showModulePreview(module);
    },

    // Atualizar visualizador de módulo
    updateModuleViewer(module) {
        // Atualizar título e descrição
        document.getElementById('current-module-title').textContent = module.title;
        document.getElementById('current-module-description').textContent = module.description;

        // Atualizar navegação do módulo
        this.updateModuleNavigation(module);

        // Carregar conteúdo inicial
        this.loadModuleContent('presentation');
    },

    // Atualizar navegação do módulo
    updateModuleNavigation(module) {
        const navList = document.getElementById('module-nav-list');
        navList.innerHTML = '';

        // Adicionar apresentações
        if (module.presentations) {
            const presentationsGroup = document.createElement('li');
            presentationsGroup.innerHTML = '<h4>Apresentações</h4>';
            navList.appendChild(presentationsGroup);

            module.presentations.forEach((presentation, index) => {
                const item = document.createElement('li');
                item.innerHTML = `
                    <a href="#" data-type="presentation" data-id="${presentation.id}" data-file="${presentation.file}">
                        <i class="fas fa-presentation"></i>
                        ${presentation.title}
                    </a>
                `;
                navList.appendChild(item);
            });
        }

        // Adicionar exercícios
        if (module.exercises) {
            const exercisesGroup = document.createElement('li');
            exercisesGroup.innerHTML = '<h4>Exercícios</h4>';
            navList.appendChild(exercisesGroup);

            module.exercises.forEach((exercise, index) => {
                const item = document.createElement('li');
                item.innerHTML = `
                    <a href="#" data-type="exercise" data-id="${exercise.id}" data-file="${exercise.file}">
                        <i class="fas fa-code"></i>
                        ${exercise.title}
                    </a>
                `;
                navList.appendChild(item);
            });
        }

        // Event listeners para navegação do módulo
        navList.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const type = link.dataset.type;
                const id = link.dataset.id;
                const file = link.dataset.file;

                // Atualizar navegação ativa
                navList.querySelectorAll('a').forEach(l => l.classList.remove('active'));
                link.classList.add('active');

                // Carregar conteúdo
                this.loadModuleContent(type, file);
            });
        });
    },

    // Carregar conteúdo do módulo
    async loadModuleContent(type, file = null) {
        const contentContainer = document.getElementById(`${type}-content`);
        if (!contentContainer) return;

        // Mostrar loading
        contentContainer.innerHTML = `
            <div class="loading">
                <i class="fas fa-spinner fa-spin"></i>
                <p>Carregando conteúdo...</p>
            </div>
        `;

        try {
            if (file) {
                // Carregar arquivo específico
                const response = await fetch(file);
                if (!response.ok) throw new Error('Arquivo não encontrado');
                
                const content = await response.text();
                contentContainer.innerHTML = content;
                
                // Processar conteúdo carregado
                this.processLoadedContent(contentContainer, type);
            } else {
                // Carregar conteúdo padrão baseado no tipo
                this.loadDefaultContent(contentContainer, type);
            }
        } catch (error) {
            console.error('Erro ao carregar conteúdo:', error);
            contentContainer.innerHTML = `
                <div class="error">
                    <i class="fas fa-exclamation-triangle"></i>
                    <p>Erro ao carregar conteúdo: ${error.message}</p>
                </div>
            `;
        }
    },

    // Processar conteúdo carregado
    processLoadedContent(container, type) {
        // Adicionar funcionalidade de copiar código
        this.addCodeCopyFunctionality(container);
        
        // Adicionar funcionalidade de download
        this.addDownloadFunctionality(container);
        
        // Adicionar estilos específicos se necessário
        this.addContentStyles(container, type);
    },

    // Adicionar funcionalidade de copiar código
    addCodeCopyFunctionality(container) {
        const codeBlocks = container.querySelectorAll('pre code, .code-block code');
        codeBlocks.forEach(block => {
            const wrapper = document.createElement('div');
            wrapper.className = 'code-wrapper';
            
            const copyBtn = document.createElement('button');
            copyBtn.className = 'btn btn-sm btn-outline copy-btn';
            copyBtn.innerHTML = '<i class="fas fa-copy"></i> Copiar';
            
            copyBtn.addEventListener('click', () => {
                Utils.copyToClipboard(block.textContent);
            });
            
            wrapper.appendChild(block.cloneNode(true));
            wrapper.appendChild(copyBtn);
            block.parentNode.replaceChild(wrapper, block);
        });
    },

    // Adicionar funcionalidade de download
    addDownloadFunctionality(container) {
        const codeBlocks = container.querySelectorAll('pre code, .code-block code');
        codeBlocks.forEach(block => {
            const wrapper = block.closest('.code-wrapper');
            if (wrapper) {
                const downloadBtn = document.createElement('button');
                downloadBtn.className = 'btn btn-sm btn-outline download-btn';
                downloadBtn.innerHTML = '<i class="fas fa-download"></i> Baixar';
                
                downloadBtn.addEventListener('click', () => {
                    const filename = `script_${Date.now()}.sh`;
                    Utils.downloadFile(block.textContent, filename, 'text/plain');
                });
                
                wrapper.appendChild(downloadBtn);
            }
        });
    },

    // Adicionar estilos específicos
    addContentStyles(container, type) {
        if (!document.querySelector('#content-styles')) {
            const styles = document.createElement('style');
            styles.id = 'content-styles';
            styles.textContent = `
                .code-wrapper {
                    position: relative;
                    background: var(--terminal-bg);
                    border-radius: var(--border-radius);
                    overflow: hidden;
                }
                .code-wrapper pre {
                    margin: 0;
                    padding: var(--spacing-lg);
                    overflow-x: auto;
                }
                .code-wrapper .copy-btn,
                .code-wrapper .download-btn {
                    position: absolute;
                    top: var(--spacing-sm);
                    right: var(--spacing-sm);
                    padding: var(--spacing-xs) var(--spacing-sm);
                    font-size: 0.75rem;
                    background: rgba(0, 0, 0, 0.7);
                    color: white;
                    border: none;
                    border-radius: var(--border-radius);
                }
                .code-wrapper .download-btn {
                    right: 80px;
                }
                .loading, .error {
                    text-align: center;
                    padding: var(--spacing-3xl);
                    color: var(--text-secondary);
                }
                .loading i, .error i {
                    font-size: 2rem;
                    margin-bottom: var(--spacing-md);
                }
            `;
            document.head.appendChild(styles);
        }
    },

    // Carregar conteúdo padrão
    loadDefaultContent(container, type) {
        const module = AppState.modules[AppState.currentModule];
        if (!module) return;

        switch (type) {
            case 'presentation':
                container.innerHTML = `
                    <div class="presentation-content">
                        <h3>Apresentações do ${module.title}</h3>
                        <p>Selecione uma apresentação na barra lateral para começar.</p>
                        <div class="presentation-list">
                            ${module.presentations?.map(p => `
                                <div class="presentation-item">
                                    <i class="fas fa-presentation"></i>
                                    <div>
                                        <h4>${p.title}</h4>
                                        <p>Clique para abrir a apresentação</p>
                                    </div>
                                </div>
                            `).join('') || '<p>Nenhuma apresentação disponível.</p>'}
                        </div>
                    </div>
                `;
                break;
            case 'exercise':
                container.innerHTML = `
                    <div class="exercise-content">
                        <h3>Exercícios do ${module.title}</h3>
                        <p>Pratique com exercícios hands-on em ambiente Ubuntu 24.04 LTS.</p>
                        <div class="exercise-list">
                            ${module.exercises?.map(e => `
                                <div class="exercise-item">
                                    <i class="fas fa-code"></i>
                                    <div>
                                        <h4>${e.title}</h4>
                                        <p>${e.description}</p>
                                        <button class="btn btn-primary" onclick="ModuleManager.loadExercise('${e.file}')">
                                            <i class="fas fa-play"></i> Executar
                                        </button>
                                    </div>
                                </div>
                            `).join('') || '<p>Nenhum exercício disponível.</p>'}
                        </div>
                    </div>
                `;
                break;
            case 'resources':
                container.innerHTML = `
                    <div class="resources-content">
                        <h3>Recursos do ${module.title}</h3>
                        <p>Materiais complementares e ferramentas úteis.</p>
                        <div class="resource-list">
                            <div class="resource-item">
                                <i class="fas fa-book"></i>
                                <h4>Documentação</h4>
                                <p>Guias e manuais de referência</p>
                            </div>
                            <div class="resource-item">
                                <i class="fas fa-download"></i>
                                <h4>Scripts</h4>
                                <p>Scripts de instalação e configuração</p>
                            </div>
                            <div class="resource-item">
                                <i class="fas fa-terminal"></i>
                                <h4>Terminal</h4>
                                <p>Acesso ao terminal Linux</p>
                            </div>
                        </div>
                    </div>
                `;
                break;
        }
    },

    // Carregar exercício específico
    async loadExercise(file) {
        try {
            const response = await fetch(file);
            if (!response.ok) throw new Error('Arquivo não encontrado');
            
            const content = await response.text();
            
            // Mostrar modal com código
            this.showCodeModal(content, file.split('/').pop());
        } catch (error) {
            Utils.showNotification('Erro ao carregar exercício: ' + error.message, 'error');
        }
    },

    // Mostrar modal de código
    showCodeModal(code, filename) {
        const modal = document.getElementById('code-copy-modal');
        const codeElement = document.getElementById('code-to-copy');
        
        codeElement.textContent = code;
        modal.classList.add('active');
        
        // Adicionar event listeners
        document.getElementById('code-to-copy').addEventListener('click', () => {
            Utils.copyToClipboard(code);
        });
    },

    // Mostrar preview do módulo
    showModulePreview(module) {
        // Implementar modal de preview
        Utils.showNotification(`Preview do ${module.title} em desenvolvimento`, 'info');
    }
};

// Inicialização da aplicação
document.addEventListener('DOMContentLoaded', () => {
    // Inicializar navegação
    Navigation.init();
    
    // Carregar tema salvo
    const savedTheme = localStorage.getItem('theme');
    if (savedTheme) {
        AppState.theme = savedTheme;
        document.documentElement.setAttribute('data-theme', savedTheme);
        const icon = document.querySelector('#theme-toggle i');
        if (icon) {
            icon.className = savedTheme === 'light' ? 'fas fa-moon' : 'fas fa-sun';
        }
    }
    
    // Event listeners para fullscreen
    document.addEventListener('fullscreenchange', () => {
        AppState.fullscreen = !!document.fullscreenElement;
        const icon = document.querySelector('#fullscreen-toggle i');
        if (icon) {
            icon.className = AppState.fullscreen ? 'fas fa-compress' : 'fas fa-expand';
        }
    });
    
    // Event listeners para tabs do módulo
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const tabId = btn.dataset.tab;
            ModuleManager.switchTab(tabId);
        });
    });
    
    // Fechar modal de código
    document.getElementById('code-copy-modal')?.addEventListener('click', (e) => {
        if (e.target === e.currentTarget) {
            closeCodeModal();
        }
    });
    
    console.log('Plataforma de Treinamento Linux carregada com sucesso!');
});

// Funções globais para uso nos botões
function showSection(sectionId) {
    Navigation.showSection(sectionId);
}

function openModule(moduleId) {
    ModuleManager.openModule(moduleId);
}

function previewModule(moduleId) {
    ModuleManager.previewModule(moduleId);
}

function closeCodeModal() {
    document.getElementById('code-copy-modal').classList.remove('active');
}

function copyCode() {
    const code = document.getElementById('code-to-copy').textContent;
    Utils.copyToClipboard(code);
}

function downloadCode() {
    const code = document.getElementById('code-to-copy').textContent;
    const filename = `script_${Date.now()}.sh`;
    Utils.downloadFile(code, filename, 'text/plain');
}

function downloadScripts() {
    Utils.showNotification('Download de scripts em desenvolvimento', 'info');
}

function openDocumentation() {
    Utils.showNotification('Documentação em desenvolvimento', 'info');
}

function openTerminal() {
    Utils.showNotification('Terminal online em desenvolvimento', 'info');
}
