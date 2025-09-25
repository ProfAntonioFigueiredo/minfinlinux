/**
 * Sistema de Busca Funcional - Material de Apoio FOCA Linux
 * Ministério das Finanças de Angola
 */

class MaterialApoioSearch {
    constructor() {
        this.dadosCompletos = null;
        this.resultadosFiltrados = [];
        this.filtroAtual = 'todos';
        this.termoBusca = '';
        
        this.init();
    }
    
    async init() {
        try {
            await this.carregarDados();
            this.configurarEventos();
            this.exibirTodosConteudos();
            console.log('✅ Sistema de busca inicializado com sucesso!');
        } catch (error) {
            console.error('❌ Erro ao inicializar sistema de busca:', error);
            this.exibirErro('Erro ao carregar dados do material de apoio');
        }
    }
    
    async carregarDados() {
        try {
            // Carregar dados de conteúdo prioritário
            const response = await fetch('analise_focalinux/conteudo_prioritario.json');
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            
            this.dadosCompletos = await response.json();
            console.log('📊 Dados carregados:', this.contarTotalConteudos());
            
        } catch (error) {
            console.error('Erro ao carregar dados:', error);
            // Fallback: criar dados de exemplo se não conseguir carregar
            this.dadosCompletos = this.criarDadosExemplo();
        }
    }
    
    contarTotalConteudos() {
        let total = 0;
        for (const modulo in this.dadosCompletos) {
            total += this.dadosCompletos[modulo].length;
        }
        return {
            totalConteudos: total,
            totalModulos: Object.keys(this.dadosCompletos).length,
            totalComandos: this.contarTotalComandos()
        };
    }
    
    contarTotalComandos() {
        let total = 0;
        for (const modulo in this.dadosCompletos) {
            for (const conteudo of this.dadosCompletos[modulo]) {
                total += conteudo.comandos ? conteudo.comandos.length : 0;
            }
        }
        return total;
    }
    
    configurarEventos() {
        // Busca em tempo real
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.termoBusca = e.target.value.toLowerCase();
                this.aplicarFiltros();
            });
        }
        
        // Filtros por nível
        document.querySelectorAll('.filtro-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                // Remover active de todos
                document.querySelectorAll('.filtro-btn').forEach(b => b.classList.remove('active'));
                // Adicionar active ao clicado
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
        
        if (textoCompleto.includes('avancado') || textoCompleto.includes('complexo')) {
            return 'avancado';
        } else if (textoCompleto.includes('seguranca') || textoCompleto.includes('firewall')) {
            return 'seguranca';
        } else if (textoCompleto.includes('intermediario') || textoCompleto.includes('configuracao')) {
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
        
        // Pegar os primeiros 3 comandos mais relevantes
        const comandos = conteudo.comandos.slice(0, 3);
        return comandos.map(cmd => {
            // Limpar comando
            let comandoLimpo = cmd.replace(/<[^>]+>/g, '').trim();
            if (comandoLimpo.length > 50) {
                comandoLimpo = comandoLimpo.substring(0, 50) + '...';
            }
            return comandoLimpo;
        }).join('<br>');
    }
    
    extrairDescricao(conteudo) {
        if (conteudo.headers && conteudo.headers.length > 0) {
            return conteudo.headers[0];
        }
        
        if (conteudo.titulo) {
            return conteudo.titulo;
        }
        
        return 'Conteúdo do material FOCA Linux';
    }
    
    criarContainerResultados() {
        const container = document.createElement('div');
        container.className = 'resultados-container';
        container.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i> Carregando conteúdo...</div>';
        
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
        
        // Atualizar contador na interface se existir
        const contador = document.querySelector('.contador-resultados');
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
    
    exibirErro(mensagem) {
        const container = document.querySelector('.material-apoio-container');
        if (container) {
            container.innerHTML = `
                <div class="erro-container">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Erro ao carregar material de apoio</h3>
                    <p>${mensagem}</p>
                    <button onclick="location.reload()" class="btn btn-primary">
                        <i class="fas fa-refresh"></i> Tentar Novamente
                    </button>
                </div>
            `;
        }
    }
    
    criarDadosExemplo() {
        return {
            "modulo1_fundamentos": [
                {
                    "arquivo": "exemplo.html",
                    "titulo": "Exemplo de Conteúdo",
                    "headers": ["Exemplo de cabeçalho"],
                    "comandos": ["ls -la", "pwd"],
                    "modulo_relevante": "modulo1_fundamentos",
                    "score_relevancia": 5
                }
            ]
        };
    }
}

// Inicializar quando a página carregar
document.addEventListener('DOMContentLoaded', () => {
    window.materialApoio = new MaterialApoioSearch();
});
