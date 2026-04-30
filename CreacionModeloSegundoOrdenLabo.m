%% ==========================================================
% DATOS REALES vs MODELO DE SEGUNDO ORDEN (P2D TOOLBOX)
% 
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
T = Datos(:,3);      % temperatura real

%% ===============================
% Parámetros del modelo P2D
% MATLAB System Identification
% ================================
K   = 0.76109;
tp1 = 131.6555;
tp2 = 100.7829;
td  = 0;

%% ===============================
% Función de transferencia:
% G(s)=K / ((tp1*s+1)(tp2*s+1))
% ================================
s = tf('s');
Gp = K / ((tp1*s + 1)*(tp2*s + 1));

%% ===============================
% Simulación con entrada real
% ================================
A = max(U);                  % amplitud del escalón real
y_model = step(A*Gp,t);

% Ajustar condición inicial
%y_model = y_model + T(1);

%% ===============================
% Gráfica comparativa
% ================================
T1= T-24,2913000977517;

figure('Name','Modelo Segundo Orden vs Datos Reales', ...
       'NumberTitle','off');

plot(t,T1,'y','LineWidth',2); hold on;       % amarillo visible
plot(t,y_model,'--c','LineWidth',2);        % cian modelo

grid on;
xlabel('Tiempo (s)');
ylabel('Temperatura (°C)');
title('Datos Reales vs Modelo de Segundo Orden');

legend('Datos Reales','Modelo Segundo Orden', ...
       'Location','best');

xlim([0 max(t)])

%% ===============================
% Error Cuadrático Medio
% ================================
ECM = immse(T1,y_model);
RMSE = sqrt(ECM);

disp(['Error cuadrático medio = ', num2str(ECM)]);
disp(['RMSE = ', num2str(RMSE), ' °C']);