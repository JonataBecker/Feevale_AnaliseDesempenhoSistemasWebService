/** View base */
CREATE OR REPLACE VIEW dados_limpos AS
	SELECT 
		numero,
		num_incidentes_producao AS numero_incidentes,
        totpro as Total_Producao,
        ROUND(totpro / 60) AS Total_Producao_Horas, 
        totrevpro as Total_Revisao,
        (ROUND(totrevpro / 60) * 100) / ROUND(totpro / 60) as Percentual_Revisao,
        tempo_incidentes AS Total_incidentes,
        ROUND(tempo_incidentes / 60) AS Total_incidentes_Horas, 
        DATE_FORMAT(DATACRIACAO, '%Y/%m') as Data_Criacao
	FROM 
		export_table
	WHERE 
		DATACRIACAO > '2014-03-01' AND 
        DATACRIACAO < '2016-04-01' AND 
        totpro > 120 AND
        totpro <  4000 AND
        totrevpro < totpro
	HAVING
		Percentual_Revisao < 80
		
;

/** Tempo de produto x Tempo incidentes */
CREATE OR REPLACE VIEW TEMPO_PRODUCAO_TEMPO_PRODUCAO_INCIDENTES AS
	SELECT 
		Data_Criacao as dataCriacao, 
		SUM(Total_Producao_Horas) AS producao, 
		SUM(Total_incidentes_Horas) AS incidentes
	FROM 
		dados_limpos
	GROUP BY
		Data_Criacao
	;

/* Tempo de produção */

/*
CREATE OR REPLACE VIEW TEMPO_PRODUCAO_SUB AS
	SELECT 
		Total_Producao_Horas as producao,
        AVG(Total_incidentes_Horas) as incidentes,
		AVG(numero_incidentes) numeroIncidentes
	FROM 
		dados_limpos
	GROUP BY 
		Total_Producao_Horas
	ORDER BY 
        Total_Producao_Horas  
;
        
CREATE OR REPLACE VIEW TEMPO_PRODUCAO AS      
	SELECT 
		AVG(incidentes) as incidentes, 
		IF (producao <= 3, 1 , IF (producao <= 10, 2, IF (producao <= 15, 3, IF (producao <= 50, 4, 5)))) AS intervalo 
	FROM 
		TEMPO_PRODUCAO_SUB
	GROUP BY 
		intervalo
;*/

/* Informações por periodo */
/*
CREATE OR REPLACE VIEW INFORMACAO_PERIODO AS
	SELECT 
		Data_Criacao AS dataCriacao,
		COUNT(*) AS numeroProducao,
		SUM(numero_incidentes) AS numeroIncidentes,
		SUM(Total_Producao_Horas) AS totalProducaoHoras,
		SUM(Total_Incidentes_Horas) AS totalIncidentesHoras,
		SUM(Total_Producao_Horas) / COUNT(*) AS mediaProducao,
		SUM(Total_Incidentes_Horas) / SUM(numero_incidentes) AS mediaIncidentes
	FROM 
		dados_limpos
	GROUP BY 
		Data_Criacao;




CREATE OR REPLACE VIEW TEMPO_PRODUCAO_SUB AS
	SELECT 
		Total_Producao_Horas as producao,
        SUM(Total_Producao_Horas) as total_producao,
        SUM(Total_Incidentes_Horas) as total_incidentes,
        (SUM(Total_Incidentes_Horas) * 100) / SUM(Total_Producao_Horas) as Percentual,
        
        AVG(Total_incidentes_Horas) as incidentes,
		SUM(numero_incidentes) AS numeroIncidentes
	FROM 
		dados_limpos

	GROUP BY 
		Total_Producao_Horas
	HAVING 
		numeroIncidentes > 10
	ORDER BY 
        Total_Producao_Horas  
;

CREATE OR REPLACE VIEW TEMPO_PRODUCAO AS      
	SELECT 
		AVG(Percentual) as incidentes, 
		IF (producao <= 3, 1 , IF (producao <= 4, 2, IF (producao <= 5, 3, IF (producao <= 50, 4, 5)))) AS intervalo 
	FROM 
		TEMPO_PRODUCAO_SUB
	GROUP BY 
		intervalo;


	SELECT 
		AVG(Percentual) as incidentes, 
		IF (producao <= 3, 1 , IF (producao <= 4, 2, IF (producao <= 5, 3, IF (producao <= 50, 4, 5)))) AS intervalo 
	FROM 
		TEMPO_PRODUCAO_SUB
	GROUP BY 
		intervalo;


SELECT 
	*
FROM
	TEMPO_PRODUCAO_SUB;

*/

/*CREATE OR REPLACE VIEW TEMPO_PRODUCAO_SUB AS*/
SELECT 
		Percentual_Revisao,
		Total_Producao_Horas as producao,
        SUM(Total_Producao_Horas) as total_producao,
        SUM(Total_Incidentes_Horas) as total_incidentes,
        (SUM(Total_Incidentes_Horas) * 100) / SUM(Total_Producao_Horas) as Percentual,
        
        AVG(Total_incidentes_Horas) as incidentes,
		SUM(numero_incidentes) AS numeroIncidentes
	FROM 
		dados_limpos
	WHERE Data_Criacao = '2015/03'
	GROUP BY 
		Percentual_Revisao
	ORDER BY 
        Percentual_Revisao  
;

SELECT * FROM dados_limpos;


SELECT 
		AVG(Percentual) as incidentes, 
		IF (Percentual_Revisao <= 10, 1 , IF (Percentual_Revisao <= 20, 2, IF (Percentual_Revisao <= 30, 3, IF (Percentual_Revisao <= 40, 4, IF (Percentual_Revisao <= 50, 5, IF (Percentual_Revisao <= 60, 6, IF (Percentual_Revisao <= 70, 7, IF (Percentual_Revisao <= 80, 8, IF (Percentual_Revisao <= 90, 9, 10))))))))) AS intervalo 
	FROM 
		TEMPO_PRODUCAO_SUB
	GROUP BY 
		intervalo;









