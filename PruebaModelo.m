% Prueba de lazo abierto en el modulo temperatura 
% Fecha 10-03-2026

% Variables para Modelo.slx
tsim = 2500;
Aesc = 57;
tesc = 5;

% Ejecutar Simulink
sim('Modelo', tsim)
t = DatosModelo.time;
T2 = DatosModelo.signals(1).values;
m = DatosModelo.signals(2).values;

% Grafica 
figure;
plot(t, m, '--p', t, T2, 'LineWidth', 1);
grid;
legend('m(t)', 'T2(t)')



% Crear Archivo Excel
A = [t m T2];
xlswrite('DatosPractica2', A)