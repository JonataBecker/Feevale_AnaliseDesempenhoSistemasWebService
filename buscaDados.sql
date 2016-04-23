
/* Tempo de produção */
CREATE OR REPLACE VIEW TEMPO_PRODUCAO_SUB AS
	SELECT 
		ROUND(totpro / 60) AS TEMPO, 
		numero_incidentes_producao 
	FROM 
		dados
	WHERE 
		totpro > 60;

CREATE OR REPLACE VIEW TEMPO_PRODUCAO AS
	SELECT 
		tempo, 
		AVG(numero_incidentes_producao) * 30 AS mediaNumeroIncidentes, 
		COUNT(numero_incidentes_producao) numeroIncidentes 
	FROM 
		TEMPO_PRODUCAO_SUB
	GROUP BY 
		tempo
	HAVING 
		numeroIncidentes > 10
	ORDER BY 
		tempo;


SELECT * FROM TEMPO_PRODUCAO;

/* Tempo de revisão */


CREATE OR REPLACE VIEW TEMPO_REVISAO_SUB AS
	SELECT 
		ROUND((rev_programacao * 100) / totpro) AS tempo, 
        totrevpro, 
        totpro, 
        numero_incidentes_producao 
	FROM 
		dados 
	WHERE 
		totpro > 60 AND 
        totpro > rev_programacao
    HAVING
		tempo > 0 AND
		tempo < 90
	ORDER BY 
		tempo DESC;

CREATE OR REPLACE VIEW TEMPO_REVISAO AS 
	SELECT 
		tempo, 
        AVG(numero_incidentes_producao) * 30 as mediaNumeroIncidentes,
        COUNT(*) numeroIncidentes
	FROM 
		TEMPO_REVISAO_SUB
	GROUP BY 
		tempo
	HAVING 
		numeroIncidentes > 10
;
