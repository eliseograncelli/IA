/* AD 18/10/2023 - EjercicioArtistas
artista(idArtista,nombre,otros_datos)
cancion(idCancion,IdArtista,fecha_lanzamiento, otros_datos)
usuario(idUsuario,nombre,otros_datos,[Lista_canciones_que_le_gustan])
listaReproduccion(IdLista,IdUsuario,otros_datos,[Lista_Canciones]

Nota:
Un usuario podía tener muchas listas de reproduccion con muchas canciones.
Fecha_lanzamiento, tipo DATE: ‘DD/MM/YYYY’
1) Dado un año, listar [] aquellos artistas que hayan lanzado canciones en dicho año. No podía haber artistas repetidos en la lista.
2) Mostrar para cada usuario la cantidad de Listas de Reproducción y el promedio de canciones por lista del usuario. (No hacía falta hacer lista). */

:-dynamic(artista/3).
:-dynamic(cancion/4).
:-dynamic(usuario/4).
:-dynamic(listaReproduccion/4).

inicio:-
    abrir_base, nl,nl,
    writeln('1- Conocer que artista lanzo canciones un año '), 
    writeln('2- Cant listas de reproduccion usuario'), write('Seleccione una: '), 
    read(Op),
    menu(Op),
    inicio.

abrir_base:- 
    % retractall(artista(_,_,_)),
    % retractall(cancion(_,_,_,_)),
    % retractall(usuario(_,_,_,_)),
    % retractall(listaReproduccion(_,_,_,_)),
    % consult('BD.txt'),
    true.

menu(1):- 
    write('Año a consultar: '), 
    read(Anio), 
    buscarArtistas(Anio,ListaAnio), 
    writeln(ListaAnio)
    .

menu(2):-
    mostrarUsuarios.


buscarArtistas(Anio,[NomArtista|Resto]):-
    cancion(_,IdArt,Fecha,_),
    retractall(cancion(_,IdArt,Fecha,_)),
    sub_atom(Fecha,6,_,_,Anio),
    artista(IdArt,NomArtista,_),
    %retract(artista(IdArt,NomArtista,_)),
    buscarArtistas(Anio,Resto)
    .

buscarArtistas(_,[]).



mostrarUsuarios:- 
    usuario(IdUs,NombreUs,_,_),
    write('Usuario '),
    write(NombreUs),
    retract(usuario(IdUs,NombreUs,_,_)),
    contarListas(IdUs,Cant,Acum),
    Promedio is Acum/Cant,
    write(' tiene '), write(Cant), write(' lista/s, con un promedio de '), 
    write(Promedio), writeln(' canciones por lista'),
    mostrarUsuarios.

mostrarUsuarios.

contarListas(IdUs,Cant,Acum):-
    listaReproduccion(IdLista,IdUs,_,ListaCanciones),
    retract(listaReproduccion(IdLista,IdUs,_,ListaCanciones)),
    contarCanciones(ListaCanciones,Cantidad),
    contarListas(IdUs,Cant2,Acum2),
    Cant is Cant2 + 1,
    Acum is Acum2 + Cantidad.

contarListas(_,0,0).

contarCanciones([],0).

contarCanciones([_|Resto],Cant):-
    contarCanciones(Resto,Cant2),
    Cant is Cant2 + 1.



% artista(IdArtista, Nombre, OtrosDatos).
artista(1, 'Queen', 'Rock legendarios').
artista(2, 'The Beatles', 'Banda icónica de los 60').
artista(3, 'Taylor Swift', 'Cantante y compositora pop').

% cancion(IdCancion, IdArtista, FechaLanzamiento, OtrosDatos).
cancion(101, 1, '24/11/1975', 'Bohemian Rhapsody, álbum: A Night at the Opera').
cancion(102, 1, '26/10/1981', 'Under Pressure, colaboración con David Bowie').
cancion(201, 2, '05/10/1962', 'Love Me Do, primer sencillo').
cancion(103, 2, '25/10/1981', 'Under Pressure, colaboración con David Bowie').
cancion(202, 1, '26/11/1981', 'Under Pressure, colaboración con David Bowie').
cancion(203, 2, '01/07/1969', 'Come Together, álbum: Abbey Road').
cancion(301, 3, '27/10/2014', 'Blank Space, álbum: 1989').
cancion(302, 3, '11/11/2022', 'Anti-Hero, álbum: Midnights').

% usuario(IdUsuario, Nombre, OtrosDatos, [ListaCancionesQueLeGustan]).
usuario(1, 'Alice', 'Fanática del rock', [101, 102, 201]).
usuario(2, 'Bob', 'Aficionado a la música clásica y pop', [201, 301, 302]).
usuario(3, 'Clara', 'Explora todo tipo de música', [102, 202, 302]).

% listaReproduccion(IdLista, IdUsuario, OtrosDatos, [ListaCanciones]).
listaReproduccion(1, 1, 'Lista favorita de Queen', [101, 102, 303]).
listaReproduccion(2, 1, 'Rock clásico', [101, 201]).
listaReproduccion(3, 2, 'Mezcla personal', [201, 301]).
listaReproduccion(4, 2, 'Pop moderno', [301, 302]).
listaReproduccion(5, 3, 'Top recientes', [302, 202]).
listaReproduccion(6, 3, 'Éxitos rockeros', [102, 303]).
listaReproduccion(7, 4, 'Clásicos inolvidables', [101, 201, 202]).
listaReproduccion(8, 4, 'Lo mejor de Queen', [101, 303]).
