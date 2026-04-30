%% ==========================================
% RESPUESTA EXPERIMENTAL DEL SISTEMA TÉRMICO
% Temperatura referida al ambiente
% ==========================================
close all;
clear;
clc;

%% Cargar datos
Datos = xlsread('DatosPractica2 - copia.xls');

t = Datos(:,1);      % tiempo
U = Datos(:,2);      % entrada
T = Datos(:,3);      % temperatura medida

%% Eliminar temperatura ambiente
T1 = T - 24.2913000977517;

%% Gráfica experimental
figure('Name','Respuesta Experimental','NumberTitle','off');

plot(t,T1,'y','LineWidth',2); hold on;
plot(t,U,'--c','LineWidth',2);

grid on;
xlabel('Tiempo (s)');
ylabel('Temperatura (°C) / Entrada (%)');
title('Respuesta Experimental del Sistema de Temperatura');

legend('Temperatura Experimental','Entrada Escalón', ...
       'Location','best');

xlim([0 max(t)])