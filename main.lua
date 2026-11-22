<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JDEV BLOX🤫🌙</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@300;500;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #0a0a12;
            color: #e0e0ff;
            font-family: 'Rajdhani', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        /* Fundo animado */
        .bg-effects {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            pointer-events: none;
        }

        .bg-effects::before,
        .bg-effects::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.4;
            animation: float 10s infinite ease-in-out;
        }

        .bg-effects::before {
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, #6b21a8, transparent);
            top: -100px;
            left: -100px;
        }

        .bg-effects::after {
            width: 350px;
            height: 350px;
            background: radial-gradient(circle, #3b82f6, transparent);
            bottom: -80px;
            right: -80px;
            animation-delay: -5s;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(30px, 20px) scale(1.1); }
        }

        /* Container principal */
        .panel-container {
            position: relative;
            z-index: 1;
            width: 90%;
            max-width: 900px;
            background: rgba(15, 15, 25, 0.85);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(139, 92, 246, 0.3);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 
                0 0 40px rgba(139, 92, 246, 0.2),
                inset 0 0 60px rgba(59, 130, 246, 0.05);
            animation: panelAppear 0.6s ease-out;
        }

        @keyframes panelAppear {
            from { opacity: 0; transform: translateY(20px) scale(0.98); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        /* Cabeçalho */
        .header {
            text-align: center;
            margin-bottom: 25px;
            position: relative;
        }

        .logo {
            font-family: 'Orbitron', sans-serif;
            font-size: 2.8rem;
            font-weight: 900;
            background: linear-gradient(135deg, #a855f7, #6366f1, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 0 30px rgba(168, 85, 247, 0.5);
            letter-spacing: 2px;
            position: relative;
            display: inline-block;
        }

        .logo::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60%;
            height: 2px;
            background: linear-gradient(90deg, transparent, #a855f7, #3b82f6, transparent);
        }

        .subtitle {
            font-size: 1rem;
            color: #94a3b8;
            margin-top: 10px;
            letter-spacing: 3px;
            text-transform: uppercase;
        }

        /* Grid de jogos */
        .games-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .game-card {
            background: rgba(30, 30, 50, 0.6);
            border: 1px solid rgba(139, 92, 246, 0.2);
            border-radius: 12px;
            padding: 20px 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .game-card:hover {
            transform: translateY(-5px);
            border-color: rgba(168, 85, 247, 0.6);
            box-shadow: 0 10px 30px rgba(139, 92, 246, 0.3);
            background: rgba(40, 40, 70, 0.8);
        }

        .game-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(168, 85, 247, 0.1), transparent);
            transition: left 0.5s;
        }

        .game-card:hover::before {
            left: 100%;
        }

        .game-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
            display: block;
        }

        .game-name {
            font-family: 'Orbitron', sans-serif;
            font-size: 0.95rem;
            font-weight: 700;
            color: #c4b5fd;
            margin-bottom: 5px;
        }

        .game-status {
            font-size: 0.8rem;
            color: #64748b;
        }

        .game-status.active {
            color: #22c55e;
        }

        .game-status.brew {
            color: #f59e0b;
        }

        /* Modal "Em Breve" */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            animation: fadeIn 0.3s;
        }

        .modal-overlay.show {
            display: flex;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: linear-gradient(135deg, #1e1b4b, #0f172a);
            border: 2px solid #a855f7;
            border-radius: 16px;
            padding: 30px 40px;
            text-align: center;
            box-shadow: 0 0 50px rgba(168, 85, 247, 0.4);
            animation: modalPop 0.3s ease-out;
            max-width: 400px;
        }

        @keyframes modalPop {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .modal-title {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.8rem;
            color: #f59e0b;
            margin-bottom: 15px;
        }

        .modal-text {
            font-size: 1rem;
            color: #94a3b8;
            margin-bottom: 20px;
        }

        .modal-btn {
            background: linear-gradient(135deg, #7c3aed, #3b82f6);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            font-family: 'Orbitron', sans-serif;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(124, 58, 237, 0.4);
        }

        .modal-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 25px rgba(124, 58, 237, 0.6);
        }

        /* Notificação de execução */
        .toast {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: rgba(30, 27, 75, 0.95);
            border: 1px solid #22c55e;
            border-radius: 10px;
            padding: 15px 25px;
            color: #22c55e;
            font-family: 'Rajdhani', sans-serif;
            font-weight: 700;
            box-shadow: 0 5px 20px rgba(34, 197, 94, 0.3);
            transform: translateX(150%);
            transition: transform 0.4s ease;
            z-index: 999;
        }

        .toast.show {
            transform: translateX(0);
        }

        /* Rodapé */
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.85rem;
            color: #475569;
        }

        .footer span {
            color: #a855f7;
        }

        /* Responsivo */
        @media (max-width: 600px) {
            .logo { font-size: 2rem; }
            .games-grid { grid-template-columns: 1fr; }
            .panel-container { padding: 20px; }
        }
    </style>
</head>
<body>
    <div class="bg-effects"></div>

    <div class="panel-container">
        <div class="header">
            <div class="logo">JDEV BLOX🤫🌙</div>
            <div class="subtitle">Painel Premium • Scripts Independentes</div>
        </div>

        <div class="games-grid" id="gamesGrid">
            <!-- Os cards serão gerados via JS -->
        </div>

        <div class="footer">
            Feito com 💜 por <span>JDEV</span> • v2.0 Premium
        </div>
    </div>

    <!-- Modal Em Breve -->
    <div class="modal-overlay" id="brewModal">
        <div class="modal-content">
            <div class="modal-title">⏳ EM BREVE</div>
            <div class="modal-text">
                O script para <strong id="brewGameName">este jogo</strong> ainda está sendo desenvolvido.<br>
                Escolha outro jogo abaixo!
            </div>
            <button class="modal-btn" onclick="closeModal()">ESCOLHER OUTRO</button>
        </div>
    </div>

    <!-- Toast de Execução -->
    <div class="toast" id="toast">✅ Script carregado com sucesso!</div>

    <script>
        // Lista de jogos com seus scripts (simulado)
        const games = [
            {
                id: 'mog-or-die',
                name: 'MOG OR DIE',
                icon: '🐱',
                status: 'active',
                script: function() {
                    console.log('[JDEV BLOX] Executando script MOG OR DIE...');
                    // Simula execução do script
                    return 'Script MOG OR DIE carregado: Auto Win, Auto Farm, ESP, God Mode, Teleports';
                }
            },
            {
                id: 'blox-fruits',
                name: 'Blox Fruits',
                icon: '🍎',
                status: 'active',
                script: function() {
                    console.log('[JDEV BLOX] Executando script Blox Fruits...');
                    return 'Script Blox Fruits carregado: Auto Farm, Auto Quest, Auto Raid, Teleport';
                }
            },
            {
                id: 'king Legacy',
                name: 'King Legacy',
                icon: '👑',
                status: 'active',
                script: function() {
                    console.log('[JDEV BLOX] Executando script King Legacy...');
                    return 'Script King Legacy carregado: Auto Farm, Auto Boss, Esp Wall';
                }
            },
            {
                id: 'anime-defenders',
                name: 'Anime Defenders',
                icon: '🛡️',
                status: 'brew',
                script: null
            },
            {
                id: 'pet-sim-99',
                name: 'Pet Sim 99',
                icon: '🐾',
                status: 'active',
                script: function() {
                    console.log('[JDEV BLOX] Executando script Pet Sim 99...');
                    return 'Script Pet Sim 99 carregado: Auto Hatch, Auto Farm, Huge Pets ESP';
                }
            },
            {
                id: 'doom-esp',
                name: 'Doom Spire',
                icon: '⚔️',
                status: 'brew',
                script: null
            },
            {
                id: 'arsenal',
                name: 'Arsenal',
                icon: '🔫',
                status: 'active',
                script: function() {
                    console.log('[JDEV BLOX] Executando script Arsenal...');
                    return 'Script Arsenal carregado: ESP Players, Aimbot, No Recoil';
                }
            },
            {
                id: 'murder-mystery',
                name: 'Murder Mystery 2',
                icon: '🔪',
                status: 'brew',
                script: null
            },
            {
                id: 'tower-of-thrones',
                name: 'Tower of Thrones',
                icon: '🏰',
                status: 'active',
                script: function() {
                    console.log('[JDEV BLOX] Executando script Tower of Thrones...');
                    return 'Script Tower of Thrones carregado: Auto Attack, Auto Heal, ESP';
                }
            }
        ];

        // Renderiza os cards
        const grid = document.getElementById('gamesGrid');
        
        games.forEach(game => {
            const card = document.createElement('div');
            card.className = 'game-card';
            card.onclick = () => selectGame(game);
            
            const statusClass = game.status === 'active' ? 'active' : 'brew';
            const statusText = game.status === 'active' ? '● Ativo' : '◌ Em breve';
            
            card.innerHTML = `
                <span class="game-icon">${game.icon}</span>
                <div class="game-name">${game.name}</div>
                <div class="game-status ${statusClass}">${statusText}</div>
            `;
            
            grid.appendChild(card);
        });

        // Seleciona um jogo
        function selectGame(game) {
            if (game.status === 'brew') {
                // Mostra modal "Em Breve"
                document.getElementById('brewGameName').textContent = game.name;
                document.getElementById('brewModal').classList.add('show');
            } else {
                // Executa o script
                try {
                    const result = game.script();
                    showToast(result);
                } catch (error) {
                    console.error('[JDEV BLOX] Erro ao executar script:', error);
                    showToast('❌ Erro ao carregar o script');
                }
            }
        }

        // Fecha modal
        function closeModal() {
            document.getElementById('brewModal').classList.remove('show');
        }

        // Mostra toast
        function showToast(message) {
            const toast = document.getElementById('toast');
            toast.textContent = message;
            toast.classList.add('show');
            
            setTimeout(() => {
                toast.classList.remove('show');
            }, 4000);
        }

        // Fecha modal ao clicar fora
        document.getElementById('brewModal').addEventListener('click', (e) => {
            if (e.target === document.getElementById('brewModal')) {
                closeModal();
            }
        });
    </script>
</body>
</html>
