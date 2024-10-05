:- dynamic(genero/2).
:- dynamic(series/3).
:- dynamic(generoUsuario/2).
:- dynamic(listaCaracteristicaDeseadaUsuario/1).
:- dynamic(listaCaracteristicaNoDeseadaUsuario/1).
:- dynamic(seriesRecomendadas/1).

clearScreen :-
	write('\e[H\e[2J').

cargarConocimiento :-
	retractall(genero(_,_)),retractall(series(_,_,_)),
	retractall(generoUsuario(_,_)),retractall(listaCaracteristicaDeseadaUsuario(_)),
	retractall(listaCaracteristicaNoDeseadaUsuario(_)),retractall(seriesRecomendadas(_)),
	consult('/home/eliseo/Escritorio/bd_generos.pl'),consult('/home/eliseo/Escritorio/bd_series.pl').

identificacionUsuario(Usuario) :-
	writeln("                      *** SISTEMA EXPERTO PARA RECOMENDAR SERIES ***"), nl,
	writeln("                                          Netflix®"),nl, nl,
	write(" ¿ME DECIS TU NOMBRE? ( En minúsculas, por favor ): "), read(Usuario), nl.


saludarUsuario(Usuario) :-
    write("Hola, "), write(Usuario), writeln(". Bienvenido!"),nl,
	writeln("Te voy a hacer algunas preguntas así te puedo recomendar lo que más se ajuste a tus gustos...").


validarGeneros :-
	% Pregunta al usuario si le interesa o no cada género en la bd de géneros
	genero(GeneroID,GeneroNombre),write("Te gusta las series del tipo "), write(GeneroNombre), write("? [s/n]: "),
	read(GeneroDecision),clasificarGenero(GeneroID,GeneroDecision,GeneroNombre), validarGeneros.

validarGeneros :-
	% Se ejecuta cuando no hay mas generos para ofrecer y el usuario seleccionó al menos uno
	generoUsuario(_,_),writeln("Esos son todos los géneros de series que conozco."),nl,
	validarseries.

validarGeneros :-
	% Se ejecuta cuando no hay más géneros para ofrecer y el usuario no selecciona ninguno
	not(generoUsuario(_,_)),writeln("Lamento mucho que no te gusten los géneros que conozco.").


clasificarGenero(GeneroID,GeneroDecision,_) :-
	% Se ejecuta cuando la respuesta es 'n'. Elimina todos las series con ese género
	GeneroDecision = 'n',retract(genero(GeneroID,_)),retractall(series(_,GeneroID,_)).

clasificarGenero(GeneroID,GeneroDecision,GeneroNombre) :-
	% Se ejecuta cuando la respuesta es 's'. Agrega a los géneros de usuario ese género
	GeneroDecision = 's',retract(genero(GeneroID,_)),assert(generoUsuario(GeneroID,GeneroNombre)).

clasificarGenero(_,_,_).
	% Se ejecuta cuando la respuesta no es 's' ni 'n'


validarseries :-
	% Se ejecuta cuando ya todos los géneros fueron recorridos
	writeln("Ok, sigamos con las preguntas..!"), nl,
	writeln("Contame las caracteristicas que te interesan:"),
	explorarCaracteristicasDeSeries.


explorarCaracteristicasDeSeries :-
	series(SeriesNombre,_,SeriesCaracteristicas),explorarCaracteristicas(SeriesNombre,SeriesCaracteristicas), explorarCaracteristicasDeSeries.

explorarCaracteristicasDeSeries :-
	% Se ejecuta cuando no hay mas series
	recomendarseries.


explorarCaracteristicas(SeriesNombre,[]) :-
	% Si no hay mas caracteristicas de una serie, entonces se la agrega como sugerencia y se avanza a la serie siguiente
	assert(seriesRecomendadas(SeriesNombre)),
	retract(series(SeriesNombre,_,_)).

explorarCaracteristicas(SeriesNombre,[CaracteristicasH|CaracteristicasT]) :-
	% Si la característica no fue aceptada ni rechazada por el usuario, entonces se efectúa una pregunta para poder categorizar
	not(listaCaracteristicaDeseadaUsuario(CaracteristicasH)),not(listaCaracteristicaNoDeseadaUsuario(CaracteristicasH)),
	validarCaracteristica(CaracteristicasH),explorarCaracteristicas(SeriesNombre,CaracteristicasT).

explorarCaracteristicas(SeriesNombre,[CaracteristicasH|CaracteristicasT]) :-
	% Si la característica está en lista de recomendación, las características restantes se exploran
	listaCaracteristicaDeseadaUsuario(CaracteristicasH),explorarCaracteristicas(SeriesNombre,CaracteristicasT).

explorarCaracteristicas(SeriesNombre,[CaracteristicasH|_]) :-
	% Si la característica está en lista de no recomendación, se descarta la serie y se sigue a la serie siguiente
	listaCaracteristicaNoDeseadaUsuario(CaracteristicasH),retract(series(SeriesNombre,_,_)).


validarCaracteristica(SeriesCaracteristica) :-
	% Pregunta por la característica que aún no ha sido clasificada
	write("> ..."),write(SeriesCaracteristica),write("? [s/n]"),
	read(CaracteristicaDecision),clasificarCaracteristica(SeriesCaracteristica,CaracteristicaDecision).


clasificarCaracteristica(SeriesCaracteristica,'n') :-
	% Pone la característica en lista de no recomendación y falla
	assert(listaCaracteristicaNoDeseadaUsuario(SeriesCaracteristica)),fail.

clasificarCaracteristica(SeriesCaracteristica,'s') :-
	% Pone la característica en lista de recomendación
	assert(listaCaracteristicaDeseadaUsuario(SeriesCaracteristica)).

clasificarCaracteristica(SeriesCaracteristica,CaracteristicaDecision) :- CaracteristicaDecision \= 'n', nl, writeln('Esa no es una opcion correcta'), nl, validarCaracteristica(SeriesCaracteristica).

recomendarseries :-
	% Se ejecuta cuando hay géneros seleccionados por el usuario pero no hay series
	generoUsuario(_,_),not(seriesRecomendadas(_)),
	nl,writeln("Lamento mucho que no te gusten las series que conozco.").

recomendarseries :-
	% Se ejecuta si hay series recomendadas
	nl,writeln("¡Encontré series que se ajustan a tus gustos!"),writeln("Las series son: "),nl,
	listarSeriesRecomendadas.

listarSeriesRecomendadas :-
	seriesRecomendadas(SeriesNombre),write("- "),writeln(SeriesNombre),
	retract(seriesRecomendadas(SeriesNombre)),listarSeriesRecomendadas.

listarSeriesRecomendadas.

despedirUsuario(Usuario) :-
    nl,write("Chau "),write(Usuario),write("! Nos vemos!").


recomendame :-clearScreen,cargarConocimiento,identificacionUsuario(Usuario),saludarUsuario(Usuario),validarGeneros,despedirUsuario(Usuario).