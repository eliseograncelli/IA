% 1- Ingresar una lista de elementos y mostrarla por pantalla.

ej1:-write('Ingrese una lista: '),leer(Lista),write('Lista ingresada: '), write(Lista).

leer([H|T]):-read(H),H\=[],leer(T).
leer([]). 


% 2. Ingresar una lista de elementos y mostrar su cabeza y su cola.

ej2:-write('Ingrese una lista: '), leer([H|C]), write('Cabeza: ': H:'. Cola: ' :C).


% 3. Ingresar una lista de elementos y mostrar su primer elemento.

ej3:-write('Ingrese una lista: '), leer([H|_]), write('Primer elemento: ': H).


% 4. Ingresar una lista de elementos y mostrar sus dos primeros elementos

ej4:-write('Ingrese una lista: '), leer(L), mostrar(L).

mostrar(Lista):-Lista=[H1,H2|_], write('Primer elemento: ': H1:'Segundo elemento: ' :H2).
mostrar(_):-write('La lista tiene menos de dos elementos').


% 5. Ingresar una lista de elementos y mostrar su último elemento.

ej5:-write('Ingrese una lista: '), leer(Lista), ultimoElemento(Lista,U),write('Ultimo elemento: ': U).

ultimoElemento([H|[]],H).
ultimoElemento([_|T],U):-ultimoElemento(T,U).


% 6. Ingresar una lista de números enteros y calcular la diferencia entre el
% primero y el último de ellos.

ej6:- write('Ingrese una lista de elementos: '), leer([H|T]), ultimoE([H|T],U), diferencia(H,U,Resultado),write(Resultado).
ultimoE([H|[]],H).
ultimoE([_|T],U):-ultimoE(T,U).

diferencia(H,U,Resultado):-Resultado is H-U.

% 7- Ingresar una lista de elementos e informar cuántos elementos tiene.

%ej7:- write('Ingrese una lista: '),leer(Lista), contar(Lista,Resultado),write('La lista ingresada tiene: ':Resultado).
ej7:- contar([a,b,c,d],Resultado),write('La lista ingresada tiene: ':Resultado).

contar([],0). 
contar([_|T],Resultado):-contar(T,X),Resultado is X+1. 


% 8. Ingresar una lista de números enteros e informar cuánto da la
% sumatoria de ellos.

ej8:- write('Ingrese una lista: '),leer(Lista), sumatoria(Lista,Resultado), write(Resultado).

sumatoria([],0).
sumatoria([H|T],Resultado):- sumatoria(T,Res), Resultado is Res + H.


% 9. Ingresar una lista de números enteros y calcular su promedio. Respetar
% el formato del predicado promedio(L,S,C) donde L es la lista ingresada,
% S la sumatoria y C el contador de los elementos de la lista.

ej9:- write('Ingrese una lista: '),leer(Lista), promedio(Lista,S,C), Resultado is S/C, write(Resultado).

promedio([],0,0).
promedio([H|T],S,C):-promedio(T,S2,C2), S is S2 + H, C is C2 + 1. 


% 10. Ingresar una lista y un elemento e informar si ese elemento está en la
% lista.

ej10:- write('Ingrese una lista: '),leer(Lista),write('Ingrese elemento a buscar: '),read(X),pertenece(Lista,X,R),write(R).

pertenece([],_,'NO').
pertenece([H|_],H,'SI').
pertenece([H|T],X,R):-pertenece(T,X,R),H\=X.



% eded
inicio44:- write('Ingrese lista: '),leer(Lista), contar(Lista,0,Y),write(Y).

contar([_|T], ContActual, ContFinal) :- ContNuevo is ContActual + 1, contar(T,ContNuevo,ContFinal).
contar([], ContActual, ContActual).




