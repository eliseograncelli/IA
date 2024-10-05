/* sub_atom(Cadena,
	        ComienzoCadena,
	        CantidadCaracteres,
	        CantidadCaracteresRestantes,
	        SubCadena)
*/

% Ingrese una cadena y mestre el primer caracter.

ej1:- write('Ingrese a cadena: '), read(Cadena), sub_atom(Cadena,0,1,_,Sub), write(Sub).

%  3- Ingresar una cadena de texto e informar cuántos caracteres tiene. 
% En primer lugar haciendo uso del predicado atom_length/2 y en 
% una segunda instancia utilizando sub_atom/5 de forma recursiva.

ej3_1:- write('Ingrese a cadena: '), read(Cadena), atom_length(Cadena,X), write(X).

ej3_2:- write('Ingrese a cadena: '), read(Cadena), contar(Cadena,X), write(X).
contar('',0).
contar(C,X):-sub_atom(C,1,_,0,C2), contar(C2,Y),X is Y+1. 


% 4-  Transformar una cadena en una lista de caracteres. 
ej4:- write('Ingrese a cadena: '), read(Cadena), cadALista(Cadena, Lista), write(Lista).
cadALista('',[]).
cadALista(Cadena,[H|T]):- sub_atom(Cadena,0,1,_,H),sub_atom(Cadena,1,_,0,Sub),cadALista(Sub,T).


% 5- . Transformar una cadena de texto en una lista de palabras, tomando como divisor el espacio.

ej5:- write("Ingrese una cadena de texto: "),read(Cadena),transforma(Cadena,Lista),write("La lista de palabras es: "),write(Lista).

transforma('',[]).
transforma(Cadena,[Prim_pal|T]):- sub_atom(Cadena,Posicion,1,_,' '),sub_atom(Cadena,0,Posicion,_,Prim_pal),P1 is Posicion+1,sub_atom(Cadena,P1,_,0,Subcadena),transforma(Subcadena,T).
transforma(UltimaPalabra,[UltimaPalabra|[]]).


% 6- . Hacer un programa que transforme un número entero a binario.

ej6:- write("Ingrese una cadena de texto: "),read(Numero),intBinario(Numero,Binario),write(Binario).
intBinario(0,0).
intBinario(1,1).
intBinario(Numero,Binario):- A is (Numero div 2), B is (Numero mod 2), intBinario(A,Bin), atom_concat(Bin,B,Binario).


% 8-  Ingresar una cadena y un carácter, luego informar la cantidad de veces que aparece dicho carácter en la cadena. 

ej8:- write("Ingrese una cadena: "), read(Cadena), write("Ingrese un caracter: "), read(Caracter), contador(Cadena, Caracter, X), write(X).
contador('',_,0).
contador(Cadena,Caracter,Cantidad):- sub_atom(Cadena,0,1,_,Caracter), sub_atom(Cadena,1,_,0,Sub),contador(Sub,Caracter,Cant), Cantidad is Cant+1.
contador(Cadena,Caracter,Cantidad):-sub_atom(Cadena,1,_,0,Sub),contador(Sub,Caracter,Cantidad).


