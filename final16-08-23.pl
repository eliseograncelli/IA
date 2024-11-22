/* FINAL 16/08/23
unidades(NroUnidad,Marca,Modelo).
viajes(NroUnidad,Costo).
1.Calcular Total de Viajes para cada Unidad.
2.Segun lista de Unidades ingresadas, lista las que tengan Viajes mayores a 5000. */

:-dynamic(unidades/3).
:-dynamic(viajes/2).

inicio:- 
    abrir_base, nl,nl,
    writeln('1- Cant viajes por unidad '), 
    writeln('2- Unidades con viajes mayores a 5000 '),
    write('Ingrese una opcion: '),
    read(Op),
    menu(Op),
    inicio.

abrir_base:-
    retractall(unidades(_,_,_)),
    retractall(viajes(_,_)),
    consult('/home/eliseo/Escritorio/BDPrueba.txt').

menu(1):- 
    cuentaViajes.

 menu(2):- 
     write('Ingrese unidades a consultar: '),
     leer(Lista),
     consultaViajes(Lista, ListaFinal),
     ListaFinal\=[],
     write(ListaFinal).

menu(2):- writeln('No hay unidades con viajes por mas de 5000.').


cuentaViajes:-
    unidades(NroUnidad,_,_),
    retract(unidades(NroUnidad,_,_)),
    contarViajesUnidad(NroUnidad, Cant),
    write('La unidad nro '), write(NroUnidad), write(' hizo '), write(Cant), writeln(' viajes'),
    cuentaViajes.

cuentaViajes.

contarViajesUnidad(Nro, Cant):- 
    viajes(Nro,_),
    retract(viajes(Nro,_)),
    contarViajesUnidad(Nro,Cant2),
    Cant is Cant2 + 1.

contarViajesUnidad(_,0).

leer([H|T]):- 
    read(H),
    H\=[],
    leer(T).

leer([]).

consultaViajes([],[]).

consultaViajes([H|T],[H|Resto]):-
    viajes(H,Costo), Costo>5000,
    retract(viajes(H,Costo)),
    consultaViajes(T,Resto).

consultaViajes([_|T],Lista):- 
    consultaViajes(T,Lista).






