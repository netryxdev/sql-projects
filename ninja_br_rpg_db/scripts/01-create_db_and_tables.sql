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
    nm_char NVARCHAR(20) NOT NULL,
    id_graduacao INT DEFAULT 1,
    lvl_char INT DEFAULT 1,
    xp_char INT DEFAULT 0,
    id_ninja_tipo INT,
    id_clan INT NULL, --FK para t_clans (null se o personagem não tem clã)
    id_kekkei_genkai INT NULL -- FK para t_kekkei_genkais 
    dv_portao BIT NOT NULL DEFAULT 0, -- 1 se personagem liberou portao
    FOREIGN KEY (id_usuario) REFERENCES t_usuario(id_usuario),
    FOREIGN KEY (id_clan) REFERENCES t_clan(id_clan),
    FOREIGN KEY (id_kekkei_genkai) REFERENCES t_kekkei_genkai(id_kekkei_genkai),
    FOREIGN KEY (id_graduacao) REFERENCES t_graduacao(id_graduacao)
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
    nm_missao_desc VARCHAR(100),
    DifficultyLevel INT,
    ExperienceReward INT,
    Duration TIME
    CONSTRAINT `fk_t_missao_t_missao_tipo` FOREIGN KEY (`id_missao_tipo`) REFERENCES `t_missao_tipo` (`id_missao_tipo`)
);

CREATE TABLE t_atributo (
    id_atributo INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario_char INT,
    vida INT,
    chakra INT,
    forca INT,
    defesa INT,
    resistencia INT,
    inteligencia INT,
    selo INT,
    energia INT,
    habilidade INT,
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char)
);

CREATE TABLE t_clan(
    id_clan INT PRIMARY KEY AUTO_INCREMENT,
    nm_clan VARCHAR(30),
    nm_clan_desc VARCHAR(100)
)

CREATE TABLE t_kekkei_genkais (
    id_kekkei_genkai INT AUTO_INCREMENT PRIMARY KEY,
    nm_kekkei_genkai VARCHAR(100),
    id_clan INT,
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
    nm_jutsu_desc VARCHAR(100),
    dv_jutsu_clan TINYINT(1) DEFAULT 0, -- 1 se é exclusivo de clã
    dv_justu_portao TINYINT(1) DEFAULT 0, -- 1 se é exclusivo para quem tem portão aberto
    dv_jutsu_tipo TINYINT(1) DEFAULT 0, -- 1 se é exclusivo de um tipo de ninja (taijutsu, etc.)
    FOREIGN KEY (id_jutsu_type) REFERENCES t_jutsu_types(id_jutsu_type)
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
    dt_learned TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario_char) REFERENCES t_usuario_char(id_usuario_char),
    FOREIGN KEY (id_jutsu) REFERENCES t_jutsu(id_jutsu),
    PRIMARY KEY (id_char, id_jutsu)
);

CREATE TABLE t_graduacao (
    id_graduacao INT AUTO_INCREMENT PRIMARY KEY,
    nm_graduacao VARCHAR(50),  -- Nome da graduação (Genin, Chuunin, etc.)
    nm_graduacao_desc TEXT,         -- Descrição opcional da graduação
    lvl_graduacao INT               -- lvl minimo para essa graduacao
);
