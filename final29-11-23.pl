/* FINAL 29/11/2023
% computadora(id, tipo, precio, stock, [características])
% ventas(id, fecha, [idCompusVendidas])
fecha es aaaa-mm-dd
ingresar un año y mes ("2023-10") y mostrar el monto total recaudado ese mes (una venta puede tener varias veces la misma pc, hay que hacer dos sumadores)
ingresar una lista de características y devolver otra lista que contenga *sin repetir* los id de pc que contengan esas características (evaluar cada característica de la lista ingresada para cada característica de la pc) */

:-dynamic(computadora/5).
:-dynamic(ventas/3).

inicio:- 
    abrir_base,
    writeln('1 Monto recaudado en un mes'),
    writeln('2 Buscar pc por caracteristica'),
    write('Ingrese una opcion: '),
    read(Op),
    menu(Op),
    inicio.

abrir_base:- 
     retractall(computadora(_,_,_,_,_)),
     retractall(ventas(_,_,_)),
     consult('/home/eliseo/Escritorio/BDPrueba.txt').
    %true.

menu(1):- 
    write('Ingrese año y mes a consultar (AAAA-MM): '),
    read(Fecha),
    calcularRecaudado(Fecha,Monto),
    write('Recaudado: '), writeln(Monto).

menu(2):- 
    write('Ingrese caracteristicas deseadas para su pc: '),
    leer(Caracteristicas),
    buscaPC(Caracteristicas,Lista),
    writeln(Lista).

calcularRecaudado(Fecha,Monto):-
    ventas(Id,FechaVenta,PCVendidas),
    retract(ventas(Id,FechaVenta,PCVendidas)),
    sub_atom(FechaVenta,0,7,_,Fecha),
    calculadora(PCVendidas,SubTotal),
    calcularRecaudado(Fecha,Monto2),
    Monto is Monto2 + SubTotal.

calcularRecaudado(_,0).

calculadora([],0).

calculadora([Pc1|Resto],SubTotal):-
    computadora(Pc1,_,Precio,_,_),
   % retract(computadora(Pc1,_,Precio,_,_)),
    calculadora(Resto,SubTotal2),
    SubTotal is SubTotal2 + Precio.

leer([H|T]):- read(H), H\=[], leer(T).
leer([]).

buscaPC([],[]).

buscaPC(CaracteristicasReq,[Id|Otras]):-
    computadora(Id,_,_,_,Caracteristicas),
    retract(computadora(Id,_,_,_,Caracteristicas)),
    verCaracteristicas(CaracteristicasReq,Caracteristicas),
    buscaPC(CaracteristicasReq,Otras).

verCaracteristicas([Primer|_], Caracteristicas):-
    compruebaCaracteristicas(Primer,Caracteristicas).

verCaracteristicas([_|Resto],Caracteristicas):-
    verCaracteristicas(Resto,Caracteristicas).

compruebaCaracteristicas(Caracteristica1,[Caracteristica1|_]).
compruebaCaracteristicas(Caracteristica1,[_|Resto]):-compruebaCaracteristicas(Caracteristica1,Resto).




% % computadora(id, tipo, precio, stock, [características])
% computadora(1, 'Laptop', 1500, 10, ['Intel i5', '8GB RAM', '256GB SSD', 'Windows 10']).
% computadora(2, 'Desktop', 1200, 5, ['AMD Ryzen 5', '16GB RAM', '512GB SSD', 'Linux']).
% computadora(3, 'Laptop', 2000, 7, ['Intel i7', '16GB RAM', '1TB SSD', 'Windows 11']).
% computadora(4, 'All-in-One', 1800, 4, ['Intel i5', '8GB RAM', '1TB HDD', 'Windows 10']).
% computadora(5, 'Desktop', 1400, 6, ['Intel i5', '32GB RAM', '2TB HDD', 'Windows 10']).

% % ventas(id, fecha, [idCompusVendidas])
% ventas(1, '2023-10-01', [1, 2, 1]).
% ventas(2, '2023-10-15', [3, 3, 4]).
% ventas(3, '2023-11-01', [5, 5]).
% ventas(4, '2023-10-20', [1, 3]).
% ventas(5, '2023-09-15', [2, 4]).
% ventas(6, '2023-10-30', [2, 2, 3]).

    
