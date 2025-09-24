/* =============================================================================
   PLATAFORMA DE TREINAMENTO LINUX - GERENCIAMENTO DE EXERCÍCIOS
   Ministério das Finanças de Angola
   ============================================================================= */

// Gerenciador de exercícios
const ExerciseManager = {
    // Estado dos exercícios
    exercises: new Map(),
    currentExercise: null,
    
    // Inicializar
    init() {
        this.loadExercises();
        this.setupEventListeners();
    },

    // Carregar exercícios
    loadExercises() {
        // Exercícios do Módulo 1
        this.addExercise(1, 'permissoes', {
            title: 'Permissões de Arquivos e Diretórios',
            description: 'Prática com chmod, chown, chgrp',
            file: '../modulos/modulo1_fundamentos_linux/exercicios/exercicio_permissoes_arquivos.sh',
            difficulty: 'Básico',
            duration: '30 min',
            prerequisites: ['Conhecimento básico de Linux'],
            objectives: [
                'Entender permissões de arquivos e diretórios',
                'Praticar comandos chmod, chown, chgrp',
                'Aplicar permissões em cenários reais'
            ]
        });

        this.addExercise(1, 'usuarios-grupos', {
            title: 'Gestão de Usuários e Grupos',
            description: 'Criação e gerenciamento de usuários',
            file: '../modulos/modulo1_fundamentos_linux/exercicios/exercicio_usuarios_grupos.sh',
            difficulty: 'Básico',
            duration: '45 min',
            prerequisites: ['Conhecimento básico de Linux', 'Acesso root/sudo'],
            objectives: [
                'Criar e gerenciar usuários',
                'Configurar grupos e permissões',
                'Aplicar políticas de segurança'
            ]
        });

        this.addExercise(1, 'processos-servicos', {
            title: 'Processos e Serviços',
            description: 'Gerenciamento com ps, top, kill, systemd',
            file: '../modulos/modulo1_fundamentos_linux/exercicios/exercicio_processos_servicos.sh',
            difficulty: 'Intermediário',
            duration: '40 min',
            prerequisites: ['Conhecimento básico de Linux'],
            objectives: [
                'Monitorar processos do sistema',
                'Gerenciar serviços com systemd',
                'Analisar logs e performance'
            ]
        });

        // Exercícios do Módulo 2
        this.addExercise(2, 'calculo-subredes', {
            title: 'Cálculo de Sub-redes',
            description: 'Prática com cálculos de subnetting',
            file: '../modulos/modulo2_redes_seguranca/exercicios/exercicio_calculo_subredes.sh',
            difficulty: 'Intermediário',
            duration: '60 min',
            prerequisites: ['Conhecimento de redes básico'],
            objectives: [
                'Calcular sub-redes manualmente',
                'Usar ferramentas de cálculo',
                'Aplicar em cenários empresariais'
            ]
        });

        this.addExercise(2, 'controles-acesso', {
            title: 'Controles de Acesso',
            description: 'Implementação de controles de segurança',
            file: '../modulos/modulo2_redes_seguranca/exercicios/exercicio_controles_acesso.sh',
            difficulty: 'Intermediário',
            duration: '50 min',
            prerequisites: ['Conhecimento de segurança básico'],
            objectives: [
                'Implementar controles de acesso',
                'Configurar políticas de segurança',
                'Auditar permissões'
            ]
        });

        this.addExercise(2, 'cenarios-praticos', {
            title: 'Cenários Práticos',
            description: 'Cenários reais de redes e segurança',
            file: '../modulos/modulo2_redes_seguranca/exercicios/exercicio_cenarios_praticos.sh',
            difficulty: 'Avançado',
            duration: '90 min',
            prerequisites: ['Conhecimento de redes e segurança'],
            objectives: [
                'Resolver problemas reais',
                'Integrar conhecimentos',
                'Aplicar melhores práticas'
            ]
        });
    },

    // Adicionar exercício
    addExercise(moduleId, exerciseId, exercise) {
        const key = `${moduleId}-${exerciseId}`;
        this.exercises.set(key, {
            ...exercise,
            moduleId,
            exerciseId,
            status: 'not-started', // not-started, in-progress, completed
            progress: 0,
            startTime: null,
            endTime: null,
            attempts: 0,
            score: 0
        });
    },

    // Configurar event listeners
    setupEventListeners() {
        // Event listeners para botões de exercício
        document.addEventListener('click', (e) => {
            if (e.target.matches('[data-exercise]')) {
                const exerciseKey = e.target.dataset.exercise;
                this.startExercise(exerciseKey);
            }
        });
    },

    // Iniciar exercício
    async startExercise(exerciseKey) {
        const exercise = this.exercises.get(exerciseKey);
        if (!exercise) {
            Utils.showNotification('Exercício não encontrado', 'error');
            return;
        }

        this.currentExercise = exerciseKey;
        
        try {
            // Carregar conteúdo do exercício
            const response = await fetch(exercise.file);
            if (!response.ok) throw new Error('Arquivo não encontrado');
            
            const content = await response.text();
            
            // Mostrar interface do exercício
            this.showExerciseInterface(exercise, content);
            
            // Atualizar status
            exercise.status = 'in-progress';
            exercise.startTime = new Date();
            exercise.attempts++;
            
        } catch (error) {
            Utils.showNotification('Erro ao carregar exercício: ' + error.message, 'error');
        }
    },

    // Mostrar interface do exercício
    showExerciseInterface(exercise, content) {
        const modal = document.createElement('div');
        modal.className = 'modal exercise-interface active';
        modal.innerHTML = `
            <div class="modal-content exercise-interface-content">
                <div class="modal-header">
                    <div class="exercise-title">
                        <h3>${exercise.title}</h3>
                        <div class="exercise-meta">
                            <span class="difficulty difficulty-${exercise.difficulty.toLowerCase()}">${exercise.difficulty}</span>
                            <span class="duration"><i class="fas fa-clock"></i> ${exercise.duration}</span>
                        </div>
                    </div>
                    <button class="modal-close" onclick="ExerciseManager.closeExercise()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="exercise-content">
                        <div class="exercise-sidebar">
                            <div class="exercise-info">
                                <h4>Objetivos</h4>
                                <ul>
                                    ${exercise.objectives.map(obj => `<li>${obj}</li>`).join('')}
                                </ul>
                            </div>
                            <div class="exercise-prerequisites">
                                <h4>Pré-requisitos</h4>
                                <ul>
                                    ${exercise.prerequisites.map(req => `<li>${req}</li>`).join('')}
                                </ul>
                            </div>
                            <div class="exercise-progress">
                                <h4>Progresso</h4>
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: ${exercise.progress}%"></div>
                                </div>
                                <span class="progress-text">${exercise.progress}% Concluído</span>
                            </div>
                        </div>
                        <div class="exercise-main">
                            <div class="exercise-tabs">
                                <button class="tab-btn active" data-tab="instructions">
                                    <i class="fas fa-list"></i>
                                    Instruções
                                </button>
                                <button class="tab-btn" data-tab="code">
                                    <i class="fas fa-code"></i>
                                    Código
                                </button>
                                <button class="tab-btn" data-tab="terminal">
                                    <i class="fas fa-terminal"></i>
                                    Terminal
                                </button>
                                <button class="tab-btn" data-tab="help">
                                    <i class="fas fa-question-circle"></i>
                                    Ajuda
                                </button>
                            </div>
                            <div class="exercise-tab-content">
                                <div id="instructions-tab" class="tab-content active">
                                    <div class="instructions">
                                        <h4>Descrição</h4>
                                        <p>${exercise.description}</p>
                                        <h4>Instruções</h4>
                                        <ol>
                                            <li>Leia atentamente o código do exercício</li>
                                            <li>Execute os comandos no terminal</li>
                                            <li>Siga as instruções passo a passo</li>
                                            <li>Verifique os resultados</li>
                                        </ol>
                                    </div>
                                </div>
                                <div id="code-tab" class="tab-content">
                                    <div class="code-viewer">
                                        <div class="code-header">
                                            <span class="filename">${exercise.file.split('/').pop()}</span>
                                            <div class="code-actions">
                                                <button class="btn btn-sm btn-outline" onclick="ExerciseManager.copyCode()">
                                                    <i class="fas fa-copy"></i>
                                                    Copiar
                                                </button>
                                                <button class="btn btn-sm btn-outline" onclick="ExerciseManager.downloadCode()">
                                                    <i class="fas fa-download"></i>
                                                    Baixar
                                                </button>
                                            </div>
                                        </div>
                                        <div class="code-block">
                                            <pre><code>${content}</code></pre>
                                        </div>
                                    </div>
                                </div>
                                <div id="terminal-tab" class="tab-content">
                                    <div class="terminal-simulator">
                                        <div class="terminal-header">
                                            <div class="terminal-buttons">
                                                <span class="btn-close"></span>
                                                <span class="btn-minimize"></span>
                                                <span class="btn-maximize"></span>
                                            </div>
                                            <div class="terminal-title">Terminal Linux - Ubuntu 24.04 LTS</div>
                                        </div>
                                        <div class="terminal-body">
                                            <div class="terminal-output" id="terminal-output">
                                                <div class="terminal-line">
                                                    <span class="prompt">user@ubuntu:~$</span>
                                                    <span class="cursor">_</span>
                                                </div>
                                            </div>
                                            <div class="terminal-input">
                                                <input type="text" id="terminal-input" placeholder="Digite um comando..." autocomplete="off">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="help-tab" class="tab-content">
                                    <div class="help-content">
                                        <h4>Comandos Úteis</h4>
                                        <div class="command-list">
                                            <div class="command-item">
                                                <code>ls -la</code>
                                                <span>Listar arquivos com detalhes</span>
                                            </div>
                                            <div class="command-item">
                                                <code>chmod 755 arquivo</code>
                                                <span>Alterar permissões</span>
                                            </div>
                                            <div class="command-item">
                                                <code>sudo useradd usuario</code>
                                                <span>Criar usuário</span>
                                            </div>
                                            <div class="command-item">
                                                <code>ps aux</code>
                                                <span>Listar processos</span>
                                            </div>
                                        </div>
                                        <h4>Dicas</h4>
                                        <ul>
                                            <li>Use <code>man comando</code> para ver a documentação</li>
                                            <li>Use <code>--help</code> para opções de ajuda</li>
                                            <li>Verifique permissões antes de executar comandos</li>
                                            <li>Use <code>sudo</code> para comandos que requerem privilégios</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline" onclick="ExerciseManager.resetExercise()">
                        <i class="fas fa-undo"></i>
                        Reiniciar
                    </button>
                    <button class="btn btn-primary" onclick="ExerciseManager.completeExercise()">
                        <i class="fas fa-check"></i>
                        Concluir
                    </button>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        
        // Configurar terminal simulado
        this.setupTerminalSimulator();
        
        // Configurar tabs
        this.setupExerciseTabs();
        
        // Adicionar estilos
        this.addExerciseStyles();
    },

    // Configurar terminal simulado
    setupTerminalSimulator() {
        const terminalInput = document.getElementById('terminal-input');
        const terminalOutput = document.getElementById('terminal-output');
        
        if (terminalInput) {
            terminalInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    const command = terminalInput.value.trim();
                    if (command) {
                        this.executeCommand(command, terminalOutput);
                        terminalInput.value = '';
                    }
                }
            });
        }
    },

    // Executar comando no terminal simulado
    executeCommand(command, output) {
        const line = document.createElement('div');
        line.className = 'terminal-line';
        line.innerHTML = `
            <span class="prompt">user@ubuntu:~$</span>
            <span class="command">${command}</span>
        `;
        output.appendChild(line);
        
        // Simular saída do comando
        setTimeout(() => {
            const response = this.simulateCommand(command);
            if (response) {
                const responseLine = document.createElement('div');
                responseLine.className = 'terminal-response';
                responseLine.textContent = response;
                output.appendChild(responseLine);
            }
            
            // Adicionar nova linha de prompt
            const newLine = document.createElement('div');
            newLine.className = 'terminal-line';
            newLine.innerHTML = `
                <span class="prompt">user@ubuntu:~$</span>
                <span class="cursor">_</span>
            `;
            output.appendChild(newLine);
            
            // Scroll para baixo
            output.scrollTop = output.scrollHeight;
        }, 500);
    },

    // Simular comando
    simulateCommand(command) {
        const cmd = command.toLowerCase().split(' ')[0];
        
        switch (cmd) {
            case 'ls':
                return 'arquivo1.txt  arquivo2.txt  diretorio1/  diretorio2/';
            case 'pwd':
                return '/home/user';
            case 'whoami':
                return 'user';
            case 'date':
                return new Date().toString();
            case 'help':
                return 'Comandos disponíveis: ls, pwd, whoami, date, help';
            default:
                return `Comando '${command}' não encontrado. Digite 'help' para ver comandos disponíveis.`;
        }
    },

    // Configurar tabs do exercício
    setupExerciseTabs() {
        document.querySelectorAll('.exercise-tabs .tab-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const tabId = btn.dataset.tab;
                
                // Atualizar botões
                document.querySelectorAll('.exercise-tabs .tab-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                
                // Atualizar conteúdo
                document.querySelectorAll('.exercise-tab-content .tab-content').forEach(content => {
                    content.classList.remove('active');
                });
                document.getElementById(`${tabId}-tab`).classList.add('active');
            });
        });
    },

    // Copiar código
    copyCode() {
        const exercise = this.exercises.get(this.currentExercise);
        if (exercise) {
            fetch(exercise.file)
                .then(response => response.text())
                .then(content => {
                    Utils.copyToClipboard(content);
                });
        }
    },

    // Baixar código
    downloadCode() {
        const exercise = this.exercises.get(this.currentExercise);
        if (exercise) {
            fetch(exercise.file)
                .then(response => response.text())
                .then(content => {
                    const filename = exercise.file.split('/').pop();
                    Utils.downloadFile(content, filename, 'text/plain');
                });
        }
    },

    // Reiniciar exercício
    resetExercise() {
        if (this.currentExercise) {
            const exercise = this.exercises.get(this.currentExercise);
            exercise.progress = 0;
            exercise.status = 'not-started';
            exercise.startTime = null;
            
            Utils.showNotification('Exercício reiniciado', 'info');
        }
    },

    // Concluir exercício
    completeExercise() {
        if (this.currentExercise) {
            const exercise = this.exercises.get(this.currentExercise);
            exercise.status = 'completed';
            exercise.progress = 100;
            exercise.endTime = new Date();
            
            // Calcular pontuação baseada no tempo
            const duration = exercise.endTime - exercise.startTime;
            const expectedTime = this.parseDuration(exercise.duration);
            exercise.score = Math.max(0, 100 - Math.floor(duration / expectedTime * 10));
            
            Utils.showNotification(`Exercício concluído! Pontuação: ${exercise.score}`, 'success');
            this.closeExercise();
        }
    },

    // Fechar exercício
    closeExercise() {
        const modal = document.querySelector('.exercise-interface');
        if (modal) {
            modal.remove();
        }
        this.currentExercise = null;
    },

    // Parsear duração
    parseDuration(duration) {
        const match = duration.match(/(\d+)\s*min/);
        return match ? parseInt(match[1]) * 60000 : 300000; // 5 min padrão
    },

    // Adicionar estilos
    addExerciseStyles() {
        if (!document.querySelector('#exercise-styles')) {
            const styles = document.createElement('style');
            styles.id = 'exercise-styles';
            styles.textContent = `
                .exercise-interface .modal-content {
                    max-width: 1400px;
                    width: 95%;
                    height: 90vh;
                }
                
                .exercise-content {
                    display: grid;
                    grid-template-columns: 300px 1fr;
                    gap: var(--spacing-lg);
                    height: 100%;
                }
                
                .exercise-sidebar {
                    background: var(--bg-secondary);
                    border-radius: var(--border-radius);
                    padding: var(--spacing-lg);
                    height: fit-content;
                }
                
                .exercise-sidebar h4 {
                    color: var(--primary-color);
                    margin-bottom: var(--spacing-md);
                    font-size: 1rem;
                }
                
                .exercise-sidebar ul {
                    list-style: none;
                    padding: 0;
                    margin-bottom: var(--spacing-lg);
                }
                
                .exercise-sidebar li {
                    padding: var(--spacing-xs) 0;
                    color: var(--text-secondary);
                    font-size: 0.875rem;
                }
                
                .exercise-sidebar li:before {
                    content: '•';
                    color: var(--primary-color);
                    margin-right: var(--spacing-sm);
                }
                
                .difficulty {
                    padding: var(--spacing-xs) var(--spacing-sm);
                    border-radius: var(--border-radius);
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                }
                
                .difficulty-básico {
                    background: var(--success-color);
                    color: white;
                }
                
                .difficulty-intermediário {
                    background: var(--warning-color);
                    color: white;
                }
                
                .difficulty-avançado {
                    background: var(--error-color);
                    color: white;
                }
                
                .exercise-main {
                    display: flex;
                    flex-direction: column;
                }
                
                .exercise-tabs {
                    display: flex;
                    border-bottom: 1px solid var(--bg-tertiary);
                    background: var(--bg-secondary);
                }
                
                .exercise-tabs .tab-btn {
                    flex: 1;
                    padding: var(--spacing-md);
                    background: none;
                    border: none;
                    color: var(--text-secondary);
                    cursor: pointer;
                    transition: var(--transition);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: var(--spacing-sm);
                }
                
                .exercise-tabs .tab-btn:hover,
                .exercise-tabs .tab-btn.active {
                    color: var(--primary-color);
                    background: var(--bg-primary);
                    border-bottom: 2px solid var(--primary-color);
                }
                
                .exercise-tab-content {
                    flex: 1;
                    overflow: hidden;
                }
                
                .exercise-tab-content .tab-content {
                    height: 100%;
                    overflow-y: auto;
                    padding: var(--spacing-lg);
                }
                
                .code-viewer {
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                }
                
                .code-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: var(--spacing-md);
                    background: var(--bg-secondary);
                    border-bottom: 1px solid var(--bg-tertiary);
                }
                
                .filename {
                    font-family: 'Fira Code', monospace;
                    font-weight: 600;
                    color: var(--text-primary);
                }
                
                .code-actions {
                    display: flex;
                    gap: var(--spacing-sm);
                }
                
                .code-block {
                    flex: 1;
                    background: var(--terminal-bg);
                    border-radius: var(--border-radius);
                    overflow: hidden;
                }
                
                .code-block pre {
                    height: 100%;
                    margin: 0;
                    padding: var(--spacing-lg);
                    overflow: auto;
                    color: var(--terminal-text);
                    font-family: 'Fira Code', 'Monaco', 'Consolas', monospace;
                    font-size: 0.875rem;
                    line-height: 1.5;
                }
                
                .terminal-simulator {
                    height: 100%;
                    display: flex;
                    flex-direction: column;
                    background: var(--terminal-bg);
                    border-radius: var(--border-radius);
                    overflow: hidden;
                }
                
                .terminal-header {
                    background: #2d2d2d;
                    padding: var(--spacing-md);
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }
                
                .terminal-buttons {
                    display: flex;
                    gap: var(--spacing-sm);
                }
                
                .terminal-buttons span {
                    width: 12px;
                    height: 12px;
                    border-radius: 50%;
                }
                
                .btn-close { background-color: #ff5f57; }
                .btn-minimize { background-color: #ffbd2e; }
                .btn-maximize { background-color: #28ca42; }
                
                .terminal-title {
                    color: var(--text-white);
                    font-size: 0.875rem;
                    font-weight: 500;
                }
                
                .terminal-body {
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                }
                
                .terminal-output {
                    flex: 1;
                    padding: var(--spacing-lg);
                    color: var(--terminal-text);
                    font-family: 'Fira Code', 'Monaco', 'Consolas', monospace;
                    font-size: 0.875rem;
                    line-height: 1.5;
                    overflow-y: auto;
                }
                
                .terminal-line {
                    margin-bottom: var(--spacing-sm);
                }
                
                .prompt {
                    color: var(--terminal-prompt);
                    font-weight: 600;
                }
                
                .command {
                    color: var(--terminal-command);
                }
                
                .terminal-response {
                    color: var(--text-white);
                    margin: var(--spacing-md) 0;
                }
                
                .terminal-input {
                    padding: var(--spacing-md);
                    border-top: 1px solid #2d2d2d;
                }
                
                .terminal-input input {
                    width: 100%;
                    background: transparent;
                    border: none;
                    color: var(--terminal-text);
                    font-family: 'Fira Code', 'Monaco', 'Consolas', monospace;
                    font-size: 0.875rem;
                    outline: none;
                }
                
                .terminal-input input::placeholder {
                    color: var(--text-muted);
                }
                
                .help-content h4 {
                    color: var(--primary-color);
                    margin-bottom: var(--spacing-md);
                }
                
                .command-list {
                    margin-bottom: var(--spacing-lg);
                }
                
                .command-item {
                    display: flex;
                    align-items: center;
                    gap: var(--spacing-md);
                    padding: var(--spacing-sm) 0;
                    border-bottom: 1px solid var(--bg-tertiary);
                }
                
                .command-item code {
                    background: var(--bg-secondary);
                    padding: var(--spacing-xs) var(--spacing-sm);
                    border-radius: var(--border-radius);
                    font-family: 'Fira Code', monospace;
                    color: var(--primary-color);
                    min-width: 150px;
                }
                
                .command-item span {
                    color: var(--text-secondary);
                    font-size: 0.875rem;
                }
                
                @media (max-width: 768px) {
                    .exercise-content {
                        grid-template-columns: 1fr;
                    }
                    
                    .exercise-sidebar {
                        order: 2;
                    }
                    
                    .exercise-main {
                        order: 1;
                    }
                    
                    .exercise-tabs {
                        flex-direction: column;
                    }
                }
            `;
            document.head.appendChild(styles);
        }
    }
};

// Inicializar quando o DOM estiver carregado
document.addEventListener('DOMContentLoaded', () => {
    ExerciseManager.init();
});
