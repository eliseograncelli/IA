/*[IA] Examen 13.09.2023:
Práctica:
Base de datos:
Paciente (dni, nombre,obra social).
Profesional(dni,nombre,especialidad,obra social).
Turno(dnipaciente,dniprofesional,especialidad,fecha,obra social,monto).
Pedía:
1 - Ingresar nombre de paciente y año y listar todas las especialidades SIN REPETIR en que se había atendido ese paciente en ese año.
2- Mostrar de todos los profesionales de la bbdd, el nombre y la cantidad de turnos donde el monto fuera mayor a 1500.
*
*/

:-dynamic(panciente/3).
:-dynamic(profesional/4).
:-dynamic(turno/6).

inicio:- 
    abrir_base, nl,
    write('1 Especialidades en las que se atendio un paciente -- 2 Cant turnos por profesional: '),
    read(Op), 
    menu(Op), 
    inicio.

abrir_base:- 
true.
 %   retractall(Paciente(_,_,_)),
 %  retractall(Profesional(_,_,_,_)),
 %   retractall(Turno(_,_,_,_,_,_)),
 %   consult('C:/.../datos.txt').

menu(1):-
    write('Ingrese nombre del paciente: '), read(NombrePaciente), nl,
    paciente(Dni,NombrePaciente,_),
    write('Ingrese año a consultar: '), read(Anio), nl,
    buscarEspecialidades(Dni,Anio, ListaEsp),
    ListaEsp\=[],
    writeln(ListaEsp)
    .

menu(2):- listarProfesionales.
    
    


buscarEspecialidades(Dni,Anio,[Esp|Resto]):-
    turno(Dni,_,Esp,Fecha,_,_),
    sub_atom(Fecha,0,4,_,Anio),
    retractall(turno(Dni,_,Esp,_,_,_)),
    
    buscarEspecialidades(Dni,Anio,Resto).

buscarEspecialidades(_,_,[]).



%turno(DNIPaciente, DNIProfesional, Especialidad, Fecha, ObraSocial, Monto).
listarProfesionales:-
    profesional(Dni,Nombre,_,_),
    retractall(profesional(Dni,_,_,_)),
    sub_atom(Nombre,0,_,_,'Dr.'),
    write('Profesional dni n° '), write(Dni), write(' - '),
    buscarTurnos(Dni,Cant),
    write(Cant), nl,
    listarProfesionales.

listarProfesionales.


buscarTurnos(Dni,Cant):-
    turno(DniP,Dni,Esp,Fecha,OS,Monto), %fechaaa
    retract(turno(DniP,Dni,Esp,Fecha,OS,Monto)),
   % retract(turno(_,Dni,_,Fecha,_,Monto)),
    Monto>1500,
    buscarTurnos(Dni,Cant2),
    Cant is Cant2 + 1.

buscarTurnos(_,0).








% Pacientes: paciente(DNI, Nombre, ObraSocial).
paciente(12345678, 'Juan', 'OSDE').
paciente(87654321, 'Maria Lopez', 'Swiss Medical').
paciente(11223344, 'Carlos Gomez', 'IOMA').

% Profesionales: profesional(DNI, Nombre, Especialidad, ObraSocial).
profesional(11112222, 'Dr. Ana Martinez', 'Cardiologia', 'OSDE').
profesional(33334444, 'Dra. Luis Fernandez', 'Pediatria', 'Swiss Medical').
profesional(55556666, 'Dr. Sofia Alvarez', 'Dermatologia', 'IOMA').

% Turnos: turno(DNIPaciente, DNIProfesional, Especialidad, Fecha, ObraSocial, Monto).
turno(12345678, 11112222, 'Cardiologia', '2023-11-20', 'OSDE', 2000).
turno(87654321, 33334444, 'Pediatria', '2024-11-22', 'Swiss Medical', 2500).
turno(12345678, 55556666, 'Dermatologia', '2023-11-20', 'OSDE', 1000).
turno(12345678, 33334444, 'Pediatria', '2024-11-20', 'OSDE', 2000).
turno(12345678, 11112222, 'Cardiologia', '2024-11-20', 'OSDE', 2000).
turno(11223344, 55556666, 'Dermatologia', '2024-11-25', 'IOMA', 1500).
