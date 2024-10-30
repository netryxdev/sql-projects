-- MySQL db

CREATE SCHEMA `ninja_br_rpg_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

USE `ninja_br_rpg_db`;

CREATE TABLE t_usuario (
    id_usuario INT,
    nm_usuario VARCHAR(100),
    nm_email VARCHAR(100),
    nm_senha VARCHAR(100),
    nr_celular VARCHAR(20)
)

CREATE TABLE t_ninja_tipo(
    id_ninja_tipo INT PRIMARY KEY AUTO_INCREMENT,
    nm_ninja_tipo VARCHAR(20) NOT NULL
)

CREATE TABLE t_usuario_char (
    id_usuario_char INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL
    nm_char NVARCHAR(50) NOT NULL,
    id_graduacao INT DEFAULT 1,
    lvl_char INT DEFAULT 1,
    xp_char INT DEFAULT 0,
    id_ninja_tipo INT,
    id_clan INT NULL, --FK para t_clans (null se o personagem não tem clã)
    id_kekkei_genkai INT NULL -- FK para t_kekkei_genkais 
    dv_portao TINYINT(1) DEFAULT 0, -- 1 se personagem liberou portao
    dv_missao_andamento TINYINT(1) DEFAULT 0, -- 0 para não, 1 para sim
    id_img_char INT,
    FOREIGN KEY (id_usuario) REFERENCES t_usuario(id_usuario),
    FOREIGN KEY (id_clan) REFERENCES t_clan(id_clan),
    FOREIGN KEY (id_kekkei_genkai) REFERENCES t_kekkei_genkai(id_kekkei_genkai),
    FOREIGN KEY (id_graduacao) REFERENCES t_graduacao(id_graduacao)
    FOREIGN KEY (id_img_char) REFERENCES t_img_char(id_img_char)
    CONSTRAINT chk_clan_or_gates CHECK (
        (id_clan IS NOT NULL AND id_kekkei_genkai IS NOT NULL AND has_gates = 0) OR 
        (id_clan IS NULL AND id_kekkei_genkai IS NULL AND has_gates = 1)
    )
);

CREATE TABLE t_missao_tipo(
    id_missao_tipo INT PRIMARY KEY AUTO_INCREMENT,
    nm_missao_tipo VARCHAR(20)
)

CREATE TABLE t_missao (
    id_missao INT PRIMARY KEY AUTO_INCREMENT,
    id_missao_tipo INT,
    nm_missao VARCHAR(30),
    dv_passiva TINYINT(1) DEFAULT 0; -- 1 para missao passiva, 0 para ativa
    nm_missao_desc TEXT,
    lvl_missao INT,
    xp_missao INT,
    dinheiro_missao DECIMAL (18,2) DEFAULT 0,
    Duration TIME,
    id_oponente INT NULL, -- FK para t_oponente (somente para missões ativas)
    id_img_local VARCHAR(255) DEFAULT NULL,
    id_img_oponente VARCHAR(255) DEFAULT NULL,
    dv_img TINYINT(1) DEFAULT 0,
    FOREIGN KEY (id_img_local) REFERENCES t_img_local(id_img_local),
    FOREIGN KEY (id_img_oponente) REFERENCES t_img_oponente(id_img_oponente),
    CONSTRAINT `fk_t_missao_t_missao_tipo` FOREIGN KEY (`id_missao_tipo`) REFERENCES `t_missao_tipo` (`id_missao_tipo`),
    CONSTRAINT fk_t_missao_oponente FOREIGN KEY (id_oponente) REFERENCES t_oponente(id_oponente)
);

CREATE TABLE t_atributo (
    id_atributo INT PRIMARY KEY AUTO_INCREMENT,
    nm_atributo VARCHAR (100),
    nm_atributo_desc TEXT,
    img_url_atributo VARCHAR(255) 
)

CREATE TABLE t_atributo_char (
    id_atributo_char INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario_char INT,
    vida INT,
    chakra INT,
    stamina INT,
    energia INT,              -- Usado para aumentar vida, chakra, stamina
    forca INT,                -- Usado para taijutsu
    inteligencia INT,         -- Usado para ninjutsu
    mentalidade INT,          -- Usado para genjutsu
    def_fisica INT,           -- Defesa contra taijutsu
    def_chakra INT,           -- Defesa contra ninjutsu
    def_mental INT,           -- Defesa contra genjutsu
    precisao INT,             -- Chance de acerto de ataques/jutsus
    perfuracao INT,           -- Capacidade de ignorar parte da defesa
    critico DECIMAL(3,2),     -- Chance de causar dano crítico (ex: 0.01 = 1% para 1.00 = 100%)
    evasao INT,               -- Chance de evitar ataques inimigos
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char)
);

CREATE TABLE t_clan(
    id_clan INT PRIMARY KEY AUTO_INCREMENT,
    nm_clan VARCHAR(30),
    nm_clan_desc TEXT,
    img_url_clan VARCHAR(255)
)

CREATE TABLE t_kekkei_genkai (
    id_kekkei_genkai INT AUTO_INCREMENT PRIMARY KEY,
    nm_kekkei_genkai VARCHAR(100),
    id_clan INT,
    img_url_kekkei_genkai VARCHAR(255),
    FOREIGN KEY (id_clan) REFERENCES t_clan (id_clan)
);

-- talvez essa tabela seja redundancia pq ja tem a tabela de tipo de ninja
CREATE TABLE t_jutsu_tipo (
    id_jutsu_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nm_jutsu_tipo VARCHAR(50) -- 'Taijutsu', 'Ninjutsu', 'Genjutsu'
);

CREATE TABLE t_jutsu (
    id_jutsu INT AUTO_INCREMENT PRIMARY KEY,
    nm_jutsu VARCHAR(50),
    id_jutsu_tipo INT, -- FK para t_jutsu_types (tipo de jutsu: taijutsu, ninjutsu, genjutsu)
    custo_jutsu INT, --usado para tirar o custo da stamina ou do chakra
    nm_jutsu_desc TEXT,
    dano_jutsu INT DEFAULT 0,
    precisao_jutsu DECIMAL(3,2) DEFAULT 0, --precisao necessaria para acertar
    dv_oponente TINYINT(1) DEFAULT 0,
    dv_jutsu_passivo TINYINT(1) DEFAULT 0,
    dv_exclusivo_clan TINYINT(1) DEFAULT 0, -- 1 se é exclusivo de clã
    dv_exclusivo_portao TINYINT(1) DEFAULT 0, -- 1 se é exclusivo para quem tem portão aberto
    dv_exclusivo_tipo TINYINT(1) DEFAULT 0, -- 1 se é exclusivo de um tipo de ninja (taijutsu, etc.)
    img_url_jutsu VARCHAR(255),
    FOREIGN KEY (id_jutsu_tipo) REFERENCES t_jutsu_tipo(id_jutsu_tipo)
);

CREATE TABLE t_clan_jutsu (
    id_jutsu INT,
    id_clan INT,
    PRIMARY KEY (id_jutsu, id_clan),
    FOREIGN KEY (id_jutsu) REFERENCES t_jutsu(id_jutsu),
    FOREIGN KEY (id_clan) REFERENCES t_clan(id_clan)
);

CREATE TABLE t_usuario_char_jutsu (
    id_usuario_char INT,
    id_jutsu INT,
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char),
    FOREIGN KEY (id_jutsu) REFERENCES t_jutsu(id_jutsu),
    PRIMARY KEY (id_usuario_char, id_jutsu)
);

CREATE TABLE t_graduacao (
    id_graduacao INT AUTO_INCREMENT PRIMARY KEY,
    nm_graduacao VARCHAR(50),  -- Nome da graduação (Genin, Chuunin, etc.)
    nm_graduacao_desc TEXT,         -- Descrição opcional da graduação
    lvl_graduacao INT               -- lvl minimo para essa graduacao
);

CREATE TABLE t_treinamento (
    id_treinamento INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario_char INT,
    horas_treinadas INT,          -- Quantidade de horas treinadas
    xp_ganho INT,                 -- XP ganho com o treinamento
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char)
);

CREATE TABLE t_oponente (
    id_oponente INT PRIMARY KEY AUTO_INCREMENT,
    nm_oponente VARCHAR(100), -- Nome do oponente (ninja procurado ou NPC)
    lvl_oponente INT,         -- Nível do oponente
    id_tipo_oponente INT,        -- Tipo de oponente('comum', 'chefe', 'procurado')
    recompensa_dinheiro INT,   -- Dinheiro dado ao derrotá-lo
    recompensa_xp INT,          -- XP dado ao derrotá-lo
    id_img_oponente VARCHAR(255),
    FOREIGN KEY (id_tipo_oponente) REFERENCES t_tipo_oponente(id_tipo_oponente)
);

CREATE TABLE t_tipo_oponente(
    id_tipo_oponente INT PRIMARY KEY AUTO_INCREMENT,
    nm_tipo_oponente VARCHAR (50), -- Tipo de oponente('comum', 'chefe', 'procurado')
)

CREATE TABLE t_oponente_atributo (
    id_oponente_atributo INT PRIMARY KEY AUTO_INCREMENT,
    id_oponente INT,
    vida INT,
    chakra INT,
    stamina INT,
    forca INT,           -- Usado para taijutsu
    inteligencia INT,    -- Usado para ninjutsu
    mentalidade INT,     -- Usado para genjutsu
    def_fisica INT,      -- Defesa contra taijutsu
    def_chakra INT,      -- Defesa contra ninjutsu
    def_mental INT,      -- Defesa contra genjutsu
    precisao DECIMAL(3,2), -- Precisão do oponente (chance de acerto)
    perfuracao DECIMAL(3,2), -- Capacidade de ignorar defesa
    critico DECIMAL(3,2), -- Chance de crítico
    evasao DECIMAL(3,2),  -- Chance de evitar ataques
    FOREIGN KEY (id_oponente) REFERENCES t_oponente(id_oponente)
);

CREATE TABLE t_oponente_jutsu (
    id_oponente_jutsu INT PRIMARY KEY AUTO_INCREMENT,
    id_oponente INT,
    id_jutsu INT,
    FOREIGN KEY (id_jutsu) REFERENCES t_jutsu(id_jutsu),
    FOREIGN KEY (id_jutsu_tipo) REFERENCES t_jutsu_tipo(id_jutsu_tipo)
);

CREATE TABLE t_grind_limitador (
    id_usuario_char INT,
    id_oponente INT,
    dt_ultima_batalha DATETIME, -- Controla a última vez que o jogador lutou contra o oponente
    tentativas_restantes INT DEFAULT 5, -- Limite de batalhas diárias
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char),
    FOREIGN KEY (id_oponente) REFERENCES t_oponente(id_oponente)
);

CREATE TABLE t_missao_passiva_usuario_controle (
    id_usuario_char INT,
    id_missao INT,
    dt_inicio DATETIME,
    dt_fim DATETIME,
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char),
    FOREIGN KEY (id_missao) REFERENCES t_missao(id_missao)
);

--Criar tabela para imagens dos Char
CREATE TABLE t_img_char(
    id_img_char INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_char VARCHAR(100),
    url_img_char VARCHAR(255)
)

CREATE TABLE t_img_oponente(
    id_img_oponente INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_oponente VARCHAR(100),
    url_img_oponente VARCHAR(255)
)

--Criar tabela para imagens dos Char
CREATE TABLE t_img_local(
    id_img_local INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_local VARCHAR(100),
    url_img_local VARCHAR(255)
)

--Criar tabela para imagens dos npc
CREATE TABLE t_img_npc(
    id_img_npc INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_npc VARCHAR(100),
    url_img_npc VARCHAR(255)
)

--Criar tabela para imagens dos oponentes ? 


-- comecar a fazer as telas a partir daqui.
-- tabelas futuras:

-- tabela dos itens e fazer tabela item_char
CREATE TABLE t_item(
    id_img_item INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_item VARCHAR(100),
    url_img_item VARCHAR(255)
)