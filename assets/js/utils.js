/* =============================================================================
   PLATAFORMA DE TREINAMENTO LINUX - UTILITÁRIOS
   Ministério das Finanças de Angola
   ============================================================================= */

// Utilitários avançados
const AdvancedUtils = {
    // Gerenciamento de estado local
    storage: {
        set(key, value) {
            try {
                localStorage.setItem(`linux-training-${key}`, JSON.stringify(value));
            } catch (error) {
                console.warn('Erro ao salvar no localStorage:', error);
            }
        },
        
        get(key, defaultValue = null) {
            try {
                const item = localStorage.getItem(`linux-training-${key}`);
                return item ? JSON.parse(item) : defaultValue;
            } catch (error) {
                console.warn('Erro ao ler do localStorage:', error);
                return defaultValue;
            }
        },
        
        remove(key) {
            try {
                localStorage.removeItem(`linux-training-${key}`);
            } catch (error) {
                console.warn('Erro ao remover do localStorage:', error);
            }
        },
        
        clear() {
            try {
                const keys = Object.keys(localStorage).filter(key => key.startsWith('linux-training-'));
                keys.forEach(key => localStorage.removeItem(key));
            } catch (error) {
                console.warn('Erro ao limpar localStorage:', error);
            }
        }
    },

    // Gerenciamento de progresso
    progress: {
        // Salvar progresso do módulo
        saveModuleProgress(moduleId, progress) {
            const moduleProgress = this.storage.get('module-progress', {});
            moduleProgress[moduleId] = {
                ...moduleProgress[moduleId],
                ...progress,
                lastUpdated: new Date().toISOString()
            };
            this.storage.set('module-progress', moduleProgress);
        },

        // Obter progresso do módulo
        getModuleProgress(moduleId) {
            const moduleProgress = this.storage.get('module-progress', {});
            return moduleProgress[moduleId] || {
                completed: false,
                progress: 0,
                exercisesCompleted: 0,
                totalExercises: 0,
                timeSpent: 0,
                lastAccessed: null
            };
        },

        // Atualizar progresso geral
        updateOverallProgress() {
            const moduleProgress = this.storage.get('module-progress', {});
            const modules = Object.keys(moduleProgress);
            const totalModules = 6; // Total de módulos
            const completedModules = modules.filter(id => moduleProgress[id].completed).length;
            const overallProgress = Math.round((completedModules / totalModules) * 100);
            
            this.storage.set('overall-progress', {
                completedModules,
                totalModules,
                progress: overallProgress,
                lastUpdated: new Date().toISOString()
            });
            
            return overallProgress;
        }
    },

    // Gerenciamento de estatísticas
    stats: {
        // Registrar tempo de estudo
        recordStudyTime(moduleId, timeSpent) {
            const stats = this.storage.get('study-stats', {
                totalTime: 0,
                moduleTime: {},
                dailyTime: {},
                weeklyTime: {}
            });
            
            stats.totalTime += timeSpent;
            stats.moduleTime[moduleId] = (stats.moduleTime[moduleId] || 0) + timeSpent;
            
            const today = new Date().toISOString().split('T')[0];
            stats.dailyTime[today] = (stats.dailyTime[today] || 0) + timeSpent;
            
            const week = this.getWeekNumber(new Date());
            stats.weeklyTime[week] = (stats.weeklyTime[week] || 0) + timeSpent;
            
            this.storage.set('study-stats', stats);
        },

        // Obter estatísticas
        getStats() {
            return this.storage.get('study-stats', {
                totalTime: 0,
                moduleTime: {},
                dailyTime: {},
                weeklyTime: {}
            });
        },

        // Obter número da semana
        getWeekNumber(date) {
            const firstDayOfYear = new Date(date.getFullYear(), 0, 1);
            const pastDaysOfYear = (date - firstDayOfYear) / 86400000;
            return Math.ceil((pastDaysOfYear + firstDayOfYear.getDay() + 1) / 7);
        }
    },

    // Gerenciamento de favoritos
    favorites: {
        // Adicionar aos favoritos
        add(type, id, data) {
            const favorites = this.storage.get('favorites', {});
            if (!favorites[type]) favorites[type] = [];
            
            const exists = favorites[type].find(item => item.id === id);
            if (!exists) {
                favorites[type].push({ id, data, addedAt: new Date().toISOString() });
                this.storage.set('favorites', favorites);
                return true;
            }
            return false;
        },

        // Remover dos favoritos
        remove(type, id) {
            const favorites = this.storage.get('favorites', {});
            if (favorites[type]) {
                favorites[type] = favorites[type].filter(item => item.id !== id);
                this.storage.set('favorites', favorites);
                return true;
            }
            return false;
        },

        // Verificar se está nos favoritos
        isFavorite(type, id) {
            const favorites = this.storage.get('favorites', {});
            return favorites[type] ? favorites[type].some(item => item.id === id) : false;
        },

        // Obter favoritos
        get(type) {
            const favorites = this.storage.get('favorites', {});
            return favorites[type] || [];
        }
    },

    // Gerenciamento de notas
    notes: {
        // Salvar nota
        save(moduleId, exerciseId, note) {
            const notes = this.storage.get('notes', {});
            const key = `${moduleId}-${exerciseId}`;
            notes[key] = {
                ...notes[key],
                content: note,
                lastUpdated: new Date().toISOString()
            };
            this.storage.set('notes', notes);
        },

        // Obter nota
        get(moduleId, exerciseId) {
            const notes = this.storage.get('notes', {});
            const key = `${moduleId}-${exerciseId}`;
            return notes[key] || null;
        },

        // Remover nota
        remove(moduleId, exerciseId) {
            const notes = this.storage.get('notes', {});
            const key = `${moduleId}-${exerciseId}`;
            delete notes[key];
            this.storage.set('notes', notes);
        }
    },

    // Gerenciamento de configurações
    settings: {
        // Salvar configuração
        set(key, value) {
            const settings = this.storage.get('settings', {});
            settings[key] = value;
            this.storage.set('settings', settings);
        },

        // Obter configuração
        get(key, defaultValue = null) {
            const settings = this.storage.get('settings', {});
            return settings[key] !== undefined ? settings[key] : defaultValue;
        },

        // Obter todas as configurações
        getAll() {
            return this.storage.get('settings', {});
        }
    },

    // Validação de formulários
    validation: {
        // Validar email
        isValidEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        },

        // Validar URL
        isValidUrl(url) {
            try {
                new URL(url);
                return true;
            } catch {
                return false;
            }
        },

        // Validar senha forte
        isStrongPassword(password) {
            const minLength = 8;
            const hasUpperCase = /[A-Z]/.test(password);
            const hasLowerCase = /[a-z]/.test(password);
            const hasNumbers = /\d/.test(password);
            const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
            
            return password.length >= minLength && 
                   hasUpperCase && 
                   hasLowerCase && 
                   hasNumbers && 
                   hasSpecialChar;
        }
    },

    // Formatação de dados
    format: {
        // Formatar tempo
        formatTime(seconds) {
            const hours = Math.floor(seconds / 3600);
            const minutes = Math.floor((seconds % 3600) / 60);
            const secs = seconds % 60;
            
            if (hours > 0) {
                return `${hours}h ${minutes}m ${secs}s`;
            } else if (minutes > 0) {
                return `${minutes}m ${secs}s`;
            } else {
                return `${secs}s`;
            }
        },

        // Formatar tamanho de arquivo
        formatFileSize(bytes) {
            const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
            if (bytes === 0) return '0 Bytes';
            const i = Math.floor(Math.log(bytes) / Math.log(1024));
            return Math.round(bytes / Math.pow(1024, i) * 100) / 100 + ' ' + sizes[i];
        },

        // Formatar data
        formatDate(date, options = {}) {
            const defaultOptions = {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            };
            return new Date(date).toLocaleDateString('pt-BR', { ...defaultOptions, ...options });
        }
    },

    // Gerenciamento de erros
    error: {
        // Registrar erro
        log(error, context = {}) {
            const errorLog = this.storage.get('error-log', []);
            errorLog.push({
                message: error.message,
                stack: error.stack,
                context,
                timestamp: new Date().toISOString(),
                userAgent: navigator.userAgent,
                url: window.location.href
            });
            
            // Manter apenas os últimos 50 erros
            if (errorLog.length > 50) {
                errorLog.splice(0, errorLog.length - 50);
            }
            
            this.storage.set('error-log', errorLog);
        },

        // Obter log de erros
        getLog() {
            return this.storage.get('error-log', []);
        },

        // Limpar log de erros
        clearLog() {
            this.storage.remove('error-log');
        }
    },

    // Gerenciamento de performance
    performance: {
        // Medir tempo de execução
        measureTime(name, fn) {
            const start = performance.now();
            const result = fn();
            const end = performance.now();
            const duration = end - start;
            
            console.log(`${name} executado em ${duration.toFixed(2)}ms`);
            return result;
        },

        // Medir tempo de execução assíncrono
        async measureTimeAsync(name, fn) {
            const start = performance.now();
            const result = await fn();
            const end = performance.now();
            const duration = end - start;
            
            console.log(`${name} executado em ${duration.toFixed(2)}ms`);
            return result;
        }
    },

    // Gerenciamento de cache
    cache: {
        // Definir cache
        set(key, value, ttl = 3600000) { // 1 hora por padrão
            const cache = this.storage.get('cache', {});
            cache[key] = {
                value,
                expires: Date.now() + ttl
            };
            this.storage.set('cache', cache);
        },

        // Obter do cache
        get(key) {
            const cache = this.storage.get('cache', {});
            const item = cache[key];
            
            if (item && item.expires > Date.now()) {
                return item.value;
            }
            
            // Remover item expirado
            if (item) {
                delete cache[key];
                this.storage.set('cache', cache);
            }
            
            return null;
        },

        // Limpar cache
        clear() {
            this.storage.remove('cache');
        },

        // Limpar cache expirado
        cleanExpired() {
            const cache = this.storage.get('cache', {});
            const now = Date.now();
            let cleaned = false;
            
            Object.keys(cache).forEach(key => {
                if (cache[key].expires <= now) {
                    delete cache[key];
                    cleaned = true;
                }
            });
            
            if (cleaned) {
                this.storage.set('cache', cache);
            }
        }
    },

    // Gerenciamento de notificações
    notifications: {
        // Configurar notificações
        requestPermission() {
            if ('Notification' in window) {
                Notification.requestPermission();
            }
        },

        // Enviar notificação
        send(title, options = {}) {
            if ('Notification' in window && Notification.permission === 'granted') {
                new Notification(title, {
                    icon: '/favicon.ico',
                    badge: '/favicon.ico',
                    ...options
                });
            }
        },

        // Agendar notificação
        schedule(title, delay, options = {}) {
            setTimeout(() => {
                this.send(title, options);
            }, delay);
        }
    },

    // Gerenciamento de sincronização
    sync: {
        // Verificar se há conexão
        isOnline() {
            return navigator.onLine;
        },

        // Aguardar conexão
        waitForConnection() {
            return new Promise((resolve) => {
                if (this.isOnline()) {
                    resolve();
                } else {
                    const handler = () => {
                        window.removeEventListener('online', handler);
                        resolve();
                    };
                    window.addEventListener('online', handler);
                }
            });
        },

        // Sincronizar dados
        async syncData() {
            if (!this.isOnline()) {
                throw new Error('Sem conexão com a internet');
            }
            
            // Implementar lógica de sincronização
            console.log('Sincronizando dados...');
        }
    }
};

// Extender Utils com AdvancedUtils
Object.assign(Utils, AdvancedUtils);

// Configurar tratamento global de erros
window.addEventListener('error', (event) => {
    Utils.error.log(event.error, {
        filename: event.filename,
        lineno: event.lineno,
        colno: event.colno
    });
});

window.addEventListener('unhandledrejection', (event) => {
    Utils.error.log(new Error(event.reason), {
        type: 'unhandledrejection'
    });
});

// Configurar limpeza de cache ao carregar
document.addEventListener('DOMContentLoaded', () => {
    Utils.cache.cleanExpired();
});

// Configurar notificações
document.addEventListener('DOMContentLoaded', () => {
    Utils.notifications.requestPermission();
});

// Exportar para uso global
window.AdvancedUtils = AdvancedUtils;
