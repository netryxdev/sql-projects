--usuarios

INSERT INTO t_usuario (nm_usuario, nm_email, nm_senha, nr_celular) VALUES ('admin', 'admin@example.com', '123123', '1234567890');
INSERT INTO t_usuario (nm_usuario, nm_email, nm_senha, nr_celular) VALUES ('neto', 'neto@example.com', '123123', '0987654321');
INSERT INTO t_usuario (nm_usuario, nm_email, nm_senha, nr_celular) VALUES ('kurosawa', 'kurosawa@example.com', '123123', '1122334455');

--char_tipo
INSERT INTO t_char_tipo (nm_char_tipo) VALUES ('Ninja');
INSERT INTO t_char_tipo (nm_char_tipo) VALUES ('Samurai');
INSERT INTO t_char_tipo (nm_char_tipo) VALUES ('Monge');

--a partir daqui para baixo ainda nao executei no banco, apenas são exemplos de insert para cada tabela

-- t_graduacao
INSERT INTO t_graduacao (nm_graduacao, nm_graduacao_desc, lvl_graduacao) VALUES ('Genin', 'Nível básico dos ninjas', 1);
INSERT INTO t_graduacao (nm_graduacao, nm_graduacao_desc, lvl_graduacao) VALUES ('Chuunin', 'Nível intermediário dos ninjas', 10);
INSERT INTO t_graduacao (nm_graduacao, nm_graduacao_desc, lvl_graduacao) VALUES ('Jounin', 'Nível avançado dos ninjas', 20);

-- t_img_char
INSERT INTO t_img_char (nm_img_char, url_img_char) VALUES ('Imagem1', 'http://example.com/img1.png');
INSERT INTO t_img_char (nm_img_char, url_img_char) VALUES ('Imagem2', 'http://example.com/img2.png');
INSERT INTO t_img_char (nm_img_char, url_img_char) VALUES ('Imagem3', 'http://example.com/img3.png');

-- t_usuario_char
INSERT INTO t_usuario_char (id_usuario, nm_char, id_graduacao, lvl_char, xp_char, id_char_tipo, dv_missao_andamento, id_img_char) VALUES (1, 'CharA', 1, 1, 0, 1, 0, 1);
INSERT INTO t_usuario_char (id_usuario, nm_char, id_graduacao, lvl_char, xp_char, id_char_tipo, dv_missao_andamento, id_img_char) VALUES (2, 'CharB', 2, 10, 1000, 2, 0, 2);
INSERT INTO t_usuario_char (id_usuario, nm_char, id_graduacao, lvl_char, xp_char, id_char_tipo, dv_missao_andamento, id_img_char) VALUES (3, 'CharC', 3, 20, 5000, 3, 1, 3);

-- t_img_oponente
INSERT INTO t_img_oponente (nm_img_oponente, url_img_oponente) VALUES ('Oponente1', 'http://example.com/oponente1.png');
INSERT INTO t_img_oponente (nm_img_oponente, url_img_oponente) VALUES ('Oponente2', 'http://example.com/oponente2.png');
INSERT INTO t_img_oponente (nm_img_oponente, url_img_oponente) VALUES ('Oponente3', 'http://example.com/oponente3.png');

-- t_img_local
INSERT INTO t_img_local (nm_img_local, url_img_local) VALUES ('Floresta', 'http://example.com/floresta.png');
INSERT INTO t_img_local (nm_img_local, url_img_local) VALUES ('Montanha', 'http://example.com/montanha.png');
INSERT INTO t_img_local (nm_img_local, url_img_local) VALUES ('Deserto', 'http://example.com/deserto.png');

-- t_img_npc
INSERT INTO t_img_npc (nm_img_npc, url_img_npc) VALUES ('NPC1', 'http://example.com/npc1.png');
INSERT INTO t_img_npc (nm_img_npc, url_img_npc) VALUES ('NPC2', 'http://example.com/npc2.png');
INSERT INTO t_img_npc (nm_img_npc, url_img_npc) VALUES ('NPC3', 'http://example.com/npc3.png');

