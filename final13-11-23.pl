/* Examen 13/11/2023
Se tiene la siguiente estructura:
heladeria(codigoH, nombre, telefono)
locales(codigoH, zona, [direcciones])
 -> Ingresar una lista de heladerias y devolver otra lista de heladerias que tenga al menos una sucursal en el centro.
 -> Ingresar una calle y devolver una lista con los nombres sin repetir de aquellas heladerias que se encuentran sobre esa calle.
Tener en cuenta que una heladeria puede tener mas de una sucursal en la misma calle.
Nota: las direcciones son de la forma "Pellegrini 1333", "Pte. Roca 999". Nos dieron 50 minutos para hacerlo. */

:-dynamic(heladeria/3).
:-dynamic(locales/3).

inicio:- 
    abrir_base, 
    write('1 listar heladerias centro -- 2 Heladerias en calle X: '),
    read(Op), 
    menu(Op), nl,
    inicio.

abrir_base:- 
    % retractall(heladeria(_,_,_)),
    % retractall(locales(_,_,_)),
    % consult('datos.txt').
    true.

menu(1):- 
    write('Ingrese heladerias a consultar: '), 
    leer(Lista),
    consultaHeladeriasCentro(Lista,ListaCentro),
    write(ListaCentro).

menu(2):- 
    write('Ingrese calle a consultar: '), 
    read(Calle),
    consultaPorCalle(Calle, ListaHeladeriasCalle),
    write(ListaHeladeriasCalle).

leer([H|T]):-read(H), H\=[], leer(T).
leer([]).

consultaHeladeriasCentro([H1|Resto],[H1|Extra]):-
    heladeria(Cod,H1,_),
   % retract(heladeria(Cod,H1,_)),                         % Por que no va el retract?
    locales(Cod,'Centro',_),
  %  retract(locales(Cod,'Centro',_)),
    consultaHeladeriasCentro(Resto,Extra).

consultaHeladeriasCentro([],[]).


consultaPorCalle(Calle, [H1|Resto]):-
    locales(Cod,_,Dir),
    retract(locales(Cod,_,Dir)),
    pertenece(Calle,Dir),
    heladeria(Cod,H1,_),
    retractall(heladeria(Cod,H1,_)),
    consultaPorCalle(Calle,Resto).

consultaPorCalle(_,[]).

pertenece(Calle,[Direc|_]):-sub_atom(Direc,_,_,_,Calle).
pertenece(Calle,[_|Resto]):-pertenece(Calle,Resto).




% Base de datos de heladerías y locales

% heladeria(CodigoH, Nombre, Telefono).
heladeria(101, 'grido', '555-1234').
heladeria(102, 'colinas', '555-5678').
heladeria(103, 'marbet', '555-8765').

% locales(CodigoH, Zona, [Direcciones]).
locales(101, 'Centro', ['Av. Principal 123', 'Calle Secundaria 45']).
locales(102, 'Centro', ['Av. Principal 124', 'Calle Secundaria 44']).
locales(102, 'Centro', ['Av. Principal 165', 'Calle Secundaria 49']).
locales(101, 'Norte', ['Av. Norte 89']).
locales(102, 'Sur', ['Calle Sur 12', 'Av. Las Flores 33']).
locales(103, 'Este', ['Boulevard Este 77', 'Calle del Sol 90']).
