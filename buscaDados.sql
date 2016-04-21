
/* Tempo de produção */
SELECT ROUND(totpro / 60), ROUND(AVG(totpro) / 60), ROUND(AVG(numero_incidentes)) FROM dados 
WHERE  totpro > 60
GROUP BY ROUND(totpro / 60) 
ORDER BY sicla.totpro DESC;

SELECT TEMPO, AVG(numero_incidentes_producao) * 30, COUNT(numero_incidentes_producao) T FROM (
SELECT ROUND(totpro / 60) AS TEMPO, numero_incidentes_producao FROM dados
WHERE  totpro > 60
) T

GROUP BY TEMPO
HAVING T > 10
ORDER BY TEMPO;


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
