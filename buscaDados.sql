
/* Tempo de produção */
CREATE OR REPLACE VIEW TEMPO_PRODUCAO_SUB AS
	SELECT 
			ROUND(totpro / 60) AS TEMPO, 
			numero_incidentes_producao 
		FROM dados
		WHERE 
			totpro > 60;

CREATE OR REPLACE VIEW TEMPO_PRODUCAO AS
	SELECT 
		tempo, 
		AVG(numero_incidentes_producao) * 30 AS mediaNumeroIncidentes, 
		COUNT(numero_incidentes_producao) numeroIncidentes 
	FROM TEMPO_PRODUCAO_SUB
	GROUP BY 
		tempo
	HAVING 
		numeroIncidentes > 10
	ORDER BY 
		tempo;


SELECT * FROM TEMPO_PRODUCAO;

/* Tempo de revisão */


SELECT REVISAO, AVG(numero_incidentes_producao) * 30, COUNT(*) T FROM (
	SELECT ROUND((rev_programacao * 100) / totpro) AS REVISAO, totrevpro, totpro, numero_incidentes_producao FROM dados 
	WHERE totpro > 60 AND totpro > rev_programacao
    HAVING REVISAO > 0 AND REVISAO < 90
	ORDER BY REVISAO DESC
) T
GROUP BY REVISAO
HAVING T > 10
;


SELECT ROUND((totrevpro * 100) / totpro) AS REVISAO, totrevpro, totpro, numero_incidentes FROM dados
WHERE totpro > 60 AND totpro > totrevpro
ORDER BY REVISAO DESC;
