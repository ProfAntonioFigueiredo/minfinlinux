#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Analisador Simples de Conteúdo FOCA Linux
Ministério das Finanças de Angola - Treinamento Linux Avançado
"""

import os
import re
import json
from pathlib import Path
from typing import Dict, List, Any
import logging

# Configurar logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class AnalisadorSimplesFOCA:
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
                'processos', 'shell', 'bash', 'terminal', 'navegacao', 'manipulacao',
                'ls', 'cd', 'pwd', 'mkdir', 'rm', 'cp', 'mv', 'chmod', 'chown'
            ],
            'modulo2_redes': [
                'rede', 'network', 'ip', 'dns', 'dhcp', 'roteamento', 'subnet',
                'protocolo', 'conexao', 'interface', 'configuracao', 'ifconfig',
                'ping', 'traceroute', 'netstat', 'ss', 'iptables'
            ],
            'modulo3_administracao_redes': [
                'servidor', 'apache', 'nginx', 'ftp', 'ssh', 'samba', 'nfs',
                'proxy', 'cache', 'load', 'balance', 'cluster', 'bind', 'dns'
            ],
            'modulo4_administracao_sistemas': [
                'pacotes', 'apt', 'yum', 'rpm', 'dpkg', 'repositorio', 'dependencias',
                'backup', 'restore', 'cron', 'systemd', 'log', 'monitoramento',
                'tar', 'rsync', 'dd', 'duplicity'
            ],
            'modulo5_seguranca_redes': [
                'seguranca', 'firewall', 'iptables', 'ufw', 'selinux', 'apparmor',
                'audit', 'log', 'intrusao', 'vulnerabilidade', 'patch', 'hardening',
                'snort', 'suricata', 'fail2ban', 'tripwire'
            ],
            'modulo6_observabilidade': [
                'log', 'monitoramento', 'metricas', 'alertas', 'dashboard', 'grafana',
                'prometheus', 'elasticsearch', 'kibana', 'logstash', 'elk',
                'nagios', 'zabbix', 'cacti'
            ]
        }
    
    def extrair_titulo_simples(self, content: str) -> str:
        """Extrai título do HTML de forma simples"""
        # Procurar por <title>
        title_match = re.search(r'<title[^>]*>(.*?)</title>', content, re.IGNORECASE | re.DOTALL)
        if title_match:
            return title_match.group(1).strip()
        
        # Procurar por <h1>
        h1_match = re.search(r'<h1[^>]*>(.*?)</h1>', content, re.IGNORECASE | re.DOTALL)
        if h1_match:
            return h1_match.group(1).strip()
        
        return "Sem título"
    
    def extrair_headers_simples(self, content: str) -> List[str]:
        """Extrai cabeçalhos do HTML de forma simples"""
        headers = []
        for tag in ['h1', 'h2', 'h3', 'h4', 'h5', 'h6']:
            pattern = f'<{tag}[^>]*>(.*?)</{tag}>'
            matches = re.findall(pattern, content, re.IGNORECASE | re.DOTALL)
            for match in matches:
                # Remover tags HTML internas
                clean_text = re.sub(r'<[^>]+>', '', match).strip()
                if clean_text:
                    headers.append(clean_text)
        return headers
    
    def extrair_comandos(self, content: str) -> List[str]:
        """Extrai comandos do conteúdo"""
        # Padrões para comandos Linux
        padroes_comandos = [
            r'\$ ([a-zA-Z0-9_\-\.\/\s\-\-\-]+)',
            r'# ([a-zA-Z0-9_\-\.\/\s\-\-\-]+)',
            r'`([a-zA-Z0-9_\-\.\/\s\-\-\-]+)`',
            r'<code>([a-zA-Z0-9_\-\.\/\s\-\-\-]+)</code>',
            r'<pre[^>]*>([^<]+)</pre>'
        ]
        
        comandos = []
        for padrao in padroes_comandos:
            matches = re.findall(padrao, content, re.IGNORECASE | re.DOTALL)
            for match in matches:
                # Limpar o comando
                cmd = re.sub(r'<[^>]+>', '', match).strip()
                if len(cmd) > 2 and not cmd.startswith('http') and not cmd.startswith('www'):
                    comandos.append(cmd)
        
        return list(set(comandos))[:15]  # Máximo 15 comandos únicos
    
    def determinar_modulo_relevante(self, titulo: str, headers: List[str], comandos: List[str]) -> str:
        """Determina qual módulo é mais relevante para o conteúdo"""
        texto_completo = f"{titulo} {' '.join(headers)} {' '.join(comandos)}".lower()
        
        scores = {}
        for modulo, palavras_chave in self.mapeamento_modulos.items():
            score = sum(1 for palavra in palavras_chave if palavra in texto_completo)
            scores[modulo] = score
        
        # Retornar módulo com maior score
        if scores and max(scores.values()) > 0:
            return max(scores, key=scores.get)
        return 'modulo1_fundamentos'  # Padrão
    
    def analisar_arquivo_html(self, arquivo_path: str) -> Dict[str, Any]:
        """Analisa um arquivo HTML individual"""
        try:
            with open(arquivo_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # Extrair informações básicas
            titulo = self.extrair_titulo_simples(content)
            headers = self.extrair_headers_simples(content)
            comandos = self.extrair_comandos(content)
            
            # Determinar módulo relevante
            modulo_relevante = self.determinar_modulo_relevante(titulo, headers, comandos)
            
            # Extrair palavras-chave
            texto_completo = f"{titulo} {' '.join(headers)}".lower()
            palavras_chave = [palavra for palavra in self.mapeamento_modulos[modulo_relevante] 
                            if palavra in texto_completo]
            
            return {
                'arquivo': str(arquivo_path),
                'titulo': titulo,
                'headers': headers[:5],  # Primeiros 5 headers
                'comandos': comandos,
                'modulo_relevante': modulo_relevante,
                'palavras_chave': palavras_chave,
                'tamanho': len(content),
                'score_relevancia': len(palavras_chave) + len(comandos)
            }
            
        except Exception as e:
            logger.error(f"Erro ao analisar {arquivo_path}: {e}")
            return None
    
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
        for i, arquivo in enumerate(arquivos_html):
            if i % 50 == 0:  # Log a cada 50 arquivos
                logger.info(f"Processando arquivo {i+1}/{len(arquivos_html)}")
            
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
                'total_arquivos': 0,
                'score_total': 0
            }
        
        # Organizar conteúdo por módulo
        for nivel, dados in self.conteudo_analisado.items():
            for conteudo in dados['conteudo']:
                modulo = conteudo['modulo_relevante']
                if modulo in relatorio:
                    # Mapear nomes de níveis
                    nivel_map = {
                        'iniciante': 'basico',
                        'intermediario': 'intermediario', 
                        'avancado': 'avancado',
                        'seguranca': 'seguranca'
                    }
                    nivel_corrigido = nivel_map.get(nivel, 'basico')
                    
                    relatorio[modulo][f'conteudo_{nivel_corrigido}'].append(conteudo)
                    relatorio[modulo]['comandos_unicos'].update(conteudo['comandos'])
                    relatorio[modulo]['total_arquivos'] += 1
                    relatorio[modulo]['score_total'] += conteudo['score_relevancia']
        
        # Converter sets para lists e ordenar por relevância
        for modulo in relatorio:
            relatorio[modulo]['comandos_unicos'] = list(relatorio[modulo]['comandos_unicos'])
            
            # Ordenar conteúdo por score de relevância
            for nivel in ['basico', 'intermediario', 'avancado', 'seguranca']:
                relatorio[modulo][f'conteudo_{nivel}'].sort(
                    key=lambda x: x['score_relevancia'], reverse=True
                )
        
        return relatorio
    
    def identificar_conteudo_prioritario(self) -> Dict[str, List[Dict]]:
        """Identifica conteúdo prioritário para cada módulo"""
        relatorio = self.gerar_relatorio_por_modulo()
        conteudo_prioritario = {}
        
        for modulo, dados in relatorio.items():
            conteudo_prioritario[modulo] = []
            
            # Priorizar conteúdo avançado e de segurança com alta relevância
            for conteudo in dados['conteudo_avancado'] + dados['conteudo_seguranca']:
                if conteudo['score_relevancia'] > 5:  # Score alto de relevância
                    conteudo_prioritario[modulo].append(conteudo)
            
            # Adicionar conteúdo intermediário relevante
            for conteudo in dados['conteudo_intermediario']:
                if conteudo['score_relevancia'] > 3:  # Score médio-alto
                    conteudo_prioritario[modulo].append(conteudo)
            
            # Ordenar por relevância
            conteudo_prioritario[modulo].sort(key=lambda x: x['score_relevancia'], reverse=True)
        
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
    analisador = AnalisadorSimplesFOCA(base_path)
    
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
        print(f"  Score total: {dados['score_total']}")
        print(f"  Conteúdo básico: {len(dados['conteudo_basico'])}")
        print(f"  Conteúdo intermediário: {len(dados['conteudo_intermediario'])}")
        print(f"  Conteúdo avançado: {len(dados['conteudo_avancado'])}")
        print(f"  Conteúdo segurança: {len(dados['conteudo_seguranca'])}")
    
    print(f"\nAnálise completa salva em: {output_path}")

if __name__ == "__main__":
    main()
