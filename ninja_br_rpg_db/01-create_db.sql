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
    lvl_char INT DEFAULT 1,
    xp_char INT DEFAULT 0,
    id_ninja_tipo INT,
    hp_char INT NOT NULL,
    chakra_char INT NOT NULL,
    sta_char INT NOT NULL,
    CONSTRAINT `fk_t_usuario_char_t_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `t_usuario` (`id_usuario`)
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
    hp INT,
    chakra INT,
    Attack INT,
    Defense INT,
    FOREIGN KEY (CharacterId) REFERENCES Characters(Id)
);

