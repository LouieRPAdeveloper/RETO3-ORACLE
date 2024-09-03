Previamente se tuvo que realizar la query de la imagen A, del cual permite realizar la cantidad de clientes registraos en la tabla clientes coincida con la de la tabla de pedidos , tal como se observa en la imagen A. En la Imagen B se realiza el conteo de registros de la query,:

![image](https://github.com/user-attachments/assets/8b08e070-c476-4921-ae40-a19cfa42908e)

**IMAGEN A:** Creación de la query

![image](https://github.com/user-attachments/assets/d16a85a7-4029-40f4-a885-5dc383e6db81)

**IMAGEN B:** Conteo de registros de la query

![image](https://github.com/user-attachments/assets/f5ac5473-0f59-449f-9f2f-2c4c7fc1b1ad)

**IMAGEN C:** Conteo de registros de la query

![image](https://github.com/user-attachments/assets/774a135a-3422-4f96-a54b-337fa1e3ea88)

**IMAGEN D:** Conteo de registros de la query cuando coinciden los campos on pedidos.COD_CLIE = clientes.COD_CLIE y que clientes.COD_CLIE no sea NULL 

### •	Parte 1: Usando INNER JOIN crear vistas que generen:
#### a.	Clientes que no tienen pedido facturado

La resolución puede observarlo en la imagen 1. Para ello, se utilizó el RIGHT OUTER JOIN, pues permite que conserve una unión entre dos tablas con una cláusula de unión explícita, preservando las filas no coincidentes de la segunda tabla.

Para ello agregamos el on pedidos.COD_CLIE = clientes.COD_CLIE con la finalidad que sea coincidente los códigos de Clientes y los Pedidos, dando como NULL en COD_CLIE aquellos que han hecho pedidos, pero no son clientes, por ello fue que en la condición WHERE  se utilizo el NOT NULL, adicionando que el VAL_ESTA_PEDI  no debe ser igual a FACTURADO, razón que se usa el NOT LIKE ‘%FACTURADO%’. Además, piden crear VIEW, por lo que se le añade todo a la sentencia CREATE VIEW CLIENTESINPEDIDOFACT as (query). Tal como se observa en la imagen 1 y el resultado:

![image](https://github.com/user-attachments/assets/39a8176c-c16b-436e-8cda-0b44e5b1ef37)

**IMAGEN 1:** Creación de la vista de la query solicita en el inciso A del reto. Elaboración Propia

Luego, para corroborarlo, se puede ver en la parte izquierda, en el apartado de VIEWS, del cual puede observarse la creación del VIEW CLIENTESINPEDIDOFACT: 

![image](https://github.com/user-attachments/assets/0691a832-5155-49d6-ac71-3dc96007c05a)

**IMAGEN 2:** VIEW CLIENTESINPEDIDOFACT. Elaboración Propia

Además, para corroborar que hay datos, se hace la siguiente consulta, tal como se aprecia en la IMAGEN 3:

![image](https://github.com/user-attachments/assets/06143ca1-c4e5-4d7d-afb1-ff625bdd7a03)

**IMAGEN 3:** Consulta CLIENTESINPEDIDOFACT. Elaboración Propia

![image](https://github.com/user-attachments/assets/451a9b3a-af8b-4caf-a4f6-91b675859286)


**IMAGEN 3 A:** Conteo de registros de CLIENTESINPEDIDOFACT. Elaboración Propia

### •	Usando INNER JOIN crear vistas que generen:
#### b.	Pedidos cuyo cliente no existe en la tabla Clientes
Para ello, se toma la parte de los clientes que no existen en la tabla Clientes, para ello, basándonos en la imagen 4, tomara como nulo los valores de COD_CLIE que no coincida el on pedidos.COD_CLIE = clientes.COD_CLIE de la query de la IMAGEN 5, para ello se debe considerar que clientes.COD_CLIE sea NULL. Además, en la última imagen mencionada, piden que sea de tipo VIEW, por lo que se hace VIEW PEDIDOCLIE AS

![image](https://github.com/user-attachments/assets/419a5911-e0cb-457c-b398-98a81f5e7df8)

**IMAGEN 4:** Observación del RIGHT OUTER JOIN. Elaboración Propia

![image](https://github.com/user-attachments/assets/9a11425b-ba9b-4df1-b335-61f85ed2d5b5)

**IMAGEN 5:**  VIEW PEDIDOCLIE. Elaboración Propia

![image](https://github.com/user-attachments/assets/79ceab03-cad7-4ed5-aa68-51a7895dc19b)

**IMAGEN 5 A:**  Comprobacion de la creacion VIEW PEDIDOCLIE. Elaboración Propia

![image](https://github.com/user-attachments/assets/ae112f47-7687-41b7-9a22-184d420199b7)

**IMAGEN 6:** Consulta PEDIDOCLIE. Elaboración Propia

![image](https://github.com/user-attachments/assets/4a9fa3aa-85c8-488f-9137-bf89bf9049bd)

**IMAGEN 6 A:** Consulta numero de registros de PEDIDOCLIE. Elaboración Propia

### •	Parte 2: Crear vistas para mostrar:
#### a.	Acumulado de atributo VAL_MONT_SOLI agrupado por estado de Pedido, Región de aquellos pedidos facturados en junio, considerar para ello que el código de cliente exista en la tabla Cliente

**Paso 1:** Para ello, previamente, debemos realizar la query, considerando el estado de Pedido, Región de aquellos pedidos facturados en junio, considerar para ello que el código de cliente exista en la tabla Cliente y VAL_MONT_SOLI. Para el campo MES se transformó el FEC_FACT usando TO_CHAR(pedidos.FEC_FACT,’Month’) con la finalidad de obtener el mes del date FEC_FACT. Si consideramos que el código de cliente exista en la tabla Cliente, debemos considerar que no sea de tipo NULL. La query es la siguiente:

![image](https://github.com/user-attachments/assets/455b0581-ae4b-4b71-ac81-28da19aeaa4c)

**IMAGEN 7:** Query y resultado, considerando que no sea NULL, sea de Junio y que exista el COD_CLIE

**Paso 2:** Luego, considerando los campos COD_REGI, VAL_ESTA_PEDI, MES y VAL_MONT_SOLI, se realiza la agrupación de estos campos usando group by, considerando que para acumular se usa SUM (VAL_MONT_SOLI), tal como se detalla en la imagen 8:

![image](https://github.com/user-attachments/assets/ed4ee1d0-2cee-4739-b364-15cc5ad19edd)

**IMAGEN 8:** Acumulado de atributo VAL_MONT_SOLI agrupado por estado de Pedido, Región de aquellos pedidos facturados en junio, considerar para ello que el código de cliente exista en la tabla Cliente

**Paso 3:** De acuerdo con la query del paso 1, se realiza el CREATE VIEW LISTACLIENTESJUNIO para reducir el tamaño del código, tal como se observa en la imagen:

![image](https://github.com/user-attachments/assets/9ecd6367-0892-410a-951c-05c8270e6447)

**IMAGEN 9:**  Creación de la VIEW LISTACLIENTESJUNIO basado en la query del paso 1

![image](https://github.com/user-attachments/assets/29607b61-79ff-4370-9831-e21897f0e62e)

**IMAGEN 9 A:**  Comprobación de la VIEW LISTACLIENTESJUNIO basado en la query del paso 1
	
**Paso 4:** De acuerdo con la query del paso 2, se realiza el CREATE VIEW AGRUPACIONFINALCLIENTESJUNIO para reducir el tamaño del código, tal como se observa en la imagen:

![image](https://github.com/user-attachments/assets/c6f4e57d-169a-46dd-bd2a-a43052823935)

**IMAGEN 10:**  Creación de la VIEW AGRUPACIONFINALCLIENTESJUNIO basado en la query del paso 2

![image](https://github.com/user-attachments/assets/f81c5a75-7151-4928-ba2d-46cbb45c8ffe)

**IMAGEN 10 A:**   VIEW AGRUPACIONFINALCLIENTESJUNIO 

De acuerdo con el problema, piden la VIEW. Para corroborar el VIEW AGRUPACIONFINALCLIENTESJUNIO, se realiza la petición:


![image](https://github.com/user-attachments/assets/49f2463a-4b81-49c5-9fe4-ac254ca96383)

**IMAGEN 11:** Comprobacion de la VIEW pedida AGRUPACIONFINALCLIENTESJUNIO

#### b.	En base a la consulta anterior, mostrar una columna adicional que contenga el total de registros por cada agrupación y condicionar a que se muestre solo aquellos que tengan más de 500 registros agrupados

**Paso 1:** De acuerdo con la query del paso 2 del inciso a, se añade otro campo de conteo de registros, el COUNT(*), pero adicionamos el HAVING GROUP  COUNT(*) > 500, pues piden que se vea si y solo si tengan mas de 500 registros agrupados. Tal como se observa en la imagen 12: 

![image](https://github.com/user-attachments/assets/004fea08-2b49-4993-af42-998c2ef6272b)

**IMAGEN 12**

**Paso 2**: De acuerdo con la query del paso 3 del inciso a, se usa el  VIEW LISTACLIENTESJUNIO para reducir el tamaño del código dentro del primer FROM y se hace un CREATE VIEW AGRUPACIONESCLIENTESSUPERIORES, pues piden la vista, modificando Count(*) AS Total_Count para el conteo general de los registros:


![image](https://github.com/user-attachments/assets/937c8711-4094-4505-b87f-e8bc5c15ef01)

**IMAGEN 13:** Creación de la VIEW pedida en el Inciso B


![image](https://github.com/user-attachments/assets/9d9219ec-9b70-412b-a28a-1e17c53df3f8)

**IMAGEN 13 A:** VIEW pedida en el Inciso B

**Paso 2 A**: De acuerdo con el paso 2, ejecutamos el codigo sombreado con azul, para comprobar que en el Total_Count, la cantidad de registros no supera los 20 unidades

![image](https://github.com/user-attachments/assets/976aa0b6-879e-4220-b8a9-1d64e25e3a45)

**IMAGEN 13 B:** Ejecucion de Query

**Paso 3:** Para comprobar, se realiza el select * from AGRUPACIONESCLIENTESSUPERIORES, del cual no se puede ver, ya que no hay 500 registros en cada uno.

![image](https://github.com/user-attachments/assets/617716a2-a060-407f-8242-e7ecb821626c)

**IMAGEN 14:** Comprobación de la VIEW pedida en el Inciso B
