/**
 * Sistema de Integração de Imagens
 * Ministério das Finanças de Angola - Treinamento Linux Avançado
 */

class ImageIntegration {
    constructor() {
        this.imageLibrary = {
            'linux-concepts': {
                url: 'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&h=400&fit=crop',
                alt: 'Conceitos Fundamentais do Linux',
                description: 'Sistema operacional Linux em ação'
            },
            'linux-commands': {
                url: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&h=400&fit=crop',
                alt: 'Terminal Linux com Comandos',
                description: 'Interface de linha de comando do Linux'
            },
            'file-permissions': {
                url: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=400&fit=crop',
                alt: 'Permissões de Arquivos',
                description: 'Estrutura de permissões no Linux'
            },
            'network-config': {
                url: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=400&fit=crop',
                alt: 'Configuração de Rede',
                description: 'Diagrama de rede e conectividade'
            },
            'dns-server': {
                url: 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800&h=400&fit=crop',
                alt: 'Servidor DNS',
                description: 'Resolução de nomes e servidor DNS'
            },
            'web-server': {
                url: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=400&fit=crop',
                alt: 'Servidor Web Apache',
                description: 'Servidor web Apache em funcionamento'
            },
            'backup-strategy': {
                url: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=400&fit=crop',
                alt: 'Estratégias de Backup',
                description: 'Backup e recuperação de dados'
            },
            'shell-scripting': {
                url: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&h=400&fit=crop',
                alt: 'Shell Scripting',
                description: 'Automação com scripts bash'
            },
            'security-tools': {
                url: 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=800&h=400&fit=crop',
                alt: 'Ferramentas de Segurança',
                description: 'Segurança e proteção de sistemas'
            },
            'monitoring': {
                url: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=400&fit=crop',
                alt: 'Monitoramento e Observabilidade',
                description: 'Dashboards e métricas de sistema'
            }
        };
        
        this.init();
    }
    
    init() {
        this.addImagesToSlides();
        this.createImageGallery();
        this.addImageTooltips();
    }
    
    addImagesToSlides() {
        // Adicionar imagens aos slides baseado no conteúdo
        const slides = document.querySelectorAll('.slide');
        
        slides.forEach(slide => {
            const title = slide.querySelector('h2, h3');
            if (title) {
                const imageKey = this.getImageKeyFromTitle(title.textContent);
                if (imageKey && this.imageLibrary[imageKey]) {
                    this.insertImageInSlide(slide, imageKey);
                }
            }
        });
    }
    
    getImageKeyFromTitle(title) {
        const titleLower = title.toLowerCase();
        
        if (titleLower.includes('conceito') || titleLower.includes('fundamento')) {
            return 'linux-concepts';
        } else if (titleLower.includes('comando') || titleLower.includes('terminal')) {
            return 'linux-commands';
        } else if (titleLower.includes('permissão') || titleLower.includes('arquivo')) {
            return 'file-permissions';
        } else if (titleLower.includes('rede') || titleLower.includes('network')) {
            return 'network-config';
        } else if (titleLower.includes('dns') || titleLower.includes('servidor')) {
            return 'dns-server';
        } else if (titleLower.includes('apache') || titleLower.includes('web')) {
            return 'web-server';
        } else if (titleLower.includes('backup') || titleLower.includes('recuperação')) {
            return 'backup-strategy';
        } else if (titleLower.includes('script') || titleLower.includes('automação')) {
            return 'shell-scripting';
        } else if (titleLower.includes('segurança') || titleLower.includes('firewall')) {
            return 'security-tools';
        } else if (titleLower.includes('monitoramento') || titleLower.includes('observabilidade')) {
            return 'monitoring';
        }
        
        return null;
    }
    
    insertImageInSlide(slide, imageKey) {
        const imageData = this.imageLibrary[imageKey];
        
        // Verificar se já existe uma imagem
        if (slide.querySelector('.slide-image')) {
            return;
        }
        
        const imageContainer = document.createElement('div');
        imageContainer.className = 'slide-image-container';
        imageContainer.innerHTML = `
            <div class="slide-image">
                <img src="${imageData.url}" alt="${imageData.alt}" loading="lazy">
                <div class="image-caption">
                    <h4>${imageData.alt}</h4>
                    <p>${imageData.description}</p>
                </div>
            </div>
        `;
        
        // Inserir após o título
        const title = slide.querySelector('h2, h3');
        if (title) {
            title.parentNode.insertBefore(imageContainer, title.nextSibling);
        }
    }
    
    createImageGallery() {
        // Criar galeria de imagens para cada módulo
        const modules = document.querySelectorAll('.module-card');
        
        modules.forEach(module => {
            const moduleId = module.dataset.module;
            if (moduleId) {
                this.addImageGalleryToModule(module, moduleId);
            }
        });
    }
    
    addImageGalleryToModule(module, moduleId) {
        const gallery = document.createElement('div');
        gallery.className = 'module-image-gallery';
        gallery.innerHTML = `
            <h4><i class="fas fa-images"></i> Galeria de Imagens</h4>
            <div class="gallery-grid" id="gallery-${moduleId}">
                <!-- Imagens serão carregadas dinamicamente -->
            </div>
        `;
        
        module.appendChild(gallery);
        this.loadModuleImages(moduleId);
    }
    
