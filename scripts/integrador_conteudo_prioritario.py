#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Integrador de Conteúdo Prioritário FOCA Linux
Ministério das Finanças de Angola - Treinamento Linux Avançado
"""

import os
import json
import re
from pathlib import Path
from typing import Dict, List, Any
import logging

# Configurar logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class IntegradorConteudoPrioritario:
    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.plataforma_path = self.base_path / "plataforma"
        self.analise_path = self.base_path / "analise_focalinux"
        
        # Carregar análise
        self.conteudo_prioritario = self.carregar_analise()
        
        # Mapeamento de módulos para diretórios da plataforma
        self.mapeamento_diretorios = {
            'modulo1_fundamentos': 'modulos/modulo1_fundamentos_linux',
            'modulo2_redes': 'modulos/modulo2_redes_seguranca',
            'modulo3_administracao_redes': 'modulos/modulo3_administracao_redes',
            'modulo4_administracao_sistemas': 'modulos/modulo4_administracao_sistemas',
            'modulo5_seguranca_redes': 'modulos/modulo5_seguranca_redes',
            'modulo6_observabilidade': 'modulos/modulo6_observabilidade'
        }
    
    def carregar_analise(self) -> Dict[str, List[Dict]]:
        """Carrega a análise de conteúdo prioritário"""
        try:
            with open(self.analise_path / "conteudo_prioritario.json", 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception as e:
            logger.error(f"Erro ao carregar análise: {e}")
            return {}
    
    def extrair_conteudo_html(self, arquivo_path: str) -> str:
        """Extrai conteúdo limpo do HTML"""
        try:
            with open(arquivo_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # Remover tags HTML e extrair texto
            content = re.sub(r'<script[^>]*>.*?</script>', '', content, flags=re.DOTALL)
            content = re.sub(r'<style[^>]*>.*?</style>', '', content, flags=re.DOTALL)
            content = re.sub(r'<[^>]+>', '', content)
            content = re.sub(r'\s+', ' ', content)
            
            return content.strip()
        except Exception as e:
            logger.error(f"Erro ao extrair conteúdo de {arquivo_path}: {e}")
            return ""
    
    def gerar_html_conteudo(self, conteudo: Dict[str, Any]) -> str:
        """Gera HTML para um conteúdo específico"""
        # Extrair conteúdo completo do arquivo
        conteudo_completo = self.extrair_conteudo_html(conteudo['arquivo'])
        
        # Limitar tamanho do conteúdo
        if len(conteudo_completo) > 2000:
            conteudo_completo = conteudo_completo[:2000] + "..."
        
        html = f"""
        <div class="focalinux-content">
            <div class="content-header">
                <h3><i class="fas fa-file-alt"></i> {conteudo['titulo']}</h3>
                <div class="content-meta">
                    <span class="score">Score: {conteudo['score_relevancia']}</span>
                    <span class="comandos">{len(conteudo['comandos'])} comandos</span>
                </div>
            </div>
            
            <div class="content-body">
                <h4>Conceitos Principais:</h4>
                <ul>
        """
        
        # Adicionar headers como conceitos
        for header in conteudo['headers'][:5]:
            html += f"<li>{header}</li>"
        
        html += """
                </ul>
                
                <h4>Comandos Relacionados:</h4>
                <div class="comandos-section">
        """
        
        # Adicionar comandos
        for comando in conteudo['comandos'][:10]:
            html += f'<code class="comando">{comando}</code>'
        
        html += """
                </div>
                
                <h4>Conteúdo Detalhado:</h4>
                <div class="conteudo-detalhado">
        """
        
        # Adicionar conteúdo detalhado (primeiros 500 caracteres)
        conteudo_resumido = conteudo_completo[:500] + "..." if len(conteudo_completo) > 500 else conteudo_completo
        html += f"<p>{conteudo_resumido}</p>"
        
        html += """
                </div>
                
                <div class="content-actions">
                    <button class="btn btn-primary" onclick="abrirArquivoOriginal('""" + conteudo['arquivo'] + """')">
                        <i class="fas fa-external-link-alt"></i> Ver Arquivo Original
                    </button>
                    <button class="btn btn-outline" onclick="copiarComandos()">
                        <i class="fas fa-copy"></i> Copiar Comandos
                    </button>
                </div>
            </div>
        </div>
        """
        
        return html
    
    def integrar_modulo5_seguranca(self) -> None:
        """Integra conteúdo de segurança no Módulo 5"""
        logger.info("Integrando conteúdo de segurança no Módulo 5...")
        
        # Buscar conteúdo de segurança de outros módulos
        conteudo_seguranca = []
        
        for modulo, conteudos in self.conteudo_prioritario.items():
            for conteudo in conteudos:
                if 'seguranca' in conteudo['palavras_chave'] or 'firewall' in conteudo['palavras_chave']:
                    conteudo_seguranca.append(conteudo)
        
        if not conteudo_seguranca:
            logger.warning("Nenhum conteúdo de segurança encontrado!")
            return
        
        # Ordenar por relevância
        conteudo_seguranca.sort(key=lambda x: x['score_relevancia'], reverse=True)
        
        # Gerar HTML para o módulo 5
        html_content = """
        <div class="slide">
            <h2><i class="fas fa-shield-alt"></i> Material de Apoio - Segurança de Redes</h2>
            <div class="info-box">
                <strong>📚 Conteúdo FOCA Linux:</strong> Material complementar extraído do FOCA Linux 
                para fortalecer o Módulo 5 - Segurança de Redes.
            </div>
        """
        
        for conteudo in conteudo_seguranca[:10]:  # Top 10
            html_content += self.gerar_html_conteudo(conteudo)
        
        html_content += """
        </div>
        """
        
        # Salvar arquivo
        modulo5_path = self.plataforma_path / "modulos/modulo5_seguranca_redes/apresentacoes"
        modulo5_path.mkdir(parents=True, exist_ok=True)
        
        with open(modulo5_path / "modulo5_material_apoio_seguranca.html", 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        logger.info(f"Material de segurança salvo em: {modulo5_path}")
    
    def integrar_modulo6_observabilidade(self) -> None:
        """Integra conteúdo de observabilidade no Módulo 6"""
        logger.info("Integrando conteúdo de observabilidade no Módulo 6...")
        
        # Buscar conteúdo relacionado a monitoramento e logs
        conteudo_observabilidade = []
        
        for modulo, conteudos in self.conteudo_prioritario.items():
            for conteudo in conteudos:
                if any(palavra in conteudo['palavras_chave'] for palavra in 
                      ['log', 'monitoramento', 'metricas', 'alertas', 'dashboard']):
                    conteudo_observabilidade.append(conteudo)
        
        if not conteudo_observabilidade:
            logger.warning("Nenhum conteúdo de observabilidade encontrado!")
            return
        
        # Ordenar por relevância
        conteudo_observabilidade.sort(key=lambda x: x['score_relevancia'], reverse=True)
        
        # Gerar HTML para o módulo 6
        html_content = """
        <div class="slide">
            <h2><i class="fas fa-chart-line"></i> Material de Apoio - Observabilidade</h2>
            <div class="info-box">
                <strong>📚 Conteúdo FOCA Linux:</strong> Material complementar extraído do FOCA Linux 
                para fortalecer o Módulo 6 - Observabilidade.
            </div>
        """
        
        for conteudo in conteudo_observabilidade[:10]:  # Top 10
            html_content += self.gerar_html_conteudo(conteudo)
        
        html_content += """
        </div>
        """
        
        # Salvar arquivo
        modulo6_path = self.plataforma_path / "modulos/modulo6_observabilidade/apresentacoes"
        modulo6_path.mkdir(parents=True, exist_ok=True)
        
        with open(modulo6_path / "modulo6_material_apoio_observabilidade.html", 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        logger.info(f"Material de observabilidade salvo em: {modulo6_path}")
    
    def criar_css_material_apoio(self) -> None:
        """Cria CSS específico para material de apoio"""
        css_content = """
        /* Material de Apoio FOCA Linux */
        .focalinux-content {
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 1.5rem;
            margin: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #3498db;
        }
        
        .content-header h3 {
            margin: 0;
            color: #2c3e50;
            font-size: 1.2rem;
        }
        
        .content-meta {
            display: flex;
            gap: 1rem;
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .score {
            background: #e3f2fd;
            color: #1976d2;
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            font-weight: 600;
        }
        
        .comandos {
            background: #e8f5e8;
            color: #2e7d32;
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            font-weight: 600;
        }
        
        .content-body h4 {
            color: #2c3e50;
            margin: 1rem 0 0.5rem 0;
            font-size: 1rem;
        }
        
        .comandos-section {
            background: #2c3e50;
            color: #ecf0f1;
            padding: 1rem;
            border-radius: 8px;
            margin: 0.5rem 0;
            font-family: 'Courier New', monospace;
        }
        
        .comando {
            display: block;
            margin: 0.3rem 0;
            padding: 0.3rem;
            background: #34495e;
            border-radius: 4px;
            color: #2ecc71;
        }
        
        .conteudo-detalhado {
            background: white;
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid #3498db;
            margin: 0.5rem 0;
        }
        
        .content-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-1px);
        }
        
        .btn-outline {
            background: transparent;
            color: #3498db;
            border: 1px solid #3498db;
        }
        
        .btn-outline:hover {
            background: #3498db;
            color: white;
        }
        
        @media (max-width: 768px) {
            .content-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .content-meta {
                flex-direction: column;
                gap: 0.3rem;
            }
            
            .content-actions {
                flex-direction: column;
            }
        }
        """
        
        css_path = self.plataforma_path / "assets/css/material-apoio.css"
        with open(css_path, 'w', encoding='utf-8') as f:
            f.write(css_content)
        
        logger.info(f"CSS do material de apoio salvo em: {css_path}")
    
    def integrar_todo_conteudo_prioritario(self) -> None:
        """Integra todo o conteúdo prioritário identificado"""
        logger.info("Iniciando integração de conteúdo prioritário...")
        
        # Criar CSS
        self.criar_css_material_apoio()
        
        # Integrar módulos críticos
        self.integrar_modulo5_seguranca()
        self.integrar_modulo6_observabilidade()
        
        # Integrar conteúdo adicional nos outros módulos
        for modulo, conteudos in self.conteudo_prioritario.items():
            if modulo not in ['modulo5_seguranca_redes', 'modulo6_observabilidade']:
                self.integrar_conteudo_modulo(modulo, conteudos)
        
        logger.info("Integração de conteúdo prioritário concluída!")
    
    def integrar_conteudo_modulo(self, modulo: str, conteudos: List[Dict]) -> None:
        """Integra conteúdo em um módulo específico"""
        if not conteudos:
            return
        
        logger.info(f"Integrando {len(conteudos)} conteúdos no {modulo}...")
        
        # Pegar top 5 conteúdos mais relevantes
        conteudos_top = sorted(conteudos, key=lambda x: x['score_relevancia'], reverse=True)[:5]
        
        html_content = f"""
        <div class="slide">
            <h2><i class="fas fa-plus-circle"></i> Material de Apoio FOCA Linux - {modulo.replace('_', ' ').title()}</h2>
            <div class="info-box">
                <strong>📚 Conteúdo Complementar:</strong> Material adicional extraído do FOCA Linux 
                para enriquecer o aprendizado.
            </div>
        """
        
        for conteudo in conteudos_top:
            html_content += self.gerar_html_conteudo(conteudo)
        
        html_content += """
        </div>
        """
        
        # Salvar arquivo
        modulo_path = self.plataforma_path / self.mapeamento_diretorios[modulo] / "apresentacoes"
        modulo_path.mkdir(parents=True, exist_ok=True)
        
        arquivo_nome = f"{modulo}_material_apoio_focalinux.html"
        with open(modulo_path / arquivo_nome, 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        logger.info(f"Material de apoio salvo em: {modulo_path / arquivo_nome}")

def main():
    """Função principal"""
    base_path = "/Users/imac/LinuxAvançado"
    
    # Criar integrador
    integrador = IntegradorConteudoPrioritario(base_path)
    
    # Integrar todo o conteúdo prioritário
    integrador.integrar_todo_conteudo_prioritario()
    
    print("\n" + "="*80)
    print("INTEGRAÇÃO DE CONTEÚDO PRIORITÁRIO CONCLUÍDA!")
    print("="*80)
    print("✅ Material de apoio criado para todos os módulos")
    print("✅ Módulo 5 (Segurança) reforçado")
    print("✅ Módulo 6 (Observabilidade) reforçado")
    print("✅ CSS específico criado")
    print("✅ Arquivos HTML gerados na plataforma")

if __name__ == "__main__":
    main()
