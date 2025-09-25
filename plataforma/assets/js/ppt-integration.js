/**
 * Sistema de Integração PPT + Plataforma
 * Ministério das Finanças de Angola - Treinamento Linux Avançado
 */

class PPTIntegration {
    constructor() {
        this.pptMapping = {
            'modulo1': {
                'conceitos': 'modulo1_introducao_completa.html',
                'comandos-basicos': 'modulo1_introducao_completa.html',
                'permissoes': 'modulo1_permissoes_completo.html',
                'usuarios-grupos': 'modulo1_gestao_usuarios_grupos.html',
                'processos': 'modulo1_processos_servicos.html',
                'armazenamento': 'modulo1_introducao_completa.html',
                'editor-vi': 'modulo1_introducao_completa.html'
            },
            'modulo2': {
                'network': 'modulo2_redes_seguranca_completo.html',
                'dns': 'modulo2_modelos_osi_tcpip.html',
                'gerenciamento-pacotes': 'modulo2_enderecamento_ip_subnetting.html'
            },
            'modulo3': {
                'apache': 'modulo3_administracao_redes_completo.html',
                'ftp-ssh': 'modulo3_administracao_redes_completo.html',
                'proxy': 'modulo3_administracao_redes_completo.html',
                'dhcp': 'modulo3_administracao_redes_completo.html',
                'samba': 'modulo3_administracao_redes_completo.html'
            },
            'modulo4': {
                'backup': 'modulo4_administracao_sistemas_completo.html',
                'shell-script': 'modulo4_administracao_sistemas_completo.html',
                'mysql': 'modulo4_administracao_sistemas_completo.html'
            }
        };
        
        this.init();
    }
    
    init() {
        this.createPPTNavigation();
        this.addImagePlaceholders();
        this.createLabConnections();
    }
    
    createPPTNavigation() {
        // Criar barra de navegação PPT
        const pptNav = document.createElement('div');
        pptNav.id = 'ppt-navigation';
        pptNav.className = 'ppt-navigation';
        pptNav.innerHTML = `
            <div class="ppt-nav-header">
                <h3><i class="fas fa-presentation"></i> Conexão PPT + Laboratório</h3>
                <button id="toggle-ppt-nav" class="btn btn-sm">
                    <i class="fas fa-chevron-down"></i>
                </button>
            </div>
            <div class="ppt-nav-content" id="ppt-nav-content">
                <div class="ppt-module-selector">
                    <label for="ppt-module">Módulo:</label>
                    <select id="ppt-module" onchange="pptIntegration.loadModuleContent()">
                        <option value="">Selecione um módulo</option>
                        <option value="modulo1">Módulo 1 - Fundamentos Linux</option>
                        <option value="modulo2">Módulo 2 - Redes e Segurança</option>
                        <option value="modulo3">Módulo 3 - Administração de Redes</option>
                        <option value="modulo4">Módulo 4 - Administração de Sistemas</option>
                    </select>
                </div>
                <div class="ppt-topic-list" id="ppt-topic-list">
                    <!-- Lista de tópicos será carregada dinamicamente -->
                </div>
                <div class="ppt-actions">
                    <button class="btn btn-primary" onclick="pptIntegration.openLab()">
                        <i class="fas fa-flask"></i> Abrir Laboratório
                    </button>
                    <button class="btn btn-secondary" onclick="pptIntegration.downloadPPT()">
                        <i class="fas fa-download"></i> Baixar PPT
                    </button>
                </div>
            </div>
        `;
        
        // Adicionar ao body
        document.body.appendChild(pptNav);
        
        // Toggle functionality
        document.getElementById('toggle-ppt-nav').addEventListener('click', () => {
            const content = document.getElementById('ppt-nav-content');
            const icon = document.querySelector('#toggle-ppt-nav i');
            content.classList.toggle('collapsed');
            icon.classList.toggle('fa-chevron-down');
            icon.classList.toggle('fa-chevron-up');
        });
    }
    
    loadModuleContent() {
        const module = document.getElementById('ppt-module').value;
        const topicList = document.getElementById('ppt-topic-list');
        
        if (!module) {
            topicList.innerHTML = '<p>Selecione um módulo para ver os tópicos</p>';
            return;
        }
        
        const topics = this.getModuleTopics(module);
        topicList.innerHTML = topics.map(topic => `
            <div class="ppt-topic-item" onclick="pptIntegration.openTopic('${module}', '${topic.id}')">
                <i class="fas fa-file-powerpoint"></i>
                <span>${topic.name}</span>
                <i class="fas fa-external-link-alt"></i>
            </div>
        `).join('');
    }
    
    getModuleTopics(module) {
        const topics = {
            'modulo1': [
                { id: 'conceitos', name: 'Conceitos Fundamentais do Linux' },
                { id: 'comandos-basicos', name: 'Comandos Básicos (Parte 1 e 2)' },
                { id: 'permissoes', name: 'Permissões de Arquivos e Diretórios' },
                { id: 'usuarios-grupos', name: 'Usuários e Grupos' },
                { id: 'processos', name: 'Gerenciamento de Processos' },
                { id: 'armazenamento', name: 'Armazenamento e Discos' },
                { id: 'editor-vi', name: 'Editor VI/VIM' }
            ],
            'modulo2': [
                { id: 'network', name: 'Configuração de Rede' },
                { id: 'dns', name: 'Servidor DNS' },
                { id: 'gerenciamento-pacotes', name: 'Gerenciamento de Pacotes' }
            ],
            'modulo3': [
                { id: 'apache', name: 'Servidor Web Apache' },
                { id: 'ftp-ssh', name: 'FTP e SSH' },
                { id: 'proxy', name: 'Proxy Cache e Reverso' },
                { id: 'dhcp', name: 'Servidor DHCP' },
                { id: 'samba', name: 'Compartilhamento SAMBA' }
            ],
            'modulo4': [
                { id: 'backup', name: 'Backup e Recuperação' },
                { id: 'shell-script', name: 'Shell Scripting' },
                { id: 'mysql', name: 'Instalação MySQL' }
            ]
        };
        
        return topics[module] || [];
    }
    
