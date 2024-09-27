
--Você pode obter todos os jutsus de um tipo específico (ex: todos os ninjutsus) com a seguinte consulta:
SELECT * FROM t_jutsus;
WHERE id_jutsu_type = (SELECT id_jutsu_type FROM t_jutsu_types WHERE nm_jutsu_type = 'Ninjutsu');

--Jutsus Exclusivos de Clãs:
-- Para buscar jutsus exclusivos de um clã específico, você pode usar:
SELECT t_jutsus.nm_jutsu
FROM t_jutsus
JOIN t_clan_jutsus ON t_jutsus.id_jutsu = t_clan_jutsus.id_jutsu
WHERE t_clan_jutsus.id_clan = ?;

-- Jutsus de Portão:
-- Se você quiser buscar jutsus exclusivos para personagens com portão liberado:
SELECT * FROM t_jutsus
WHERE is_gate_exclusive = 1;

-- Jutsus por Tipo Ninja (Exclusividade):
-- Você pode restringir os jutsus apenas a um tipo de ninja (ex: taijutsu):
SELECT * FROM t_jutsus
WHERE is_type_exclusive = 1 AND id_jutsu_type = (SELECT id_jutsu_type FROM t_jutsu_types WHERE nm_jutsu_type = 'Taijutsu');



