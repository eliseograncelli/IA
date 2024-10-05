% 2. Teniendo la siguiente base de hechos, definir una regla que permita
% determinar quienes hablan el idioma inglés y francés.

conoce(franco,ingles).
conoce(renzo,ingles).
conoce(franco,frances).
conoce(renzo,frances).
conoce(franco,italiano).
conoce(marco,ingles).
conoce(omar,ingles).
conoce(maria,frances). 

hablanIYF(X):-conoce(X,ingles),conoce(X,frances).


/* 3. Escribir un programa Prolog que responda consultas acerca de cuáles son
los rivales de una determinada selección en un campeonato mundial.
Una selección tiene como rivales todos los otros equipos de su mismo
grupo.
Incluir en el programa la siguiente información:
• El grupo 1 está formado por Brasil, España, Jamaica e Italia.
• El grupo 2 está formado por Argentina, Nigeria, Holanda y Escocia.
El programa debe ser capaz de responder a las siguientes consultas:
a) ¿Son rivales Argentina y Brasil?
b) ¿Cuáles son los rivales de un determinado equipo (por ejemplo
Holanda)? */

grupo(1,brasil).
grupo(1,españa).
grupo(1,jamaica).
grupo(1,italia).
grupo(2,argentina).
grupo(2,nigeria).
grupo(2,holanda).
grupo(2,escocia).

rivales(X,Y):-grupo(G,X),grupo(G,Y),X\=Y.
rivalesDe(X,R):-grupo(G,X),grupo(G,R),X\=R.


/* 7. Escribir un programa que simule una calculadora para las operaciones
matemáticas básicas (suma, resta, multiplicación y división) entre dos
valores numéricos, informando el resultado. */

suma(X,Y,Resultado):-Resultado is X+Y.
resta(X,Y,Resultado):-Resultado is X-Y.
mult(X,Y,Resultado):-Resultado is X*Y.
div(X,Y,Resultado):-Resultado is X/Y.


/* 9. Se tiene la siguiente base de hechos:
Donde hijo(X,Y) indica que X es hijo de Y.
Definir la regla descendiente(A,B), la cual permite determinar si A es
descendiente de B. */

hijo(juan,miguel).
hijo(jose,miguel).
hijo(miguel,roberto).
hijo(julio,roberto).
hijo(roberto,carlos).

descendiente(A,B):-hijo(A,B).
descendiente(A,B):-hijo(A,X),descendiente(X,B).


/* 11. Hacer un programa para calcular el factorial de un número.
factorial(N,Fact).
. N es el número ingresado (argumento de entrada).
. Fact es el resultado calculado (argumento de salida). */

factorial(0,1).
factorial(N,Fact):-X is N-1,factorial(X,R),Fact is N*R.


/* 12. Hacer un programa que permita ingresar un número y calcule su
sumatoria, es decir, la suma de sus términos descontados en una unidad
hasta llegar a cero. Por ejemplo, si el número ingresado fuera 5, se deberá
calcular la sumatoria 5+4+3+2+1 e informar como resultado 15.
suma(N,Sum).
. N es el número ingresado (argumento de entrada).
. Sum es el resultado calculado (argumento de salida). */

suma(0,0).
suma(N,Sum):-X is N-1,suma(X,Res),Sum is Res+N.