    openTopic(module, topicId) {
        const presentation = this.pptMapping[module][topicId];
        if (presentation) {
            const url = `modulos/${module}_fundamentos_linux/apresentacoes/${presentation}`;
            window.open(url, '_blank');
        }
    }
    
    openLab() {
        const module = document.getElementById('ppt-module').value;
        if (module) {
            const labUrl = `modulos/${module}_fundamentos_linux/exercicios/`;
            window.open(labUrl, '_blank');
        }
    }
    
    downloadPPT() {
        const module = document.getElementById('ppt-module').value;
        if (module) {
            // Simular download do PPT
            alert(`Download do PPT do ${module} iniciado!`);
        }
    }
    
    addImagePlaceholders() {
        // Adicionar placeholders para imagens nos módulos
        const modules = document.querySelectorAll('.slide');
        modules.forEach(slide => {
            const images = slide.querySelectorAll('img[src=""]');
            images.forEach(img => {
                img.src = this.getPlaceholderImage(img.alt || 'Imagem do curso');
            });
        });
    }
    
    getPlaceholderImage(alt) {
        // Gerar placeholder baseado no texto
        const encoded = encodeURIComponent(alt);
        return `https://via.placeholder.com/800x400/2c3e50/ecf0f1?text=${encoded}`;
    }
    
    createLabConnections() {
        // Criar conexões visuais entre PPT e laboratórios
        const labButtons = document.querySelectorAll('.btn[onclick*="executeExercise"]');
        labButtons.forEach(button => {
            button.addEventListener('click', () => {
                this.showPPTConnection(button);
            });
        });
    }
    
    showPPTConnection(button) {
        // Mostrar conexão com PPT
        const connection = document.createElement('div');
        connection.className = 'ppt-connection';
        connection.innerHTML = `
            <div class="connection-content">
                <h4><i class="fas fa-link"></i> Conexão PPT + Laboratório</h4>
                <p>Este exercício está conectado com a apresentação PowerPoint correspondente.</p>
                <button class="btn btn-sm" onclick="this.parentElement.parentElement.remove()">
                    <i class="fas fa-times"></i> Fechar
                </button>
            </div>
        `;
        
        button.parentElement.appendChild(connection);
        
        // Remover após 5 segundos
        setTimeout(() => {
            if (connection.parentElement) {
                connection.remove();
            }
        }, 5000);
    }
}

// Inicializar quando o DOM estiver carregado
document.addEventListener('DOMContentLoaded', () => {
    window.pptIntegration = new PPTIntegration();
});

// CSS para a integração PPT
const pptCSS = `
<style>
.ppt-navigation {
    position: fixed;
    top: 20px;
    right: 20px;
    width: 300px;
    background: white;
    border: 2px solid #3498db;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    z-index: 1000;
    font-family: 'Inter', sans-serif;
}

.ppt-nav-header {
    background: #3498db;
    color: white;
    padding: 15px;
    border-radius: 8px 8px 0 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.ppt-nav-content {
    padding: 20px;
    max-height: 400px;
    overflow-y: auto;
    transition: max-height 0.3s ease;
}

.ppt-nav-content.collapsed {
    max-height: 0;
    padding: 0 20px;
}

.ppt-module-selector {
    margin-bottom: 20px;
}

.ppt-module-selector label {
    display: block;
    margin-bottom: 5px;
    font-weight: 600;
    color: #2c3e50;
}

.ppt-module-selector select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

.ppt-topic-item {
    display: flex;
    align-items: center;
    padding: 10px;
    margin: 5px 0;
    background: #f8f9fa;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.ppt-topic-item:hover {
    background: #e9ecef;
}

.ppt-topic-item i:first-child {
    margin-right: 10px;
    color: #e74c3c;
}

.ppt-topic-item i:last-child {
    margin-left: auto;
    color: #3498db;
}

.ppt-actions {
    margin-top: 20px;
    display: flex;
    gap: 10px;
}

.ppt-actions .btn {
    flex: 1;
    padding: 8px 12px;
    font-size: 12px;
}

.ppt-connection {
    position: absolute;
    top: -50px;
    left: 50%;
    transform: translateX(-50%);
    background: #2c3e50;
    color: white;
    padding: 10px 15px;
    border-radius: 5px;
    font-size: 12px;
    z-index: 1001;
}

.ppt-connection::after {
    content: '';
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border: 5px solid transparent;
    border-top-color: #2c3e50;
}

.connection-content h4 {
    margin: 0 0 5px 0;
    font-size: 14px;
}

.connection-content p {
    margin: 0 0 10px 0;
    font-size: 11px;
}

@media (max-width: 768px) {
    .ppt-navigation {
        width: 250px;
        right: 10px;
    }
}
</style>
`;

// Adicionar CSS ao head
document.head.insertAdjacentHTML('beforeend', pptCSS);
