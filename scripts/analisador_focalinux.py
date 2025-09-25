#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Analisador de Conteúdo FOCA Linux
Ministério das Finanças de Angola - Treinamento Linux Avançado
"""

import os
import re
import json
from pathlib import Path
from typing import Dict, List, Any, Tuple
import logging
from bs4 import BeautifulSoup

# Configurar logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class AnalisadorFOCALinux:
    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.conteudo_analisado = {
            'iniciante': {'total_arquivos': 0, 'conteudo': []},
            'intermediario': {'total_arquivos': 0, 'conteudo': []},
            'avancado': {'total_arquivos': 0, 'conteudo': []},
            'seguranca': {'total_arquivos': 0, 'conteudo': []}
        }
        
        # Mapeamento de tópicos para módulos
        self.mapeamento_modulos = {
            'modulo1_fundamentos': [
                'comandos', 'arquivos', 'diretorios', 'permissoes', 'usuarios', 'grupos',
                'processos', 'shell', 'bash', 'terminal', 'navegacao', 'manipulacao'
            ],
            'modulo2_redes': [
                'rede', 'network', 'ip', 'dns', 'dhcp', 'roteamento', 'subnet',
                'protocolo', 'conexao', 'interface', 'configuracao'
            ],
            'modulo3_administracao_redes': [
                'servidor', 'apache', 'nginx', 'ftp', 'ssh', 'samba', 'nfs',
                'proxy', 'cache', 'load', 'balance', 'cluster'
            ],
            'modulo4_administracao_sistemas': [
                'pacotes', 'apt', 'yum', 'rpm', 'dpkg', 'repositorio', 'dependencias',
                'backup', 'restore', 'cron', 'systemd', 'log', 'monitoramento'
            ],
            'modulo5_seguranca_redes': [
                'seguranca', 'firewall', 'iptables', 'ufw', 'selinux', 'apparmor',
                'audit', 'log', 'intrusao', 'vulnerabilidade', 'patch', 'hardening'
            ],
            'modulo6_observabilidade': [
                'log', 'monitoramento', 'metricas', 'alertas', 'dashboard', 'grafana',
                'prometheus', 'elasticsearch', 'kibana', 'logstash', 'elk'
            ]
        }
        
        # Palavras-chave de nível de complexidade
        self.niveis_complexidade = {
            'basico': ['introducao', 'basico', 'simples', 'primeiro', 'inicial'],
            'intermediario': ['intermediario', 'medio', 'configuracao', 'administracao'],
            'avancado': ['avancado', 'complexo', 'otimizacao', 'performance', 'cluster'],
            'seguranca': ['seguranca', 'firewall', 'audit', 'vulnerabilidade', 'hardening']
        }
    
    def analisar_arquivo_html(self, arquivo_path: str) -> Dict[str, Any]:
        """Analisa um arquivo HTML individual"""
        try:
            with open(arquivo_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            soup = BeautifulSoup(content, 'html.parser')
            
            # Extrair título
            title = soup.find('title')
            title_text = title.get_text().strip() if title else 'Sem título'
            
            # Extrair cabeçalhos
            headers = []
            for tag in ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']:
                headers.extend([h.get_text().strip() for h in soup.find_all(tag)])
            
            # Extrair parágrafos
            paragraphs = [p.get_text().strip() for p in soup.find_all('p') if p.get_text().strip()]
            
            # Extrair código
            code_blocks = []
            for pre in soup.find_all('pre'):
                code_blocks.append(pre.get_text().strip())
            
            # Extrair listas
            lists = []
            for ul in soup.find_all(['ul', 'ol']):
                items = [li.get_text().strip() for li in ul.find_all('li')]
                lists.extend(items)
            
            # Determinar módulo relevante
            modulo_relevante = self.determinar_modulo_relevante(title_text, headers, paragraphs)
            
            # Determinar nível de complexidade
            nivel_complexidade = self.determinar_nivel_complexidade(title_text, headers, paragraphs)
            
            # Extrair comandos
            comandos = self.extrair_comandos(content)
            
            return {
                'arquivo': str(arquivo_path),
                'titulo': title_text,
                'headers': headers,
                'paragrafos': paragraphs[:5],  # Primeiros 5 parágrafos
                'codigo': code_blocks[:3],     # Primeiros 3 blocos de código
                'listas': lists[:10],          # Primeiras 10 listas
                'comandos': comandos,
                'modulo_relevante': modulo_relevante,
                'nivel_complexidade': nivel_complexidade,
                'tamanho': len(content),
                'palavras_chave': self.extrair_palavras_chave(title_text, headers, paragraphs)
            }
            
        except Exception as e:
            logger.error(f"Erro ao analisar {arquivo_path}: {e}")
            return None
    
    def determinar_modulo_relevante(self, titulo: str, headers: List[str], paragraphs: List[str]) -> str:
        """Determina qual módulo é mais relevante para o conteúdo"""
        texto_completo = f"{titulo} {' '.join(headers)} {' '.join(paragraphs)}".lower()
        
        scores = {}
        for modulo, palavras_chave in self.mapeamento_modulos.items():
            score = sum(1 for palavra in palavras_chave if palavra in texto_completo)
            scores[modulo] = score
        
        # Retornar módulo com maior score
        if scores:
            return max(scores, key=scores.get)
        return 'modulo1_fundamentos'  # Padrão
    
    def determinar_nivel_complexidade(self, titulo: str, headers: List[str], paragraphs: List[str]) -> str:
        """Determina o nível de complexidade do conteúdo"""
        texto_completo = f"{titulo} {' '.join(headers)} {' '.join(paragraphs)}".lower()
        
        scores = {}
        for nivel, palavras in self.niveis_complexidade.items():
            score = sum(1 for palavra in palavras if palavra in texto_completo)
            scores[nivel] = score
        
        # Retornar nível com maior score
        if scores:
            return max(scores, key=scores.get)
        return 'basico'  # Padrão
    
    def extrair_comandos(self, content: str) -> List[str]:
        """Extrai comandos do conteúdo"""
        # Padrões para comandos Linux
        padroes_comandos = [
            r'\$ ([a-zA-Z0-9_\-\.\/\s]+)',
            r'# ([a-zA-Z0-9_\-\.\/\s]+)',
            r'`([a-zA-Z0-9_\-\.\/\s]+)`',
            r'<code>([a-zA-Z0-9_\-\.\/\s]+)</code>'
        ]
        
        comandos = []
        for padrao in padroes_comandos:
            matches = re.findall(padrao, content)
            comandos.extend(matches)
        
        # Limpar e filtrar comandos
        comandos_limpos = []
        for cmd in comandos:
            cmd = cmd.strip()
            if len(cmd) > 2 and not cmd.startswith('http'):
                comandos_limpos.append(cmd)
        
        return list(set(comandos_limpos))[:10]  # Máximo 10 comandos únicos
    
    def extrair_palavras_chave(self, titulo: str, headers: List[str], paragraphs: List[str]) -> List[str]:
        """Extrai palavras-chave relevantes"""
        texto_completo = f"{titulo} {' '.join(headers)} {' '.join(paragraphs)}".lower()
        
        # Palavras-chave técnicas importantes
        palavras_importantes = [
            'linux', 'ubuntu', 'debian', 'centos', 'redhat', 'suse',
            'bash', 'shell', 'terminal', 'comando', 'script',
            'arquivo', 'diretorio', 'permissao', 'usuario', 'grupo',
            'processo', 'servico', 'daemon', 'systemd',
            'rede', 'ip', 'dns', 'dhcp', 'roteamento', 'firewall',
            'servidor', 'apache', 'nginx', 'mysql', 'postgresql',
            'backup', 'restore', 'cron', 'log', 'monitoramento',
            'seguranca', 'audit', 'vulnerabilidade', 'patch'
        ]
        
        palavras_encontradas = []
        for palavra in palavras_importantes:
            if palavra in texto_completo:
                palavras_encontradas.append(palavra)
        
        return palavras_encontradas
    
    def analisar_diretorio(self, diretorio: str, nivel: str) -> None:
        """Analisa todos os arquivos HTML de um diretório"""
        dir_path = self.base_path / diretorio
        
        if not dir_path.exists():
            logger.error(f"Diretório não encontrado: {dir_path}")
            return
        
        logger.info(f"Analisando {nivel}: {dir_path}")
        
        arquivos_html = list(dir_path.glob("*.html"))
        self.conteudo_analisado[nivel]['total_arquivos'] = len(arquivos_html)
        
        conteudo_processado = []
        for arquivo in arquivos_html:
            resultado = self.analisar_arquivo_html(arquivo)
            if resultado:
                conteudo_processado.append(resultado)
        
        self.conteudo_analisado[nivel]['conteudo'] = conteudo_processado
        logger.info(f"Processados {len(conteudo_processado)} arquivos de {nivel}")
    
    def analisar_todo_material(self) -> None:
        """Analisa todo o material FOCA Linux"""
        logger.info("Iniciando análise completa do material FOCA Linux...")
        
        # Analisar cada nível
        self.analisar_diretorio('focalinux-Iniciante-html', 'iniciante')
        self.analisar_diretorio('focalinux-IniciandoIntermediario-html', 'intermediario')
        self.analisar_diretorio('focalinux-Avancado-html', 'avancado')
        self.analisar_diretorio('focalinux-Segurança-html', 'seguranca')
        
        logger.info("Análise completa finalizada!")
    
    def gerar_relatorio_por_modulo(self) -> Dict[str, Any]:
        """Gera relatório organizado por módulo"""
        relatorio = {}
        
        for modulo in self.mapeamento_modulos.keys():
            relatorio[modulo] = {
                'conteudo_basico': [],
                'conteudo_intermediario': [],
                'conteudo_avancado': [],
                'conteudo_seguranca': [],
                'comandos_unicos': set(),
                'total_arquivos': 0
            }
        
        # Organizar conteúdo por módulo
        for nivel, dados in self.conteudo_analisado.items():
            for conteudo in dados['conteudo']:
                modulo = conteudo['modulo_relevante']
                if modulo in relatorio:
                    relatorio[modulo][f'conteudo_{nivel}'].append(conteudo)
                    relatorio[modulo]['comandos_unicos'].update(conteudo['comandos'])
                    relatorio[modulo]['total_arquivos'] += 1
        
        # Converter sets para lists
        for modulo in relatorio:
            relatorio[modulo]['comandos_unicos'] = list(relatorio[modulo]['comandos_unicos'])
        
        return relatorio
    
    def identificar_conteudo_prioritario(self) -> Dict[str, List[Dict]]:
        """Identifica conteúdo prioritário para cada módulo"""
        relatorio = self.gerar_relatorio_por_modulo()
        conteudo_prioritario = {}
        
        for modulo, dados in relatorio.items():
            conteudo_prioritario[modulo] = []
            
            # Priorizar conteúdo avançado e de segurança
            for conteudo in dados['conteudo_avancado'] + dados['conteudo_seguranca']:
                if len(conteudo['comandos']) > 3:  # Conteúdo com muitos comandos
                    conteudo_prioritario[modulo].append(conteudo)
            
            # Adicionar conteúdo intermediário relevante
            for conteudo in dados['conteudo_intermediario']:
                if len(conteudo['palavras_chave']) > 5:  # Conteúdo rico em palavras-chave
                    conteudo_prioritario[modulo].append(conteudo)
        
        return conteudo_prioritario
    
    def salvar_analise(self, output_path: str) -> None:
        """Salva a análise completa"""
        # Salvar análise completa
        with open(f"{output_path}/analise_completa_focalinux.json", 'w', encoding='utf-8') as f:
            json.dump(self.conteudo_analisado, f, ensure_ascii=False, indent=2, default=str)
        
        # Salvar relatório por módulo
        relatorio_modulos = self.gerar_relatorio_por_modulo()
        with open(f"{output_path}/relatorio_por_modulo.json", 'w', encoding='utf-8') as f:
            json.dump(relatorio_modulos, f, ensure_ascii=False, indent=2, default=str)
        
        # Salvar conteúdo prioritário
        conteudo_prioritario = self.identificar_conteudo_prioritario()
        with open(f"{output_path}/conteudo_prioritario.json", 'w', encoding='utf-8') as f:
            json.dump(conteudo_prioritario, f, ensure_ascii=False, indent=2, default=str)
        
        logger.info(f"Análise salva em: {output_path}")

def main():
    """Função principal"""
    base_path = "/Users/imac/LinuxAvançado"
    output_path = "/Users/imac/LinuxAvançado/analise_focalinux"
    
    # Criar diretório de saída
    os.makedirs(output_path, exist_ok=True)
    
    # Criar analisador
    analisador = AnalisadorFOCALinux(base_path)
    
    # Analisar todo o material
    analisador.analisar_todo_material()
    
    # Salvar análise
    analisador.salvar_analise(output_path)
    
    # Gerar relatório resumido
    relatorio = analisador.gerar_relatorio_por_modulo()
    
    print("\n" + "="*80)
    print("RELATÓRIO DE ANÁLISE FOCA LINUX")
    print("="*80)
    
    for modulo, dados in relatorio.items():
        print(f"\n{modulo.upper()}:")
        print(f"  Total de arquivos: {dados['total_arquivos']}")
        print(f"  Comandos únicos: {len(dados['comandos_unicos'])}")
        print(f"  Conteúdo básico: {len(dados['conteudo_basico'])}")
        print(f"  Conteúdo intermediário: {len(dados['conteudo_intermediario'])}")
        print(f"  Conteúdo avançado: {len(dados['conteudo_avancado'])}")
        print(f"  Conteúdo segurança: {len(dados['conteudo_seguranca'])}")
    
    print(f"\nAnálise completa salva em: {output_path}")

if __name__ == "__main__":
    main()
