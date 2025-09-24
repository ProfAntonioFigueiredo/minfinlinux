/* =============================================================================
   PLATAFORMA DE TREINAMENTO LINUX - GERENCIAMENTO DE MÓDULOS
   Ministério das Finanças de Angola
   ============================================================================= */

// Extensão do ModuleManager para funcionalidades específicas
Object.assign(ModuleManager, {
    // Alternar tab do módulo
    switchTab(tabId) {
        // Atualizar botões de tab
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('active');
        });
        document.querySelector(`[data-tab="${tabId}"]`).classList.add('active');
        
        // Atualizar conteúdo
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.remove('active');
        });
        document.getElementById(`${tabId}-content`).classList.add('active');
        
        AppState.currentTab = tabId;
        
        // Carregar conteúdo específico da tab
        this.loadTabContent(tabId);
    },

    // Carregar conteúdo específico da tab
    loadTabContent(tabId) {
        const module = AppState.modules[AppState.currentModule];
        if (!module) return;

        switch (tabId) {
            case 'presentation':
                this.loadPresentations(module);
                break;
            case 'exercise':
                this.loadExercises(module);
                break;
            case 'resources':
                this.loadResources(module);
                break;
        }
    },

    // Carregar apresentações
    loadPresentations(module) {
        const container = document.getElementById('presentation-content');
        
        if (!module.presentations || module.presentations.length === 0) {
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-presentation"></i>
                    <h3>Nenhuma apresentação disponível</h3>
                    <p>As apresentações serão adicionadas em breve.</p>
                </div>
            `;
            return;
        }

        container.innerHTML = `
            <div class="presentations-grid">
                ${module.presentations.map((presentation, index) => `
                    <div class="presentation-card" data-file="${presentation.file}">
                        <div class="presentation-header">
                            <div class="presentation-icon">
                                <i class="fas fa-presentation"></i>
                            </div>
                            <div class="presentation-info">
                                <h4>${presentation.title}</h4>
                                <p>Apresentação ${index + 1} de ${module.presentations.length}</p>
                            </div>
                        </div>
                        <div class="presentation-actions">
                            <button class="btn btn-primary" onclick="ModuleManager.openPresentation('${presentation.file}', '${presentation.title}')">
                                <i class="fas fa-play"></i>
                                Abrir
                            </button>
                            <button class="btn btn-outline" onclick="ModuleManager.previewPresentation('${presentation.file}')">
                                <i class="fas fa-eye"></i>
                                Preview
                            </button>
                        </div>
                    </div>
                `).join('')}
            </div>
        `;
    },

    // Carregar exercícios
    loadExercises(module) {
        const container = document.getElementById('exercise-content');
        
        if (!module.exercises || module.exercises.length === 0) {
            container.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-code"></i>
                    <h3>Nenhum exercício disponível</h3>
                    <p>Os exercícios serão adicionados em breve.</p>
                </div>
            `;
            return;
        }

        container.innerHTML = `
            <div class="exercises-grid">
                ${module.exercises.map((exercise, index) => `
                    <div class="exercise-card" data-file="${exercise.file}">
                        <div class="exercise-header">
                            <div class="exercise-icon">
                                <i class="fas fa-code"></i>
                            </div>
                            <div class="exercise-info">
                                <h4>${exercise.title}</h4>
                                <p>${exercise.description}</p>
                            </div>
                        </div>
                        <div class="exercise-actions">
                            <button class="btn btn-primary" onclick="ModuleManager.openExercise('${exercise.file}', '${exercise.title}')">
                                <i class="fas fa-play"></i>
                                Executar
                            </button>
                            <button class="btn btn-outline" onclick="ModuleManager.downloadExercise('${exercise.file}', '${exercise.title}')">
                                <i class="fas fa-download"></i>
                                Baixar
                            </button>
                        </div>
                        <div class="exercise-progress">
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 0%"></div>
                            </div>
                            <span class="progress-text">Não iniciado</span>
                        </div>
                    </div>
                `).join('')}
            </div>
        `;
    },

    // Carregar recursos
    loadResources(module) {
        const container = document.getElementById('resources-content');
        
        container.innerHTML = `
            <div class="resources-grid">
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <h4>Documentação</h4>
                    <p>Guias completos e manuais de referência para ${module.title}</p>
                    <button class="btn btn-primary" onclick="ModuleManager.openDocumentation('${module.title}')">
                        <i class="fas fa-external-link-alt"></i>
                        Abrir Docs
                    </button>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-download"></i>
                    </div>
                    <h4>Scripts de Instalação</h4>
                    <p>Scripts automatizados para configuração do ambiente Ubuntu</p>
                    <button class="btn btn-primary" onclick="ModuleManager.downloadScripts('${module.title}')">
                        <i class="fas fa-download"></i>
                        Baixar Scripts
                    </button>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-terminal"></i>
                    </div>
                    <h4>Terminal Online</h4>
                    <p>Terminal Linux virtual para prática imediata</p>
                    <button class="btn btn-primary" onclick="ModuleManager.openTerminal()">
                        <i class="fas fa-play"></i>
                        Abrir Terminal
                    </button>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-video"></i>
                    </div>
                    <h4>Vídeos Tutoriais</h4>
                    <p>Vídeos explicativos para ${module.title}</p>
                    <button class="btn btn-primary" onclick="ModuleManager.openVideos('${module.title}')">
                        <i class="fas fa-play"></i>
                        Assistir
                    </button>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h4>FAQ</h4>
                    <p>Perguntas frequentes sobre ${module.title}</p>
                    <button class="btn btn-primary" onclick="ModuleManager.openFAQ('${module.title}')">
                        <i class="fas fa-question"></i>
                        Ver FAQ
                    </button>
                </div>
                
                <div class="resource-card">
                    <div class="resource-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h4>Fórum</h4>
                    <p>Discussões e dúvidas sobre ${module.title}</p>
                    <button class="btn btn-primary" onclick="ModuleManager.openForum('${module.title}')">
                        <i class="fas fa-comments"></i>
                        Participar
                    </button>
                </div>
            </div>
        `;
    },

    // Abrir apresentação
    async openPresentation(file, title) {
        try {
            const response = await fetch(file);
            if (!response.ok) throw new Error('Arquivo não encontrado');
            
            const content = await response.text();
            
            // Criar modal para apresentação
            this.showPresentationModal(content, title);
        } catch (error) {
            Utils.showNotification('Erro ao carregar apresentação: ' + error.message, 'error');
        }
    },

    // Preview da apresentação
    previewPresentation(file) {
        Utils.showNotification('Preview de apresentação em desenvolvimento', 'info');
    },

    // Abrir exercício
    async openExercise(file, title) {
        try {
            const response = await fetch(file);
            if (!response.ok) throw new Error('Arquivo não encontrado');
            
            const content = await response.text();
            
            // Mostrar modal com código do exercício
            this.showExerciseModal(content, title, file);
        } catch (error) {
            Utils.showNotification('Erro ao carregar exercício: ' + error.message, 'error');
        }
    },

    // Baixar exercício
    downloadExercise(file, title) {
        fetch(file)
            .then(response => response.text())
            .then(content => {
                const filename = title.toLowerCase().replace(/\s+/g, '_') + '.sh';
                Utils.downloadFile(content, filename, 'text/plain');
                Utils.showNotification('Exercício baixado com sucesso!', 'success');
            })
            .catch(error => {
                Utils.showNotification('Erro ao baixar exercício: ' + error.message, 'error');
            });
    },

    // Mostrar modal de apresentação
    showPresentationModal(content, title) {
        // Criar modal dinâmico
        const modal = document.createElement('div');
        modal.className = 'modal presentation-modal active';
        modal.innerHTML = `
            <div class="modal-content presentation-content">
                <div class="modal-header">
                    <h3>${title}</h3>
                    <button class="modal-close" onclick="this.closest('.modal').remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="presentation-viewer">
                        ${content}
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="this.closest('.modal').remove()">
                        <i class="fas fa-times"></i>
                        Fechar
                    </button>
                    <button class="btn btn-primary" onclick="ModuleManager.downloadPresentation('${title}')">
                        <i class="fas fa-download"></i>
                        Baixar
                    </button>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        
        // Adicionar estilos específicos para apresentação
        this.addPresentationStyles();
    },

    // Mostrar modal de exercício
    showExerciseModal(content, title, file) {
        const modal = document.createElement('div');
        modal.className = 'modal exercise-modal active';
        modal.innerHTML = `
            <div class="modal-content exercise-content">
                <div class="modal-header">
                    <h3>${title}</h3>
                    <button class="modal-close" onclick="this.closest('.modal').remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="exercise-viewer">
                        <div class="code-block">
                            <pre><code>${content}</code></pre>
                        </div>
                        <div class="exercise-actions">
                            <button class="btn btn-primary" onclick="Utils.copyToClipboard(\`${content.replace(/`/g, '\\`')}\`)">
                                <i class="fas fa-copy"></i>
                                Copiar Código
                            </button>
                            <button class="btn btn-outline" onclick="ModuleManager.downloadExercise('${file}', '${title}')">
                                <i class="fas fa-download"></i>
                                Baixar Script
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
    },

    // Adicionar estilos para apresentação
    addPresentationStyles() {
        if (!document.querySelector('#presentation-styles')) {
            const styles = document.createElement('style');
            styles.id = 'presentation-styles';
            styles.textContent = `
                .presentation-modal .modal-content {
                    max-width: 1200px;
                    width: 95%;
                }
                .presentation-viewer {
                    max-height: 70vh;
                    overflow-y: auto;
                }
                .presentation-viewer h1,
                .presentation-viewer h2,
                .presentation-viewer h3 {
                    color: var(--primary-color);
                    margin-bottom: var(--spacing-md);
                }
                .presentation-viewer pre {
                    background: var(--terminal-bg);
                    color: var(--terminal-text);
                    padding: var(--spacing-lg);
                    border-radius: var(--border-radius);
                    overflow-x: auto;
                }
                .presentation-viewer code {
                    background: var(--bg-secondary);
                    padding: var(--spacing-xs) var(--spacing-sm);
                    border-radius: var(--border-radius);
                    font-family: 'Fira Code', monospace;
                }
                .exercise-modal .modal-content {
                    max-width: 900px;
                }
                .exercise-viewer .code-block {
                    margin-bottom: var(--spacing-lg);
                }
                .exercise-actions {
                    display: flex;
                    gap: var(--spacing-md);
                    justify-content: center;
                }
            `;
            document.head.appendChild(styles);
        }
    },

    // Funções de recursos
    openDocumentation(moduleTitle) {
        Utils.showNotification(`Documentação do ${moduleTitle} em desenvolvimento`, 'info');
    },

    downloadScripts(moduleTitle) {
        Utils.showNotification(`Scripts do ${moduleTitle} em desenvolvimento`, 'info');
    },

    openTerminal() {
        Utils.showNotification('Terminal online em desenvolvimento', 'info');
    },

    openVideos(moduleTitle) {
        Utils.showNotification(`Vídeos do ${moduleTitle} em desenvolvimento`, 'info');
    },

    openFAQ(moduleTitle) {
        Utils.showNotification(`FAQ do ${moduleTitle} em desenvolvimento`, 'info');
    },

    openForum(moduleTitle) {
        Utils.showNotification(`Fórum do ${moduleTitle} em desenvolvimento`, 'info');
    },

    downloadPresentation(title) {
        Utils.showNotification(`Download da apresentação ${title} em desenvolvimento`, 'info');
    }
});

