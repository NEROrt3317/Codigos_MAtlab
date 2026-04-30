%Algoritmo controlador PID
%Elaborado por: Duby Castellanos
%Fecha: 21-04-2026
%*************************************

clear all;
close all;
clc;

%Configurar tiempo de simulación
tfin = 2500;

%Configurar el escalón
tesc = 5;
A = 40; %Grados

%Función de transferencia
Kp = 0.83;
tao = 223;
num = Kp;
den = [tao 1];
tdead = 27.8;

%Controlador P
Kc = 2.5;

%Controlador PI
Kc_i = 0.5;
ti = 20;

%Controlador PID
Kc_d = 0.2;
ti_d = 15;
t_d = ti_d*0.2

%Ejecutar simulink
ans = sim('SimControladorPI.slx', tfin);
t = ans.tout;
yout = ans.DatosOut.signals(1).values; %Respuesta del controlador proporcional
r = ans.DatosOut.signals(2).values; %Referencia
y_pi = ans.DatosOut.signals(3).values;
y_pid = ans.DatosOut.signals(4).values;%Respuesta del PID
figure;
plot(t,r,'--k',t,yout, t, y_pi, t, y_pid,'LineWidth',1)%cambiar el tipo de linea, cambiar colores
grid;
legend('r(t)','T_p(t)','T_{pi}(t)', 'T_{pid}(t)' );
title('Controladores');