-- t_missao_tipo
INSERT INTO t_missao_tipo (nm_missao_tipo) VALUES ('Exploração');
INSERT INTO t_missao_tipo (nm_missao_tipo) VALUES ('Defesa');
INSERT INTO t_missao_tipo (nm_missao_tipo) VALUES ('Infiltração');

-- t_item
INSERT INTO t_item (nm_img_item, url_img_item) VALUES ('Espada', 'http://example.com/espada.png');
INSERT INTO t_item (nm_img_item, url_img_item) VALUES ('Escudo', 'http://example.com/escudo.png');
INSERT INTO t_item (nm_img_item, url_img_item) VALUES ('Poção', 'http://example.com/pocao.png');

-- t_tipo_oponente
INSERT INTO t_tipo_oponente (nm_tipo_oponente) VALUES ('Comum');
INSERT INTO t_tipo_oponente (nm_tipo_oponente) VALUES ('Chefe');
INSERT INTO t_tipo_oponente (nm_tipo_oponente) VALUES ('Procurado');

-- t_oponente
INSERT INTO t_oponente (nm_oponente, lvl_oponente, id_tipo_oponente, dinheiro, xp, id_img_oponente) VALUES ('OponenteA', 5, 1, 100, 50, 'http://example.com/oponenteA.png');
INSERT INTO t_oponente (nm_oponente, lvl_oponente, id_tipo_oponente, dinheiro, xp, id_img_oponente) VALUES ('OponenteB', 10, 2, 200, 100, 'http://example.com/oponenteB.png');
INSERT INTO t_oponente (nm_oponente, lvl_oponente, id_tipo_oponente, dinheiro, xp, id_img_oponente) VALUES ('OponenteC', 15, 3, 300, 150, 'http://example.com/oponenteC.png');

-- t_missao
INSERT INTO t_missao (id_missao_tipo, nm_missao, dv_passiva, nm_missao_desc, lvl_missao, xp_missao, gold_missao, duracao, id_oponente, id_img_local) VALUES (1, 'Missão Exploratória', 1, 'Explorar a floresta', 1, 100, 50.00, '01:00:00', NULL, 1);
INSERT INTO t_missao (id_missao_tipo, nm_missao, dv_passiva, nm_missao_desc, lvl_missao, xp_missao, gold_missao, duracao, id_oponente, id_img_local) VALUES (2, 'Missão de Defesa', 0, 'Defender a vila', 5, 500, 200.00, '02:00:00', 2, 2);
INSERT INTO t_missao (id_missao_tipo, nm_missao, dv_passiva, nm_missao_desc, lvl_missao, xp_missao, gold_missao, duracao, id_oponente, id_img_local) VALUES (3, 'Infiltração no Castelo', 0, 'Infiltrar-se no castelo inimigo', 10, 1000, 500.00, '03:00:00', 3, 3);

-- t_atributo
INSERT INTO t_atributo (nm_atributo, nm_atributo_desc, img_url_atributo) VALUES ('Força', 'Atributo de força física', 'http://example.com/forca.png');
INSERT INTO t_atributo (nm_atributo, nm_atributo_desc, img_url_atributo) VALUES ('Inteligência', 'Atributo de capacidade mental', 'http://example.com/inteligencia.png');
INSERT INTO t_atributo (nm_atributo, nm_atributo_desc, img_url_atributo) VALUES ('Agilidade', 'Atributo de velocidade e destreza', 'http://example.com/agilidade.png');

-- t_atributo_char
INSERT INTO t_atributo_char (id_usuario_char, hp, ad, ap, def, velocidade, energia, forca, inteligencia, agilidade, critico, evasao) VALUES (1, 100, 20, 15, 10, 5, 100, 20, 15, 10, 0.10, 0.05);
INSERT INTO t_atributo_char (id_usuario_char, hp, ad, ap, def, velocidade, energia, forca, inteligencia, agilidade, critico, evasao) VALUES (2, 120, 25, 18, 12, 6, 120, 25, 20, 12, 0.15, 0.10);
INSERT INTO t_atributo_char (id_usuario_char, hp, ad, ap, def, velocidade, energia, forca, inteligencia, agilidade, critico, evasao) VALUES (3, 150, 30, 20, 15, 8, 150, 30, 25, 15, 0.20, 0.15);
