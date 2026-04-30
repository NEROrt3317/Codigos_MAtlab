%% ==========================================================
% COMPARACIÓN GENERAL:
% Datos Reales + 3 Modelos Identificados
% ==========================================================
close all;
clear;
clc;

%% ===============================
% Cargar datos experimentales
% ================================
Datos = xlsread('DatosPractica2 - copia.xls');

t = Datos(:,1);      % tiempo
U = Datos(:,2);      % entrada
T = Datos(:,3);      % temperatura medida

% Quitar temperatura inicial
T1 = T - 24.2913000977517;

A = max(U);          % amplitud del escalón

s = tf('s');

%% ==========================================================
% MODELO 1: Primer Orden Alfaro
% ==========================================================
K1     = 0.7621;
tau1   = 179.27;
td1    = 36.886;

G1 = K1*exp(-td1*s)/(tau1*s + 1);
y1 = step(A*G1,t);

%% ==========================================================
% MODELO 2: Primer Orden Toolbox
% ==========================================================
K2     = 0.76309;
tau2   = 180.082;
td2    = 41.849;

G2 = K2*exp(-td2*s)/(tau2*s + 1);
y2 = step(A*G2,t);

%% ==========================================================
% MODELO 3: Segundo Orden Toolbox
% ==========================================================
K3   = 0.76109;
tp1  = 131.6555;
tp2  = 100.7829;

G3 = K3 / ((tp1*s + 1)*(tp2*s + 1));
y3 = step(A*G3,t);

%% ==========================================================
% ERRORES
% ==========================================================
ECM1 = mean((T1-y1).^2);
ECM2 = mean((T1-y2).^2);
ECM3 = mean((T1-y3).^2);

%% ==========================================================
% GRÁFICA FINAL
% ==========================================================
figure('Name','Comparación General de Modelos', ...
       'NumberTitle','off');

plot(t,T1,'y','LineWidth',2); hold on;          % Datos reales
plot(t,y1,'--b','LineWidth',2);                % Alfaro
plot(t,y2,'--m','LineWidth',2);                % Toolbox 1er orden
plot(t,y3,'--c','LineWidth',2);                % Toolbox 2do orden

grid on;
xlabel('Tiempo (s)');
ylabel('Temperatura (°C)');
title('Comparación entre Datos Reales y Modelos');

legend('Datos Reales', ...
       'Primer Orden Alfaro', ...
       'Primer Orden Toolbox', ...
       'Segundo Orden Toolbox', ...
       'Location','best');

xlim([0 max(t)])

%% ==========================================================
% MOSTRAR ERRORES
% ==========================================================
disp('============== ERRORES CUADRÁTICOS MEDIOS ==============')
disp(['Modelo Alfaro           = ', num2str(ECM1)])
disp(['Primer Orden Toolbox    = ', num2str(ECM2)])
disp(['Segundo Orden Toolbox   = ', num2str(ECM3)])