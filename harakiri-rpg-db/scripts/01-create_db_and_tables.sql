CREATE TABLE t_usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nm_usuario VARCHAR(100),
    nm_email VARCHAR(100),
    nm_senha VARCHAR(100),
    nr_celular VARCHAR(20)
);
DROP TABLE t_usuario
CREATE TABLE t_char_tipo(
    id_char_tipo INT PRIMARY KEY AUTO_INCREMENT,
    nm_char_tipo VARCHAR(20) NOT NULL
);

CREATE TABLE t_graduacao (
    id_graduacao INT AUTO_INCREMENT PRIMARY KEY,
    nm_graduacao VARCHAR(50),  -- Nome da graduação (Genin, Chuunin, etc.)
    nm_graduacao_desc TEXT,         -- Descrição opcional da graduação
    lvl_graduacao INT               -- lvl minimo para essa graduacao
);

CREATE TABLE t_img_char(
    id_img_char INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_char VARCHAR(100),
    url_img_char VARCHAR(300)
);

CREATE TABLE t_usuario_char (
    id_usuario_char INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    nm_char NVARCHAR(50) NOT NULL,
    id_graduacao INT DEFAULT 1,
    lvl_char INT DEFAULT 1,
    xp_char INT DEFAULT 0,
    id_char_tipo INT,
    dv_missao_andamento TINYINT(1) DEFAULT 0, -- 0 para não, 1 para sim
    id_img_char INT,
    FOREIGN KEY (id_usuario) REFERENCES t_usuario(id_usuario),
    FOREIGN KEY (id_graduacao) REFERENCES t_graduacao(id_graduacao),
    FOREIGN KEY (id_img_char) REFERENCES t_img_char(id_img_char)
);

CREATE TABLE t_img_oponente(
    id_img_oponente INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_oponente VARCHAR(100),
    url_img_oponente VARCHAR(255)
);

CREATE TABLE t_img_local(
    id_img_local INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_local VARCHAR(100),
    url_img_local VARCHAR(255)
);


CREATE TABLE t_img_npc(
    id_img_npc INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_npc VARCHAR(100),
    url_img_npc VARCHAR(255)
);

CREATE TABLE t_missao_tipo(
    id_missao_tipo INT PRIMARY KEY AUTO_INCREMENT,
    nm_missao_tipo VARCHAR(20)
);

CREATE TABLE t_item(
    id_img_item INT PRIMARY KEY AUTO_INCREMENT,
    nm_img_item VARCHAR(100),
    url_img_item VARCHAR(255)
);

CREATE TABLE t_tipo_oponente(
    id_tipo_oponente INT PRIMARY KEY AUTO_INCREMENT,
    nm_tipo_oponente VARCHAR (50) -- Tipo de oponente('comum', 'chefe', 'procurado')
);

CREATE TABLE t_oponente (
    id_oponente INT PRIMARY KEY AUTO_INCREMENT,
    nm_oponente VARCHAR(100), -- Nome do oponente (ninja procurado ou NPC)
    lvl_oponente INT,         -- Nível do oponente
    id_tipo_oponente INT,        -- Tipo de oponente('comum', 'chefe', 'procurado')
    dinheiro INT,   -- Dinheiro dado ao derrotá-lo
    xp INT,          -- XP dado ao derrotá-lo
    id_img_oponente VARCHAR(255),
    FOREIGN KEY (id_tipo_oponente) REFERENCES t_tipo_oponente(id_tipo_oponente)
);

CREATE TABLE t_missao (
    id_missao INT PRIMARY KEY AUTO_INCREMENT,
    id_missao_tipo INT,
    nm_missao VARCHAR(30),
    dv_passiva TINYINT(1) DEFAULT 0, -- 1 para missao passiva, 0 para ativa
    nm_missao_desc TEXT,
    lvl_missao INT,
    xp_missao INT,
    gold_missao DECIMAL (18,2) DEFAULT 0,
    duracao TIME,
    id_oponente INT NULL, -- FK para t_oponente (somente para missões ativas)
    id_img_local INT DEFAULT NULL,
    id_img_oponente INT DEFAULT NULL,
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
);

CREATE TABLE t_atributo_char (
    id_atributo_char INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario_char INT,
    hp INT,
    ad INT,
    ap INT,
    def INT,
    velocidade INT, 
    energia INT, 
    forca INT, 
    inteligencia INT, 
    agilidade INT,  
    critico DECIMAL(3,2), -- Chance de crítico
    evasao DECIMAL(3,2),  -- Chance de evitar ataques
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char)
);

CREATE TABLE t_skill_tipo (
    id_skill_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nm_skill_tipo VARCHAR(50) 
);

CREATE TABLE t_skill (
    id_skill INT AUTO_INCREMENT PRIMARY KEY,
    nm_skill VARCHAR(50),
    id_skill_tipo INT, -- FK para t_skill_types (tipo de skill: taiskill, ninskill, genskill)
    custo_skill INT, 
    dano_skill INT DEFAULT 0,
    nm_skill_desc TEXT,
    precisao_skill DECIMAL(3,2) DEFAULT 0, 
    dv_oponente TINYINT(1) DEFAULT 0,
    dv_skill_passivo TINYINT(1) DEFAULT 0,
    dv_exclusivo_tipo TINYINT(1) DEFAULT 0, -- 1 se é exclusivo de um tipo de ninja (taiskill, etc.)
    img_url_skill VARCHAR(255),
    FOREIGN KEY (id_skill_tipo) REFERENCES t_skill_tipo(id_skill_tipo)
);

CREATE TABLE t_usuario_char_skill (
    id_usuario_char INT,
    id_skill INT,
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char),
    FOREIGN KEY (id_skill) REFERENCES t_skill(id_skill),
    PRIMARY KEY (id_usuario_char, id_skill)
);

CREATE TABLE t_treinamento (
    id_treinamento INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario_char INT,
    horas_treinadas INT,          -- Quantidade de horas treinadas
    xp_ganho INT,                 -- XP ganho com o treinamento
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char)
);

CREATE TABLE t_oponente_atributo (
    id_oponente_atributo INT PRIMARY KEY AUTO_INCREMENT,
    id_oponente INT,
    hp INT DEFAULT 0,
    ad INT DEFAULT 0,
    ap INT DEFAULT 0,
    def INT DEFAULT 0,
    velocidade INT DEFAULT 0, 
    energia INT DEFAULT 0, 
    forca INT DEFAULT 0, 
    inteligencia INT DEFAULT 0, 
    agilidade INT DEFAULT 0,  
    critico DECIMAL(3,2) DEFAULT 0.00, -- Chance de crítico
    evasao DECIMAL(3,2) DEFAULT 0.00,  -- Chance de evitar ataques
    FOREIGN KEY (id_oponente) REFERENCES t_oponente(id_oponente)
);

CREATE TABLE t_oponente_skill (
    id_oponente_skill INT PRIMARY KEY AUTO_INCREMENT,
    id_oponente INT,
    id_skill INT,
    id_skill_tipo INT,
    FOREIGN KEY (id_skill) REFERENCES t_skill(id_skill),
    FOREIGN KEY (id_skill_tipo) REFERENCES t_skill_tipo(id_skill_tipo)
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