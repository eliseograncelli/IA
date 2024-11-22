/* FINAL 2016-02-25
Socio(dni, apellido, sexo, edad)
Ejercicio(cod, descripcion, cod.nivel, sexorecomendado, edaddesde, edadhasta)
Asistencia(fecha, dni, minentreno, [codejercicios realizados])
Nivel(cod nivel, descripcion, canthoradesde, canthorahasta)
A tener en cuenta:
Nivel: inicial (de 0 hs a 72 hs) medio (de tanto a tanto) avanzado (de tanto a tanto) y extremo(de tanto a tanto)

1. Ingresar un dni de un socio e informar:
a. El nivel en el que se encuentra (teniendo en cuenta la asistencia)
b. Los ejercicios que recomienda realizar de acuerdo a su nivel, sexo y edad.
2. Ingresar una fecha y un cod ejercicio e informar los socios que lo realizaron en esa fecha. */

:-dynamic(socio/4).
:-dynamic(ejercico/6).
:-dynamic(asistencia/4).
:-dynamic(nivel/4).

inicio:- 
    abrir_base,
    writeln('1- Informe socio.'),
    writeln('2- Socios que asistan un dia a un ejercicio.'),
    write('Ingrese una opcion: '),
    read(Opc),
    menu(Opc),
    inicio.

abrir_base:- 
    nl,nl,
    retractall(socio(_,_,_,_)),
    retractall(ejercicio(_,_,_,_,_,_)),
    retractall(asistencia(_,_,_,_)),
    retractall(nivel(_,_,_,_)),
    consult('/home/eliseo/Escritorio/BDPrueba.txt').

menu(1):-
    write('Ingrese dni: '),
    read(Dni),
    consultaSocio(Dni).

menu(1).

menu(2):- 
    write('Ingrese fecha: '),
    read(Fecha), nl,
    write('Ingrese cod ejercicio: '),
    read(Cod), nl,
    consultaAsistencia(Fecha,Cod).


menu(2).

consultaSocio(Dni):-
    calculaTiempo(Dni,Minutos),
    calculaNivel(Minutos,CodNivel),
    write('Nivel: '),
    writeln(CodNivel),   % VER SI PUEDO MOSTRAR EL NOMBRE DEL NIVEL EN VEZ DEL CODIGO
    recomiendaEj(Dni,CodNivel,Ejercicios),
    Ejercicios\=[],
    writeln(Ejercicios).

consultaSocio(_):- writeln('No se encontro el socio y/o ejercicios recomendados').

calculaTiempo(Dni,Tiempo):-
    asistencia(Fecha,Dni,Min,_),
    retract(asistencia(Fecha,Dni,Min,_)),
    calculaTiempo(Dni,Tiempo2),
    Tiempo is Tiempo2 + Min.

calculaTiempo(_,0).

calculaNivel(Min,Cod):- 
    nivel(Cod,_,Desde,Hasta),
    Min > Desde, 
    Min < Hasta.

calculaNivel(_,_).

recomiendaEj(Dni,Cod,[Ej1|Resto]):-    
    socio(Dni,_,Sexo,Edad),
    ejercicio(CodEj,Ej1,Cod,Sexo,Desde,Hasta),
    Desde=<Edad, 
    Hasta>=Edad,
    retract(ejercicio(CodEj,Ej1,Cod,Sexo,Desde,Hasta)),
    recomiendaEj(Dni,Cod,Resto).

recomiendaEj(_,_,[]).


consultaAsistencia(Fecha,Cod):- 
    asistencia(Fecha,Socio,_,Ejercicios),
    retract(asistencia(Fecha,Socio,_,Ejercicios)),
    pertenece(Cod,Ejercicios),
    write('- '), writeln(Socio),
    consultaAsistencia(Fecha,Cod).

consultaAsistencia(_,_).


% consultaAsistencia(Fecha,Cod,[Soc1|Resto]):- 
%     asistencia(Fecha,Soc1,_,Ejercicios),
%     retract(asistencia(Fecha,Soc1,_,Ejercicios)),
%     pertenece(Cod,Ejercicios),
%     consultaAsistencia(Fecha,Cod,Resto).

% consultaAsistencia(Fecha,Cod,[_,Resto]):- 
%     consultaAsistencia(Fecha,Cod,Resto).

% consultaAsistencia(_,_,[]).

pertenece(Cod,[Cod|_]).
pertenece(Cod,[_,Resto]):- pertenece(Cod,Resto).

