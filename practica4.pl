%inicio:- abrir_base(), listar, halt.


%abrir_base:- consult('/home/eliseo/datos.pl').
%listar:- listing(gasto).


%gasto(juan,luz).
%gasto(juan,agua).
%gasto(juan,telefono).

/*
:-dynamic(padres/3). %El predicado es dinámico
:-dynamic(gasto/2).

inicio:-abrir_base,
        agregarNuevo,
        guardar, halt.

abrir_base:-consult('/home/eliseo/datos.pl').

agregarNuevo:-write('Ingrese hijo:'), read(H), 
              write('Ingrese madre:'), read(M), 
              write('Ingrese padre:'), read(P),
              assert(padres(H,M,P)).

guardar:-tell('/home/eliseo/datos.pl'), listing(padres), told.
*/

% 1- Hacer un programa que permita definir las cuentas a pagar del mes (luz, 
% agua, alquiler, teléfono, cable, supermercado, etc.) de un grupo de 
% personas. A su vez, deberá permitir ingresar el nombre de una de ellas e 
% informar de todos sus gastos
/*
:-dynamic(luz/2).
:-dynamic(gas/2).
:-dynamic(agua/2).

inicio:- abrir_base,
    writeln("Seleccione una opcion: "),
    writeln("1 cargar una nueva cuenta"),
    writeln("2 conocer las cuentas de una persona"),
    read(OP),
    menu(OP),
    guardar.

menu(1):- writeln("Ingrese el tipo de factura a cargar: "),read(Tipo),agregarNuevo(Tipo).
menu(2):- writeln("Ingrese el nombre de una persona: "),read(Per),mostrar(Per),consult('/home/eliseo/Escritorio/IA/Prolog/datos.pl').

abrir_base:- retractall(luz(_,_)),retractall(gas(_,_)),retractall(agua(_,_)),consult('/home/eliseo/Escritorio/IA/Prolog/datos.pl').

agregarNuevo('luz'):- write('Ingrese el nombre de quien corresponde la cuenta: '),read(P),
    write('Ingrese monto de la cuenta:'),read(M),
    assert(luz(P,M)).
agregarNuevo('agua'):- write('Ingrese el nombre de quien corresponde la cuenta: '),read(P),
    write('Ingrese monto de la cuenta:'),read(M),
    assert(agua(P,M)).
agregarNuevo('gas'):- write('Ingrese el nombre de quien corresponde la cuenta: '),read(P),
    write('Ingrese monto de la cuenta:'),read(M),
    assert(gas(P,M)).

guardar:-tell('/home/eliseo/Escritorio/IA/Prolog/datos.pl'),listing(luz),listing(gas),listing(agua),told.

mostrar(P):- luz(P,M),writeln("luz":M),retract(luz(P,M)),mostrar(P).
mostrar(P):- gas(P,M),writeln("gas":M),retract(gas(P,M)),mostrar(P).
mostrar(P):- agua(P,M),writeln("agua":M),retract(agua(P,M)),mostrar(P).
mostrar(_).
*/

% Hacer un programa que defina una Base de datos de personas de la 
% siguiente forma: 
% personas(codigo,nombre). 
% El programa debe permitir ingresar un código y verificar si el mismo está 
% definido en la BBDD. De estarlo deberá informar a quién corresponde, de lo 
% contrario deberá solicitar ingresar un nombre y registrar entonces la 
% persona en la BBDD. 

:- dynamic(personas/2).

inicio:-abrir_base,write('Ingrese codigo: '), read(Cod), buscar(Cod),guardar.

abrir_base:-retractall(personas(_,_)), consult('/home/eliseo/Escritorio/IA/Prolog/persons.pl').
guardar:-tell('/home/eliseo/Escritorio/IA/Prolog/persons.pl'),listing(personas),told.
buscar(Cod):-personas(Cod,Nombre), write('Se encontro la persona buscada: '), write(Nombre).
buscar(Cod):-write('No se encontro la persona buscada. Ingrese su nombre: '), read(Nombre), assert(personas(Cod,Nombre)).