    loadModuleImages(moduleId) {
        const gallery = document.getElementById(`gallery-${moduleId}`);
        if (!gallery) return;
        
        const moduleImages = this.getModuleImages(moduleId);
        
        gallery.innerHTML = moduleImages.map(imageKey => {
            const imageData = this.imageLibrary[imageKey];
            return `
                <div class="gallery-item" onclick="imageIntegration.showImageModal('${imageKey}')">
                    <img src="${imageData.url}" alt="${imageData.alt}" loading="lazy">
                    <div class="gallery-overlay">
                        <i class="fas fa-search-plus"></i>
                    </div>
                </div>
            `;
        }).join('');
    }
    
    getModuleImages(moduleId) {
        const imageMap = {
            'modulo1': ['linux-concepts', 'linux-commands', 'file-permissions'],
            'modulo2': ['network-config', 'dns-server'],
            'modulo3': ['web-server', 'network-config'],
            'modulo4': ['backup-strategy', 'shell-scripting'],
            'modulo5': ['security-tools'],
            'modulo6': ['monitoring']
        };
        
        return imageMap[moduleId] || [];
    }
    
    showImageModal(imageKey) {
        const imageData = this.imageLibrary[imageKey];
        
        const modal = document.createElement('div');
        modal.className = 'image-modal';
        modal.innerHTML = `
            <div class="modal-content">
                <span class="close" onclick="this.parentElement.parentElement.remove()">&times;</span>
                <img src="${imageData.url}" alt="${imageData.alt}">
                <div class="modal-caption">
                    <h3>${imageData.alt}</h3>
                    <p>${imageData.description}</p>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        
        // Fechar ao clicar fora da imagem
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.remove();
            }
        });
    }
    
    addImageTooltips() {
        // Adicionar tooltips informativos às imagens
        const images = document.querySelectorAll('.slide-image img, .gallery-item img');
        
        images.forEach(img => {
            img.addEventListener('mouseenter', (e) => {
                this.showImageTooltip(e.target, e);
            });
            
            img.addEventListener('mouseleave', () => {
                this.hideImageTooltip();
            });
        });
    }
    
    showImageTooltip(img, event) {
        const tooltip = document.createElement('div');
        tooltip.className = 'image-tooltip';
        tooltip.textContent = img.alt;
        
        document.body.appendChild(tooltip);
        
        const rect = img.getBoundingClientRect();
        tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
        tooltip.style.top = rect.top - tooltip.offsetHeight - 10 + 'px';
        
        this.currentTooltip = tooltip;
    }
    
    hideImageTooltip() {
        if (this.currentTooltip) {
            this.currentTooltip.remove();
            this.currentTooltip = null;
        }
    }
}

// CSS para integração de imagens
const imageCSS = `
<style>
.slide-image-container {
    margin: 20px 0;
    text-align: center;
}

.slide-image {
    position: relative;
    display: inline-block;
    max-width: 100%;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.slide-image img {
    width: 100%;
    height: auto;
    max-height: 400px;
    object-fit: cover;
}

.image-caption {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(transparent, rgba(0,0,0,0.8));
    color: white;
    padding: 20px;
    text-align: left;
}

.image-caption h4 {
    margin: 0 0 5px 0;
    font-size: 18px;
}

.image-caption p {
    margin: 0;
    font-size: 14px;
    opacity: 0.9;
}

.module-image-gallery {
    margin-top: 20px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 10px;
}

.module-image-gallery h4 {
    margin: 0 0 15px 0;
    color: #2c3e50;
}

.gallery-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 15px;
}

.gallery-item {
    position: relative;
    border-radius: 8px;
    overflow: hidden;
    cursor: pointer;
    transition: transform 0.3s ease;
}

.gallery-item:hover {
    transform: scale(1.05);
}

.gallery-item img {
    width: 100%;
    height: 120px;
    object-fit: cover;
}

.gallery-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.gallery-item:hover .gallery-overlay {
    opacity: 1;
}

.gallery-overlay i {
    color: white;
    font-size: 24px;
}

.image-modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.9);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 2000;
}

.modal-content {
    position: relative;
    max-width: 90%;
    max-height: 90%;
}

.modal-content img {
    max-width: 100%;
    max-height: 80vh;
    object-fit: contain;
}

.close {
    position: absolute;
    top: -40px;
    right: 0;
    color: white;
    font-size: 30px;
    cursor: pointer;
}

.modal-caption {
    background: white;
    padding: 20px;
    text-align: center;
}

.modal-caption h3 {
    margin: 0 0 10px 0;
    color: #2c3e50;
}

.modal-caption p {
    margin: 0;
    color: #7f8c8d;
}

.image-tooltip {
    position: absolute;
    background: #2c3e50;
    color: white;
    padding: 8px 12px;
    border-radius: 4px;
    font-size: 12px;
    z-index: 1000;
    pointer-events: none;
}

.image-tooltip::after {
    content: '';
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    border: 5px solid transparent;
    border-top-color: #2c3e50;
}

@media (max-width: 768px) {
    .gallery-grid {
        grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
    }
    
    .gallery-item img {
        height: 80px;
    }
    
    .modal-content {
        max-width: 95%;
    }
}
</style>
`;

// Adicionar CSS ao head
document.head.insertAdjacentHTML('beforeend', imageCSS);

// Inicializar quando o DOM estiver carregado
document.addEventListener('DOMContentLoaded', () => {
    window.imageIntegration = new ImageIntegration();
});
