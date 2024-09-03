--inciso 1 parte 1: Usando INNER JOIN crear vistas que generen:
--Clientes que no tienen pedido facturado

--comprobando clientes de totales:
SELECT CLIENTES.COD_CLIE,
pedidos.COD_CLIE as CODIGOPEDIDOCLIENTES,
CLIENTES.VAL_APE1,
CLIENTES.VAL_APE2,
CLIENTES.VAL_NOM1,
CLIENTES.VAL_NOM2,
PEDIDOS.VAL_ESTA_PEDI
FROM clientes 
right outer JOIN pedidos 
ON pedidos.COD_CLIE = clientes.COD_CLIE;

--conteo total DE LA INTERSECCION DE AMBOS, DONDE HAY 52 tablas coincidentes 
-- DE LA CONDICION pedidos.COD_CLIE = clientes.COD_CLIE:
SELECT count (*)
FROM clientes 
right outer JOIN pedidos 
ON pedidos.COD_CLIE = clientes.COD_CLIE
where clientes.COD_CLIE IS NOT NULL ;


--respuesta:
create view CLIENTESINPEDIDOFACT as
SELECT CLIENTES.COD_CLIE,
CLIENTES.VAL_APE1,
CLIENTES.VAL_APE2,
CLIENTES.VAL_NOM1,
CLIENTES.VAL_NOM2,
PEDIDOS.VAL_ESTA_PEDI
FROM clientes 
right outer JOIN pedidos 
ON pedidos.COD_CLIE = clientes.COD_CLIE
where clientes.COD_CLIE IS NOT NULL 
AND PEDIDOS.VAL_ESTA_PEDI NOT like '%FACTURADO%';

--Comprobacion de la respuesta: 
select * from CLIENTESINPEDIDOFACT;

-- de los que coincidan los clientes y no sean facturados: hay 20
select count(*) from CLIENTESINPEDIDOFACT;

--inciso 1 parte 2: Pedidos cuyo cliente no existe en la tabla Clientes

create or replace view PEDIDOCLIE as
SELECT CLIENTES.COD_CLIE, pedidos.COD_CLIE as COD_CLIENTEPEDIDO, PEDIDOS.VAL_ESTA_PEDI
FROM clientes 
right outer JOIN pedidos 
ON pedidos.COD_CLIE = clientes.COD_CLIE
where clientes.COD_CLIE IS NULL;

--Comprobacion de la respuesta:
select * from PEDIDOCLIE;

--De acuerdo con el conteo, debe haber 4947, pues de las coincidentes hay 52:
SELECT COUNT(*) FROM PEDIDOCLIE;


--EJERCICIO NUMERO 2:
--a:Acumulado de atributo VAL_MONT_SOLI agrupado por estado de Pedido, 
--Región de aquellos pedidos facturados en junio, considerar para ello que el codigo de cliente exista en la tabla Cliente

--Acumulado de atributo VAL_MONT_SOLI agrupado por estado de Pedido, 
--Región de aquellos pedidos facturados en junio, considerar para ello 
--que el codigo de cliente exista en la tabla Cliente

--PEDIDOS: FEC_FAC,COD_CLIE,VAL_MONT_SOLI VAL_ESTA_PEDI
--GROUP BY VAL_ESTA_PEDI, FEC_FAC
--EXISTA COD_CLIE
--ACUMULAR VAL_MONT_SOLI
-- Primero se realiza el codigo, antes de realizar el VIEW:
SELECT COD_REGI,
VAL_ESTA_PEDI,
MES, 
SUM(VAL_MONT_SOLI) as ACUMULADO_VAL_MONT_SOLI
FROM (
    SELECT  clientes.COD_CLIE ,PEDIDOS.COD_REGI,PEDIDOS.VAL_ESTA_PEDI, to_char(pedidos.FEC_FACT, 'Month') as mes, VAL_MONT_SOLI
    FROM clientes 
    right outer JOIN pedidos 
    ON pedidos.COD_CLIE = clientes.COD_CLIE
    where clientes.COD_CLIE IS NOT NULL and to_char(pedidos.FEC_FACT, 'Month') like '%June%';
    )
GROUP BY  COD_REGI,VAL_ESTA_PEDI, MES;


-- se procede a crear la vista del contenido del primer FROM
create view LISTACLIENTESJUNIO as 
SELECT  clientes.COD_CLIE ,
PEDIDOS.COD_REGI,
PEDIDOS.VAL_ESTA_PEDI, 
to_char(pedidos.FEC_FACT, 'Month') as mes, 
VAL_MONT_SOLI
FROM clientes 
right outer JOIN pedidos 
ON pedidos.COD_CLIE = clientes.COD_CLIE
where clientes.COD_CLIE IS NOT NULL and to_char(pedidos.FEC_FACT, 'Month') like '%June%';

--Se procede a crear la vista de todo el enunciado:
create view AGRUPACIONFINALCLIENTESJUNIO AS
SELECT COD_REGI,
VAL_ESTA_PEDI,
MES, 
SUM(VAL_MONT_SOLI) as ACUMULADO_VAL_MONT_SOLI
FROM (SELECT * FROM LISTACLIENTESJUNIO)
GROUP BY  COD_REGI,VAL_ESTA_PEDI, MES;


--se comprueba la respuesta:
SELECT * FROM AGRUPACIONFINALCLIENTESJUNIO;


--Ejercicio numero 2 B:a. REALIZAR UNA VISTA En base a la consulta anterior, mostrar una columna adicional que contenga el total de 
--registros por cada agrupación y condicionar a que se muestre solo aquellos que tengan más de 500 registros agrupados

--Se procede a modificar la query, adicionando el CONTEO_REGISTROS para
--contar los registros y luego compararlo si es mayor a 500
SELECT COD_REGI,
VAL_ESTA_PEDI, 
MES, 
SUM(VAL_MONT_SOLI),count(*) as CONTEO_REGISTROS 
FROM (
    SELECT  clientes.COD_CLIE ,
    PEDIDOS.COD_REGI,
    PEDIDOS.VAL_ESTA_PEDI, 
    to_char(pedidos.FEC_FACT, 'Month') as mes, 
    VAL_MONT_SOLI
    FROM clientes 
    right outer JOIN pedidos 
    ON pedidos.COD_CLIE = clientes.COD_CLIE
    where clientes.COD_CLIE IS NOT NULL 
    and to_char(pedidos.FEC_FACT, 'Month') like '%June%')
GROUP BY  COD_REGI,VAL_ESTA_PEDI, MES
having COUNT(*)>500;

-- Se crea la vista correspondiente al enunciado 2b:

Create or Replace View Agrupacionesclientesuperiores As (
Select Cod_Regi,
Val_Esta_Pedi,
Mes,
Sum(Val_Mont_Soli) AS ACUMULADO_VAL_MONT_SOLI,
Count(*) AS Total_Count
From ( Select * From Listaclientesjunio)
Group By Cod_Regi,Val_Esta_Pedi, Mes
Having Count(*)>500);

select * from Agrupacionesclientesuperiores;