// Adicionar estilos para os novos componentes
if (!document.querySelector('#module-styles')) {
    const styles = document.createElement('style');
    styles.id = 'module-styles';
    styles.textContent = `
        .presentations-grid,
        .exercises-grid,
        .resources-grid {
            display: grid;
            gap: var(--spacing-lg);
            margin-top: var(--spacing-lg);
        }
        
        .presentations-grid {
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        }
        
        .exercises-grid {
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        }
        
        .resources-grid {
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        }
        
        .presentation-card,
        .exercise-card,
        .resource-card {
            background: var(--bg-primary);
            border: 1px solid var(--bg-tertiary);
            border-radius: var(--border-radius-lg);
            padding: var(--spacing-lg);
            transition: var(--transition);
        }
        
        .presentation-card:hover,
        .exercise-card:hover,
        .resource-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-color);
        }
        
        .presentation-header,
        .exercise-header {
            display: flex;
            align-items: flex-start;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-md);
        }
        
        .presentation-icon,
        .exercise-icon,
        .resource-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            flex-shrink: 0;
        }
        
        .presentation-info,
        .exercise-info {
            flex: 1;
        }
        
        .presentation-info h4,
        .exercise-info h4,
        .resource-card h4 {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: var(--spacing-xs);
            color: var(--text-primary);
        }
        
        .presentation-info p,
        .exercise-info p,
        .resource-card p {
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin: 0;
        }
        
        .presentation-actions,
        .exercise-actions {
            display: flex;
            gap: var(--spacing-sm);
            margin-top: var(--spacing-md);
        }
        
        .exercise-progress {
            margin-top: var(--spacing-md);
            padding-top: var(--spacing-md);
            border-top: 1px solid var(--bg-tertiary);
        }
        
        .progress-bar {
            width: 100%;
            height: 6px;
            background: var(--bg-tertiary);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: var(--spacing-xs);
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            transition: var(--transition);
        }
        
        .progress-text {
            font-size: 0.75rem;
            color: var(--text-muted);
        }
        
        .empty-state {
            text-align: center;
            padding: var(--spacing-3xl);
            color: var(--text-secondary);
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: var(--spacing-lg);
            color: var(--text-muted);
        }
        
        .empty-state h3 {
            font-size: 1.25rem;
            margin-bottom: var(--spacing-md);
        }
        
        .empty-state p {
            font-size: 0.875rem;
        }
        
        @media (max-width: 768px) {
            .presentations-grid,
            .exercises-grid,
            .resources-grid {
                grid-template-columns: 1fr;
            }
            
            .presentation-actions,
            .exercise-actions {
                flex-direction: column;
            }
            
            .presentation-actions .btn,
            .exercise-actions .btn {
                width: 100%;
            }
        }
    `;
    document.head.appendChild(styles);
}
