/**
 * Sistema de Busca Super Otimizado - Material de Apoio FOCA Linux
 * Ministério das Finanças de Angola - Versão Ultra Rápida
 */

class MaterialApoioSuperOtimizado {
    constructor() {
        this.dadosCompletos = this.getDadosEmbarcados();
        this.resultadosFiltrados = [];
        this.filtroAtual = 'todos';
        this.termoBusca = '';
        
        this.init();
    }
    
    init() {
        this.configurarEventos();
        this.exibirTodosConteudos();
        console.log('✅ Sistema super otimizado carregado instantaneamente!');
    }
    
    getDadosEmbarcados() {
        // Dados principais embarcados - versão compacta e otimizada
        return {
            "modulo1_fundamentos": [
                {
                    "arquivo": "focalinux-Avancado-html/ch19s02.html",
                    "titulo": "Limitação de recursos usando PAM",
                    "headers": ["Limitação de recursos usando PAM", "Políticas restritivas", "Controle de acesso"],
                    "comandos": ["login;tty*;user1|user2;!Al0000-0630", "ldd /bin/login", "* soft core 0", "* hard rss 10000"],
                    "modulo_relevante": "modulo1_fundamentos",
                    "palavras_chave": ["pam", "autenticacao", "recursos"],
                    "score_relevancia": 18
                },
                {
                    "arquivo": "focalinux-Avancado-html/ch19.html",
                    "titulo": "Restrições de acesso e recursos",
                    "headers": ["Limitando recursos no bash", "Comando readonly", "Restrições básicas"],
                    "comandos": ["SHELLOPTS=\"restricted\"", "bash -r", "readonly VARIAVEL", "ulimit -a"],
                    "modulo_relevante": "modulo1_fundamentos",
                    "palavras_chave": ["bash", "restricoes", "shell"],
                    "score_relevancia": 15
                },
                {
                    "arquivo": "focalinux-IniciandoIntermediario-html/ch10s15.html",
                    "titulo": "Gerenciamento de processos avançado",
                    "headers": ["Monitoramento de processos", "Controle de prioridades"],
                    "comandos": ["ps aux --sort=-%cpu", "nice -n 10 comando", "renice 15 -p PID", "htop"],
                    "modulo_relevante": "modulo1_fundamentos",
                    "palavras_chave": ["processos", "cpu", "prioridade"],
                    "score_relevancia": 12
                },
                {
                    "arquivo": "focalinux-Iniciante-html/ch08s15.html",
                    "titulo": "Comandos básicos de sistema",
                    "headers": ["Comandos essenciais", "Navegação básica"],
                    "comandos": ["ls -la", "cd /", "pwd", "whoami", "uname -a"],
                    "modulo_relevante": "modulo1_fundamentos",
                    "palavras_chave": ["comandos", "basico", "sistema"],
                    "score_relevancia": 8
                }
            ],
            "modulo2_redes": [
                {
                    "arquivo": "focalinux-Avancado-html/ch15s02.html",
                    "titulo": "Configuração avançada de rede",
                    "headers": ["Configuração de VLANs", "Roteamento estático", "Bonding"],
                    "comandos": ["ip link add link eth0 name eth0.100 type vlan id 100", "ip route add 192.168.1.0/24 via 192.168.0.1"],
                    "modulo_relevante": "modulo2_redes",
                    "palavras_chave": ["vlan", "roteamento", "rede"],
                    "score_relevancia": 16
                },
                {
                    "arquivo": "focalinux-Segurança-html/ch06s05.html",
                    "titulo": "Firewall e segurança de rede",
                    "headers": ["Configuração de iptables", "Políticas de segurança"],
                    "comandos": ["iptables -A INPUT -p tcp --dport 22 -j ACCEPT", "iptables -P INPUT DROP", "ufw enable"],
                    "modulo_relevante": "modulo2_redes",
                    "palavras_chave": ["firewall", "iptables", "seguranca"],
                    "score_relevancia": 20
                },
                {
                    "arquivo": "focalinux-IniciandoIntermediario-html/ch10s20.html",
                    "titulo": "Diagnóstico de rede",
                    "headers": ["Ferramentas de diagnóstico", "Teste de conectividade"],
                    "comandos": ["ping -c 4 8.8.8.8", "traceroute google.com", "netstat -tulpn", "ss -tulpn"],
                    "modulo_relevante": "modulo2_redes",
                    "palavras_chave": ["diagnostico", "ping", "conectividade"],
                    "score_relevancia": 14
                }
            ],
            "modulo3_administracao_redes": [
                {
                    "arquivo": "focalinux-IniciandoIntermediario-html/ch27s15.html",
                    "titulo": "Configuração de servidores DNS",
                    "headers": ["Instalação do BIND9", "Configuração de zonas"],
                    "comandos": ["apt install bind9", "systemctl enable bind9", "named-checkconf"],
                    "modulo_relevante": "modulo3_administracao_redes",
                    "palavras_chave": ["dns", "bind9", "servidor"],
                    "score_relevancia": 14
                },
                {
                    "arquivo": "focalinux-IniciandoIntermediario-html/ch27s20.html",
                    "titulo": "Servidor Web Apache",
                    "headers": ["Instalação do Apache", "Configuração de virtual hosts"],
                    "comandos": ["apt install apache2", "systemctl start apache2", "a2enmod rewrite"],
                    "modulo_relevante": "modulo3_administracao_redes",
                    "palavras_chave": ["apache", "web", "servidor"],
                    "score_relevancia": 12
                }
            ],
            "modulo4_administracao_sistemas": [
                {
                    "arquivo": "focalinux-IniciandoIntermediario-html/ch31s08.html",
                    "titulo": "Gerenciamento de pacotes avançado",
                    "headers": ["Repositórios personalizados", "Dependências complexas"],
                    "comandos": ["apt update && apt upgrade", "apt-cache search pacote", "dpkg -l | grep pacote"],
                    "modulo_relevante": "modulo4_administracao_sistemas",
                    "palavras_chave": ["pacotes", "apt", "repositorio"],
                    "score_relevancia": 10
                },
                {
                    "arquivo": "focalinux-IniciandoIntermediario-html/ch31s12.html",
                    "titulo": "Automação com Cron",
                    "headers": ["Agendamento de tarefas", "Configuração de cron jobs"],
                    "comandos": ["crontab -e", "crontab -l", "systemctl enable cron"],
                    "modulo_relevante": "modulo4_administracao_sistemas",
                    "palavras_chave": ["cron", "automacao", "agendamento"],
                    "score_relevancia": 9
                }
            ],
            "modulo5_seguranca_redes": [
                {
                    "arquivo": "focalinux-Segurança-html/ch07s10.html",
                    "titulo": "Hardening de sistemas Linux",
                    "headers": ["Configuração de SELinux", "Auditoria de segurança"],
                    "comandos": ["setenforce 1", "sestatus", "auditctl -l", "ausearch -k login"],
                    "modulo_relevante": "modulo5_seguranca_redes",
                    "palavras_chave": ["hardening", "selinux", "auditoria"],
                    "score_relevancia": 22
                },
                {
                    "arquivo": "focalinux-Segurança-html/ch08s05.html",
                    "titulo": "Detecção de intrusões",
                    "headers": ["Monitoramento de segurança", "Análise de logs"],
                    "comandos": ["fail2ban-client status", "journalctl -u ssh", "last -n 10"],
                    "modulo_relevante": "modulo5_seguranca_redes",
                    "palavras_chave": ["intrusao", "fail2ban", "monitoramento"],
                    "score_relevancia": 18
                }
            ],
            "modulo6_observabilidade": [
                {
                    "arquivo": "focalinux-Avancado-html/ch22s03.html",
                    "titulo": "Monitoramento com ELK Stack",
                    "headers": ["Elasticsearch", "Logstash", "Kibana"],
                    "comandos": ["curl -X GET \"localhost:9200/\"", "systemctl start elasticsearch", "systemctl start kibana"],
                    "modulo_relevante": "modulo6_observabilidade",
                    "palavras_chave": ["elk", "elasticsearch", "monitoramento"],
                    "score_relevancia": 25
                },
                {
                    "arquivo": "focalinux-Avancado-html/ch22s08.html",
                    "titulo": "Prometheus e Grafana",
                    "headers": ["Métricas de sistema", "Dashboards visuais"],
                    "comandos": ["systemctl start prometheus", "systemctl start grafana-server", "curl localhost:9090"],
                    "modulo_relevante": "modulo6_observabilidade",
                    "palavras_chave": ["prometheus", "grafana", "metricas"],
                    "score_relevancia": 23
                }
            ]
        };
    }
    
