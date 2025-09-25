#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Sistema de Extração e Integração de Conteúdo GNU-Linux
Ministério das Finanças de Angola - Treinamento Linux Avançado
"""

import os
import sys
import json
import re
from pathlib import Path
from typing import Dict, List, Any
import logging

# Configurar logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class ExtratorConteudoGNU:
    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.conteudo_extraido = {
            'modulo1_fundamentos': [],
            'modulo2_redes': [],
            'modulo3_administracao_redes': [],
            'modulo4_administracao_sistemas': []
        }
        
    def mapear_arquivos(self) -> Dict[str, List[str]]:
        """Mapeia arquivos por módulo baseado no nome"""
        mapeamento = {
            'modulo1_fundamentos': [],
            'modulo2_redes': [],
            'modulo3_administracao_redes': [],
            'modulo4_administracao_sistemas': []
        }
        
        # Padrões de mapeamento baseados no nome dos arquivos
        padroes = {
            'modulo1_fundamentos': [
                'Conceitos', 'Comandos Básicos', 'Visualizadores', 'Concatenação',
                'Permissões', 'Processos', 'Armazenamento', 'Editor VI'
            ],
            'modulo2_redes': [
                'Network', 'Client DNS', 'Gerenciamento de Pacotes', 'DNS Server'
            ],
            'modulo3_administracao_redes': [
                'HTTP Apache', 'FTP e SSH', 'Proxy Cache', 'Proxy Reverso',
                'DHCPD', 'SAMBA'
            ],
            'modulo4_administracao_sistemas': [
                'Backup', 'Shell Script', 'MySQL', 'Instalação'
            ]
        }
        
        for arquivo in self.base_path.rglob("*.pptx"):
            nome_arquivo = arquivo.name.lower()
            for modulo, palavras_chave in padroes.items():
                for palavra in palavras_chave:
                    if palavra.lower() in nome_arquivo:
                        mapeamento[modulo].append(str(arquivo))
                        break
        
        return mapeamento
    
    def extrair_texto_pptx(self, arquivo_path: str) -> str:
        """Extrai texto de arquivos PowerPoint"""
        try:
            # Para arquivos .pptx, vamos usar uma abordagem simples
            # Em produção, usaria python-pptx ou similar
            logger.info(f"Processando: {arquivo_path}")
            
            # Por enquanto, retornamos informações básicas do arquivo
            # Em uma implementação completa, extrairíamos o texto real
            nome_arquivo = Path(arquivo_path).name
            return f"Conteúdo extraído de: {nome_arquivo}"
            
        except Exception as e:
            logger.error(f"Erro ao processar {arquivo_path}: {e}")
            return ""
    
    def processar_semestre(self, semestre_path: str) -> Dict[str, Any]:
        """Processa conteúdo de um semestre"""
        semestre = Path(semestre_path)
        conteudo_semestre = {
            'nome': semestre.name,
            'aulas': []
        }
        
        for arquivo in semestre.glob("*.pptx"):
            aula_info = {
                'arquivo': str(arquivo),
                'nome': arquivo.stem,
                'conteudo': self.extrair_texto_pptx(str(arquivo)),
                'tamanho': arquivo.stat().st_size,
                'modificacao': arquivo.stat().st_mtime
            }
            conteudo_semestre['aulas'].append(aula_info)
        
        return conteudo_semestre
    
    def gerar_estrutura_html(self, conteudo: Dict[str, Any]) -> str:
        """Gera estrutura HTML para o conteúdo extraído"""
        html = f"""
        <div class="slide">
            <h2><i class="fas fa-graduation-cap"></i> {conteudo['nome']}</h2>
            <div class="info-box">
                <strong>📚 Conteúdo Adicional:</strong> Material complementar do curso GNU-Linux
            </div>
        """
        
        for aula in conteudo['aulas']:
            html += f"""
            <div class="exercise-integration">
                <h4><i class="fas fa-file-powerpoint"></i> {aula['nome']}</h4>
                <p><strong>Arquivo:</strong> {Path(aula['arquivo']).name}</p>
                <p><strong>Tamanho:</strong> {aula['tamanho']} bytes</p>
                <p><strong>Conteúdo:</strong> {aula['conteudo']}</p>
            </div>
            """
        
        html += "</div>"
        return html
    
    def integrar_modulo(self, modulo: str, conteudo: Dict[str, Any]) -> str:
        """Integra conteúdo no módulo específico"""
        html_integrado = self.gerar_estrutura_html(conteudo)
        
        # Aqui você pode adicionar lógica específica para cada módulo
        if modulo == 'modulo1_fundamentos':
            return f"""
            <!-- Conteúdo Adicional - GNU-Linux Fundamentos -->
            {html_integrado}
            """
        elif modulo == 'modulo2_redes':
            return f"""
            <!-- Conteúdo Adicional - Redes e Segurança -->
            {html_integrado}
            """
        # ... outros módulos
        
        return html_integrado
    
    def processar_todo_conteudo(self) -> Dict[str, Any]:
        """Processa todo o conteúdo disponível"""
        logger.info("Iniciando processamento do conteúdo GNU-Linux...")
        
        # Mapear arquivos
        mapeamento = self.mapear_arquivos()
        
        # Processar cada semestre
        semestres = ['Semestre 1', 'Semestre 2']
        conteudo_processado = {}
        
        for semestre in semestres:
            semestre_path = self.base_path / semestre
            if semestre_path.exists():
                conteudo_processado[semestre] = self.processar_semestre(str(semestre_path))
        
        return conteudo_processado
    
    def gerar_relatorio(self, conteudo: Dict[str, Any]) -> str:
        """Gera relatório do processamento"""
        relatorio = f"""
# RELATÓRIO DE EXTRAÇÃO DE CONTEÚDO GNU-LINUX
## Ministério das Finanças de Angola - Treinamento Linux Avançado

### Resumo do Processamento
- **Total de Semestres:** {len(conteudo)}
- **Data de Processamento:** {os.popen('date').read().strip()}

### Conteúdo Processado por Semestre
"""
        
        for semestre, dados in conteudo.items():
            relatorio += f"""
#### {semestre}
- **Total de Aulas:** {len(dados['aulas'])}
- **Arquivos Processados:**
"""
            for aula in dados['aulas']:
                relatorio += f"  - {aula['nome']} ({aula['tamanho']} bytes)\n"
        
        return relatorio

def main():
    """Função principal"""
    base_path = "/Users/imac/LinuxAvançado/Administracao de Sistemas GNU-LinuxFundamentos e Pratica"
    
    if not os.path.exists(base_path):
        logger.error(f"Caminho não encontrado: {base_path}")
        return
    
    # Criar extrator
    extrator = ExtratorConteudoGNU(base_path)
    
    # Processar conteúdo
    conteudo = extrator.processar_todo_conteudo()
    
    # Gerar relatório
    relatorio = extrator.gerar_relatorio(conteudo)
    
    # Salvar relatório
    with open('/Users/imac/LinuxAvançado/relatorio_extracao.md', 'w', encoding='utf-8') as f:
        f.write(relatorio)
    
    # Salvar dados processados
    with open('/Users/imac/LinuxAvançado/conteudo_processado.json', 'w', encoding='utf-8') as f:
        json.dump(conteudo, f, ensure_ascii=False, indent=2)
    
    logger.info("Processamento concluído!")
    logger.info(f"Relatório salvo em: /Users/imac/LinuxAvançado/relatorio_extracao.md")
    logger.info(f"Dados salvos em: /Users/imac/LinuxAvançado/conteudo_processado.json")

if __name__ == "__main__":
    main()
