---
output:
  pdf_document: default
  html_document: default
---
---
title: "Práctica 2(1)"
output:
  pdf_document: Algebra lineal
date: "2023-06-22"
--

# Manuel Rojas García

- **EJERCICIO - 1 **
- ***Representar graficamente (a mano o con ordenador de forma esquemática)
la cadena de Markov que describe la ubicación de la persona apasionada por la lectura.
Tener en cuenta que esta cadena de Markov tiene cuatro estados, que podemos denotar
como H (casa), C1 (primera esquina), C2 (segunda esquina) y B (biblioteca). Mostrar la
probabilidad de las transiciones entre dos estados. Completar también la matriz de
transición de la Tabla 1 siguiendo las indicaciones descritas en el enunciado de la práctica
y vuestro valor de E.***

- En primer lugar tenemos los 4 estados.

H = Casa
C1 = Primera esquina
C2 = Segunda esquina
B = Biblioteca

**Se adjunta pdf con el esquema**

***Matriz de probabilidad es:***

```{r}
matriz <- matrix(c(1, 0.29, 0, 0, 0, 0, 0.29, 0, 0, 0.71, 0, 0, 0, 0, 0.71, 1), nrow = 4, ncol = 4, byrow = TRUE)
matriz
```

- **EJERCICIO - 2 **
- ***Considerar la matriz de transición de la Tabla 1 (ya completada) y definir la matriz
de transición P por filas (¡no por columnas!). Si generáis un vector x con los 16 valores de
la tabla (por filas), podéis generar la matriz P de la siguiente manera:***

- Se cambia filas por columnas

***Matriz de transición es:***

```{r}
labels <-c("H","C1","C2","B")
byRow <- TRUE
P <- matrix ( data =matriz, byrow =byRow , nrow =4, dimnames = list ( labels , labels ))
P
```

- Si sumamos las filas de la matriz de transicion debe dar 1:
`

***Suma de las filas de la matriz de probabilidad:***

```{r}
sumafilas <- rowSums(P)
print(sumafilas)
```
- Si sumamos las columnas de la matriz de transición debe dar 1:

***Suma de las columnas de la matriz de transición:***

```{r}
sumacolumnas <- colSums(P)
print(sumacolumnas)
```
- **EJERCICIO - 3 **

- Se eleva la matriz de transición de 1 a 10 y se contabilizan cuantos 0 hay en cada matriz.


```{r}

library(expm)

mcP <- matrix(c(1, 0, 0, 0, 0.29, 0, 0.71, 0, 0, 0.29, 0, 0.71, 0, 0, 0, 1),nrow = 4, byrow = TRUE)

#Hago una prueba elevando a 1

result <- mcP %^% 1
#result

#Número de elevaciónes
mcL <- rep(0, 10)
#Bucle para hacer las elevaciones y si mcp = 0 que los añada a i

for (i in 1:10) {
  mcP_power <- mcP %^% i  
  mcL[i] <- sum(mcP_power == 0) 
}