    configurarEventos() {
        // Busca otimizada com debounce
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            let timeout;
            searchInput.addEventListener('input', (e) => {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    this.termoBusca = e.target.value.toLowerCase();
                    this.aplicarFiltros();
                }, 200); // Debounce mais rápido
            });
        }
        
        // Filtros otimizados
        document.querySelectorAll('.filtro-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                document.querySelectorAll('.filtro-btn').forEach(b => b.classList.remove('active'));
                e.target.classList.add('active');
                
                this.filtroAtual = e.target.dataset.filtro;
                this.aplicarFiltros();
            });
        });
    }
    
    aplicarFiltros() {
        this.resultadosFiltrados = [];
        
        for (const modulo in this.dadosCompletos) {
            for (const conteudo of this.dadosCompletos[modulo]) {
                if (this.conteudoAtendeFiltros(conteudo)) {
                    this.resultadosFiltrados.push({
                        ...conteudo,
                        modulo: modulo
                    });
                }
            }
        }
        
        // Ordenar por relevância
        this.resultadosFiltrados.sort((a, b) => b.score_relevancia - a.score_relevancia);
        
        this.exibirResultados();
        this.atualizarEstatisticas();
    }
    
    conteudoAtendeFiltros(conteudo) {
        // Filtro por nível
        if (this.filtroAtual !== 'todos') {
            const nivelConteudo = this.determinarNivelConteudo(conteudo);
            if (nivelConteudo !== this.filtroAtual) {
                return false;
            }
        }
        
        // Filtro por busca
        if (this.termoBusca) {
            const textoCompleto = this.extrairTextoCompleto(conteudo).toLowerCase();
            if (!textoCompleto.includes(this.termoBusca)) {
                return false;
            }
        }
        
        return true;
    }
    
    determinarNivelConteudo(conteudo) {
        const titulo = conteudo.titulo.toLowerCase();
        const headers = conteudo.headers ? conteudo.headers.join(' ').toLowerCase() : '';
        const textoCompleto = titulo + ' ' + headers;
        
        if (textoCompleto.includes('avancado') || textoCompleto.includes('hardening') || textoCompleto.includes('elk')) {
            return 'avancado';
        } else if (textoCompleto.includes('seguranca') || textoCompleto.includes('firewall') || textoCompleto.includes('selinux')) {
            return 'seguranca';
        } else if (textoCompleto.includes('configuracao') || textoCompleto.includes('servidor') || textoCompleto.includes('dns')) {
            return 'intermediario';
        } else {
            return 'basico';
        }
    }
    
    extrairTextoCompleto(conteudo) {
        let texto = '';
        
        if (conteudo.titulo) texto += conteudo.titulo + ' ';
        if (conteudo.headers) texto += conteudo.headers.join(' ') + ' ';
        if (conteudo.comandos) texto += conteudo.comandos.join(' ') + ' ';
        if (conteudo.palavras_chave) texto += conteudo.palavras_chave.join(' ') + ' ';
        
        return texto;
    }
    
    exibirResultados() {
        const container = document.querySelector('.resultados-container');
        if (!container) {
            this.criarContainerResultados();
            return;
        }
        
        container.innerHTML = '';
        
        if (this.resultadosFiltrados.length === 0) {
            container.innerHTML = `
                <div class="sem-resultados">
                    <i class="fas fa-search"></i>
                    <h3>Nenhum resultado encontrado</h3>
                    <p>Tente ajustar os filtros ou termo de busca</p>
                </div>
            `;
            return;
        }
        
        // Agrupar por módulo
        const conteudosPorModulo = this.agruparPorModulo(this.resultadosFiltrados);
        
        for (const [modulo, conteudos] of Object.entries(conteudosPorModulo)) {
            const secaoModulo = this.criarSecaoModulo(modulo, conteudos);
            container.appendChild(secaoModulo);
        }
    }
    
    agruparPorModulo(conteudos) {
        const agrupados = {};
        
        for (const conteudo of conteudos) {
            const modulo = conteudo.modulo || conteudo.modulo_relevante;
            if (!agrupados[modulo]) {
                agrupados[modulo] = [];
            }
            agrupados[modulo].push(conteudo);
        }
        
        return agrupados;
    }
    
    criarSecaoModulo(modulo, conteudos) {
        const secao = document.createElement('div');
        secao.className = 'modulo-section';
        secao.setAttribute('data-modulo', modulo);
        
        const nomeModulo = this.formatarNomeModulo(modulo);
        const estatisticas = this.calcularEstatisticasModulo(conteudos);
        
        secao.innerHTML = `
            <div class="modulo-header">
                <div class="modulo-icon">
                    <i class="${this.obterIconeModulo(modulo)}"></i>
                </div>
                <div>
                    <h2 class="modulo-title">${nomeModulo}</h2>
                    <div class="modulo-stats">
                        <div class="stat-item">
                            <i class="fas fa-file-alt"></i>
                            <span>${conteudos.length} conteúdos</span>
                        </div>
                        <div class="stat-item">
                            <i class="fas fa-code"></i>
                            <span>${estatisticas.totalComandos} comandos</span>
                        </div>
                        <div class="stat-item">
                            <i class="fas fa-star"></i>
                            <span>Score: ${estatisticas.scoreTotal}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="conteudo-grid">
                ${conteudos.map(conteudo => this.criarCardConteudo(conteudo)).join('')}
            </div>
        `;
        
        return secao;
    }
    
    formatarNomeModulo(modulo) {
        const nomes = {
            'modulo1_fundamentos': 'Módulo 1: Fundamentos Linux',
            'modulo2_redes': 'Módulo 2: Redes e Segurança',
            'modulo3_administracao_redes': 'Módulo 3: Administração de Redes',
            'modulo4_administracao_sistemas': 'Módulo 4: Administração de Sistemas',
            'modulo5_seguranca_redes': 'Módulo 5: Segurança de Redes',
            'modulo6_observabilidade': 'Módulo 6: Observabilidade'
        };
        
        return nomes[modulo] || modulo.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase());
    }
    
    obterIconeModulo(modulo) {
        const icones = {
            'modulo1_fundamentos': 'fas fa-terminal',
            'modulo2_redes': 'fas fa-network-wired',
            'modulo3_administracao_redes': 'fas fa-server',
            'modulo4_administracao_sistemas': 'fas fa-cogs',
            'modulo5_seguranca_redes': 'fas fa-shield-alt',
            'modulo6_observabilidade': 'fas fa-chart-line'
        };
        
        return icones[modulo] || 'fas fa-file-alt';
    }
    
    calcularEstatisticasModulo(conteudos) {
        let totalComandos = 0;
        let scoreTotal = 0;
        
        for (const conteudo of conteudos) {
            totalComandos += conteudo.comandos ? conteudo.comandos.length : 0;
            scoreTotal += conteudo.score_relevancia || 0;
        }
        
        return { totalComandos, scoreTotal };
    }
    
    criarCardConteudo(conteudo) {
        const nivel = this.determinarNivelConteudo(conteudo);
        const comandosPreview = this.extrairComandosPreview(conteudo);
        
        return `
            <div class="conteudo-card" data-nivel="${nivel}">
                <span class="nivel-badge nivel-${nivel}">${nivel.charAt(0).toUpperCase() + nivel.slice(1)}</span>
                <h4>${conteudo.titulo}</h4>
                <p>${this.extrairDescricao(conteudo)}</p>
                ${comandosPreview ? `
                    <div class="comandos-preview">
                        <code>${comandosPreview}</code>
                    </div>
                ` : ''}
                <div class="acoes-card">
                    <button class="btn-sm btn-primary" onclick="materialApoio.exibirDetalhes('${conteudo.arquivo}')">
                        <i class="fas fa-eye"></i> Ver Detalhes
                    </button>
                    <button class="btn-sm btn-outline" onclick="materialApoio.copiarComandos('${conteudo.arquivo}')">
                        <i class="fas fa-copy"></i> Copiar Comandos
                    </button>
                </div>
            </div>
        `;
    }
    
    extrairComandosPreview(conteudo) {
        if (!conteudo.comandos || conteudo.comandos.length === 0) {
            return '';
        }
        
        const comandos = conteudo.comandos.slice(0, 2); // Apenas 2 comandos para preview
        return comandos.map(cmd => {
            let comandoLimpo = cmd.replace(/<[^>]+>/g, '').trim();
            if (comandoLimpo.length > 40) {
                comandoLimpo = comandoLimpo.substring(0, 40) + '...';
            }
            return comandoLimpo;
        }).join('<br>');
    }
    
    extrairDescricao(conteudo) {
        if (conteudo.headers && conteudo.headers.length > 0) {
            return conteudo.headers[0];
        }
        return conteudo.titulo || 'Conteúdo do material FOCA Linux';
    }
    
    criarContainerResultados() {
        const container = document.createElement('div');
        container.className = 'resultados-container';
        
        const mainContainer = document.querySelector('.material-apoio-container');
        if (mainContainer) {
            mainContainer.appendChild(container);
        }
    }
    
    exibirTodosConteudos() {
        this.resultadosFiltrados = [];
        
        for (const modulo in this.dadosCompletos) {
            for (const conteudo of this.dadosCompletos[modulo]) {
                this.resultadosFiltrados.push({
                    ...conteudo,
                    modulo: modulo
                });
            }
        }
        
        this.exibirResultados();
        this.atualizarEstatisticas();
    }
    
    atualizarEstatisticas() {
        const total = this.resultadosFiltrados.length;
        const comandos = this.resultadosFiltrados.reduce((acc, conteudo) => {
            return acc + (conteudo.comandos ? conteudo.comandos.length : 0);
        }, 0);
        
        const contador = document.querySelector('.contador-resultados span');
        if (contador) {
            contador.textContent = `${total} conteúdos encontrados (${comandos} comandos)`;
        }
    }
    
    exibirDetalhes(arquivo) {
        const conteudo = this.encontrarConteudoPorArquivo(arquivo);
        if (!conteudo) {
            alert('Conteúdo não encontrado');
            return;
        }
        
        this.criarModalDetalhes(conteudo);
    }
    
    encontrarConteudoPorArquivo(arquivo) {
        for (const modulo in this.dadosCompletos) {
            for (const conteudo of this.dadosCompletos[modulo]) {
                if (conteudo.arquivo === arquivo) {
                    return conteudo;
                }
            }
        }
        return null;
    }
    
    criarModalDetalhes(conteudo) {
        const modal = document.createElement('div');
        modal.className = 'modal-detalhes';
        modal.innerHTML = `
            <div class="modal-content">
                <div class="modal-header">
                    <h3>${conteudo.titulo}</h3>
                    <button class="btn-close" onclick="this.parentElement.parentElement.remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="conteudo-detalhado">
                        <h4>Conceitos Principais:</h4>
                        <ul>
                            ${conteudo.headers ? conteudo.headers.map(h => `<li>${h}</li>`).join('') : ''}
                        </ul>
                        
                        <h4>Comandos Relacionados:</h4>
                        <div class="comandos-detalhados">
                            ${conteudo.comandos ? conteudo.comandos.map(cmd => 
                                `<div class="comando-item">
                                    <code>${cmd}</code>
                                    <button class="btn-copy" onclick="navigator.clipboard.writeText('${cmd.replace(/'/g, "\\'")}')">
                                        <i class="fas fa-copy"></i>
                                    </button>
                                </div>`
                            ).join('') : ''}
                        </div>
                        
                        <h4>Informações:</h4>
                        <div class="info-detalhada">
                            <p><strong>Arquivo:</strong> ${conteudo.arquivo}</p>
                            <p><strong>Score de Relevância:</strong> ${conteudo.score_relevancia}</p>
                            <p><strong>Módulo:</strong> ${this.formatarNomeModulo(conteudo.modulo_relevante)}</p>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
    }
    
    copiarComandos(arquivo) {
        const conteudo = this.encontrarConteudoPorArquivo(arquivo);
        if (!conteudo || !conteudo.comandos) {
            alert('Nenhum comando encontrado');
            return;
        }
        
        const comandosTexto = conteudo.comandos.join('\n');
        navigator.clipboard.writeText(comandosTexto).then(() => {
            this.mostrarNotificacao('Comandos copiados para a área de transferência!', 'success');
        }).catch(() => {
            alert('Erro ao copiar comandos');
        });
    }
    
    mostrarNotificacao(mensagem, tipo = 'info') {
        const notificacao = document.createElement('div');
        notificacao.className = `notificacao notificacao-${tipo}`;
        notificacao.textContent = mensagem;
        
        document.body.appendChild(notificacao);
        
        setTimeout(() => {
            notificacao.remove();
        }, 3000);
    }
}

// Inicializar instantaneamente
document.addEventListener('DOMContentLoaded', () => {
    window.materialApoio = new MaterialApoioSuperOtimizado();
});
