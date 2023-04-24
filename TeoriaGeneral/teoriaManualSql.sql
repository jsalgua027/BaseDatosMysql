/*
resumen de las funciones de agregado más comunes en MySQL:

COUNT(): devuelve el número de filas que coinciden con la consulta.
SUM(): devuelve la suma de un conjunto de valores.
AVG(): devuelve el promedio de un conjunto de valores.
MIN(): devuelve el valor mínimo de un conjunto de valores.
MAX(): devuelve el valor máximo de un conjunto de valores.
GROUP_CONCAT(): concatena una columna en una sola cadena separada por un delimitador.
STD(): devuelve la desviación estándar de un conjunto de valores.
STDDEV_POP(): devuelve la desviación estándar poblacional de un conjunto de valores.
STDDEV_SAMP(): devuelve la desviación estándar muestral de un conjunto de valores.
VAR_POP(): devuelve la varianza poblacional de un conjunto de valores.
VAR_SAMP(): devuelve la varianza muestral de un conjunto de valores.
Estas funciones se utilizan generalmente en combinación con la cláusula GROUP BY para realizar cálculos en conjuntos de datos agrupados por una o más columnas.

**********************************************************************************************************************************
formatos más comunes para trabajar con fechas en MySQL:

Funciones:

CURRENT_DATE(): devuelve la fecha actual.
CURRENT_TIME(): devuelve la hora actual.
CURRENT_TIMESTAMP(): devuelve la fecha y hora actual.
DATE(): extrae la fecha de una fecha y hora.
TIME(): extrae la hora de una fecha y hora.
TIMESTAMP(): convierte una fecha y hora en un valor de marca de tiempo.

Formatos:

%Y: año con cuatro dígitos.
%y: año con dos dígitos.
%m: mes (01-12).
%d: día del mes (01-31).
%H: hora en formato de 24 horas (00-23).
%h: hora en formato de 12 horas (01-12).
%i: minutos (00-59).
%s: segundos (00-59).
%W: día de la semana completo (Sunday-Saturday).
%a: día de la semana abreviado (Sun-Sat).
%M: nombre completo del mes.
%b: nombre abreviado del mes.
%p: AM o PM.
******************************************************************************************************************* DAR FORMATO A FECHAS
Estos formatos se pueden usar con las funciones DATE_FORMAT() y STR_TO_DATE() para dar formato a las fechas
 y convertirlas de cadenas a valores de fecha y hora. Además, MySQL también proporciona funciones para realizar cálculos y manipulaciones de fechas, 
 como DATE_ADD(), DATE_SUB(), DATEDIFF(), entre otras.

Podemos usar la función DATE_FORMAT() para dar formato a la fecha en la consulta de esta manera:

SELECT DATE_FORMAT(fecha_venta, '%d-%m-%Y') AS fecha_legible, monto
FROM ventas
WHERE monto > 100

En esta consulta, la función DATE_FORMAT() toma la columna "fecha_venta" y 
la convierte en una cadena con el formato especificado '%d-%m-%Y', 
que significa día-mes-año con dos dígitos para el día y el mes y cuatro dígitos para el año. Luego, se le asigna un alias de columna "fecha_legible"
******************************************************************************************************************************** HACER CALCULOS CON FECHAS
DATE_ADD():
Supongamos que queremos agregar 1 mes y 2 días a una fecha específica "2022-05-15". Podemos usar la función DATE_ADD() de la siguiente manera:

SELECT DATE_ADD('2022-05-15', INTERVAL 1 MONTH + 2 DAY) AS nueva_fecha;

La consulta anterior agregará 1 mes y 2 días a la fecha "2022-05-15" y mostrará la nueva fecha resultante en el formato 'YYYY-MM-DD' en la columna "nueva_fecha". El resultado sería "2022-06-17".

DATE_SUB():
Supongamos que queremos restar 3 meses y 15 días de una fecha específica "2022-05-15". Podemos usar la función DATE_SUB() de la siguiente manera:

SELECT DATE_SUB('2022-05-15', INTERVAL 3 MONTH + 15 DAY) AS nueva_fecha;

La consulta anterior restará 3 meses y 15 días de la fecha "2022-05-15" y mostrará la nueva fecha resultante en el formato 'YYYY-MM-DD' en la columna "nueva_fecha". El resultado sería "2022-01-30".

DATEDIFF():
Supongamos que queremos calcular la diferencia en días entre dos fechas específicas "2022-05-15" y "2022-04-10". Podemos usar la función DATEDIFF() de la siguiente manera:

SELECT DATEDIFF('2022-05-15', '2022-04-10') AS dias_diferencia;

La consulta anterior calculará la diferencia en días entre las dos fechas y mostrará el resultado en la columna "dias_diferencia". El resultado sería 35, lo que significa que hay 35 días de diferencia entre las dos fechas.

********************************************************************************** CONCATENAR NOMBRES
select numem, numem as NumEmpleado , ape1em, ape2em, nomem,
concat(ape1em, ape2em, nomem),
concat(ape1em, ape2em, nomem) as nombreCompleto1,
concat(ape1em,' ',ape2em,' ',nomem)as nombreCompleto2,
concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto3,
concat_ws(' ',ape1em,ape2em,nomem)as nombreCompleto_ws
from empleados
where numde=110 or numde= 120
order by  ape1em desc ,  ape2em desc,  nomem desc; 

************************************************************************** extraer subcadenas de un string
funciones parecidas a SUBSTRING() que permiten extraer subcadenas de una cadena

LEFT(): Esta función devuelve una subcadena que contiene los primeros n caracteres de la cadena dada

SELECT LEFT('Hola mundo', 3);  --> "Hol"

RIGHT(): Esta función devuelve una subcadena que contiene los últimos n caracteres de la cadena dada. 

SELECT RIGHT('Hola mundo', 5); --> "mundo"

SUBSTR(): Esta función es sinónimo de SUBSTRING() y también permite extraer una subcadena de una cadena dada.
 Por ejemplo, si queremos extraer una subcadena que comienza en el tercer carácter y tiene una longitud de 4 caracteres de la cadena

SELECT SUBSTR('Hola mundo', 3, 4); --> "a mu"

MID(): Esta función es similar a SUBSTR() y permite extraer una subcadena de una cadena dada, 
pero en lugar de especificar la posición inicial y la longitud, se especifica la posición inicial y la posición final de la subcadena

SELECT MID('Hola mundo', 3, 4);  -->"a mu"


*/