mcL
```

**referencias - https://math.libretexts.org/Bookshelves/Applied_Mathematics/Applied_Finite_Mathematics_(Sekhon_and_Bloom)/10%3A_Markov_Chains/10.03%3A_Regular_Markov_Chains#:~:text=To%20determine%20if%20a%20Markov%20chain%20is%20regular%2C%20we%20examine,equilibrium%20in%20the%20long%20run.**

***¿Es la cadena de Markov regular?***



- Al elevar mcP a la potencia 10, encontraremos que ninguna de las entradas son mayores que cero, lo que indica que la cadena de Markov es irregular.


- **EJERCICIO - 4 **

**Referencias - https://math.libretexts.org/Bookshelves/Applied_Mathematics/Applied_Finite_Mathematics_(Sekhon_and_Bloom)/10%3A_Markov_Chains/10.04%3A_Absorbing_Markov_Chains**


En la cadena de Markov dada, los estados absorbentes son B (biblioteca) y H (casa). Estos estados son absorbentes porque una vez que se llega a ellos, no se puede salir. La probabilidad de transición desde estos estados a cualquier otro estado es 0.
Se identifica también como absorbente si la fila para el estado H y B tiene un 1 y todas las demás entradas son 0.


Identificar y justificar qu´e estados son absorbentes. Relacionar la existencia de
estados absorbentes con la regularidad o no de la cadena de Markov. Es decir:

***• ¿puede una cadena de Markov regular tener estados absorbentes?***

Mientrás tenga una ruta finita para llegar a los restos de los estados puede ser regular. Eso significa que no puede ser regular ya que uno de sus estados sea absorbente.

***• si una cadena de Markov tiene algún estado absorbente, ¿puede ser regular?***

No, porqué una vez en ese estado no puede salir de él, ya que no tendría una ruta finita para llegar al resto de los estados.

Que una matriz sea regular se refiere a la propiedad de que todos los estados son accesibles entre sí, 


- **EJERCICIO - 5 **

**Referencia - https://math.libretexts.org/Bookshelves/Applied_Mathematics/Applied_Finite_Mathematics_(Sekhon_and_Bloom)/10%3A_Markov_Chains/10.04%3A_Absorbing_Markov_Chains**
**Referencia http://recursostic.educacion.es/descartes/web/materiales_didacticos/markov_mbgr/Markov5.htm**

Matriz de transición


Matriz A tendrá 2 filas ya que 4 estados menos dos columnas

```{r}
A <- matrix(c(0.29, 0, 0, 0.71),nrow = 2)
A    
```
Matriz D tendrá 2 filas ya que 4 estados menos columnas y cuatro estados menos dos columnas


```{r}
D <- matrix(c(0, 0.71, 0.29, 0),nrow = 2)
D    
```
Como indica el ejercicio y las referencias

Q = | I 0 |
    | A D |

Incluyo una matriz I de identidad y otra de ceros como indida Q.

```{r}
Q <- matrix(c(1,0,0,0,0,1,0,0,0.29,0,0,0.71,0,0.71,0.29, 0),nrow = 4, byrow = TRUE)
Q    
```



- **EJERCICIO - 6**

***referencias -https://barcelonageeks.com/encuentre-raices-o-ceros-de-un-polinomio-en-programacion-r-funcion-polyroot/***

Para sacar la probabilidad que nos indica

Probabilidad de comenzar en C1 y terminar en B igual a la probabilidad de comenzar en C1 y terminar en H:

p(C1 -> B) = p(C1 -> H)

Lo que es igual a:

L^2 / (1 - L) = 1 / (1 - L)

L^2 + L - 1 = 0


El resultado es una ecuacion de segundo grado y como debe dar un valor entre 0 y 1 el valor correcto es 

L = 0.618

La probabilidad de comenzar en C2 y terminar en B es 9 veces superior a la probabilidad de comenzar en C1 y terminar en 
Realizamos la misma operacion que antes pero sabiendo que es 7 veces superior

p(C2 -> B) = 7 * p(C1 -> B)

L/(1 - L) = 7*L^2/(1 - L)

L = 1/7


- **EJERCICIO - 7** (ambos intentos incorrectos)

Este es el ejercico que no comprendo del todo, este apartado es del intento2

(P(C1 -> B)) es imposible, no hay posibilidades que cambie
P(C1 -> H) como E = 79 la posibilidad de continuar 1-0.79 = 0.21



-------

Este es el ejercico que no comprendo del todo, este apartado es del intento1 con los datos del 2

P_n(C1 -> B) = (P(C1 -> B))^n

En este caso, queremos calcular la suma de la serie hasta el término n = 9. Por lo tanto, podemos utilizar la fórmula de la suma de una serie geométrica para calcular la parte entre paréntesis en la ecuación:

((0.87)^0 * (1 - 0.71)^0 + (0.71)^1 * (1 - 0.71)^1 + ... + (0.71)^9 * (1 - 0.71)^9)

S = (1 * (1 - 0.71^10)) / (1 - 0.71)

Simplificando esta expresión, obtenemos:

S = (1 - 0.71^10) / 0.29

S= 3,336026084447935131

Sustituyendo este valor en la fórmula de Markov, podemos calcular la probabilidad de ir de C1 a B después de dos pasos:

P(C1 -> B) = (0.71)^2 * S

P(C1 -> B) = (0.71)^2 * ((1 - 0.71^10) / 0.29)

P(C1 -> B)= 0.6766


Por lo tanto, la probabilidad de que el lector o lectora acabe en la biblioteca (B) si comienza en la esquina C1 después de dos pasos es aproximadamente 0.6766


La probabilidad de que el lector o lectora acabe en casa (H) si comienza en la esquina C1 después de dos pasos se puede calcular utilizando la fórmula de Markov y los valores de la serie geométrica.

P(C1 -> H) = (1 - 0.71) * S

P(C1 -> H) = (1 - 0.71) * ((1 - 0.71^10) / 0.29)

P(C1 -> H) = 0.13927



- **EJERCICIO - 8**

Para calcular la matriz Sr, utilizamos la fórmula:

Sr = (In-k - D)-¹ * A,


Para calcular la matriz In-k la matriz de dentidad tendrá un tamaño (n - k), donde n es el tamaño original de la matriz de transición Q y k es el número de estados absorbentes. La matriz In-k tiene unos en su diagonal principal y ceros en el resto de las entradas.


Esto se debe a que eliminamos la última fila y la última columna de la matriz de transición original.
La matriz de transición reducida A es:

```{r}
A <- matrix(c(0, 0.29, 0.71, 0), nrow = 2)
A
```


La matriz D se construye de la siguiente manera:

Para cada estado absorbente, se indica la probabilidad de absorción en la posición correspondiente en la matriz diagonal.Para los estados no absorbentes, colocamos ceros en la diagonal.
Dado que los estados absorbentes son H y B, y estos estados ocupan la segunda y cuarta columna en la matriz de transición, La matriz diagonal D es:


```{r}
D <- matrix(c(1, 0, 0, 1), nrow = 2)
D
```

Dado que tenemos dos estados no absorbentes (C1 y C2) y dos estados absorbentes (H y B), n = 4 y k = 2.

La matriz identidad In-k es una matriz 2x2 con elementos diagonales iguales a 1 y elementos no diagonales iguales a 0.


El resultado de la matriz Sr es:
Sr = (In-k - D)-¹ * A,

*Se adjunta captura de Calcme




```{r}
Q <- matrix(c(1,0,0,0,0,1,0,0,0.29,0,0,0.71,0,0.71,0.29, 0),nrow = 4, byrow = TRUE)

n1 <- 10 # Elevado a 10 como indica el ejercicio
n2 <- 1000
Qn <- Q%^%n1
Qn
Qinfinito <- Q%^%n2
Qinfinito
```
Se comprueba que si elevamos hacia infinto ocurre lo que indica el ejercicio 8 y su formula




