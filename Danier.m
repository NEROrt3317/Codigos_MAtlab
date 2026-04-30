% ==========================================================
% LIMPIAR ENTORNO
% ==========================================================
clc;
clear;
close all;

%% =========================================================
% LECTURA DE DATOS
% ==========================================================
Datos = xlsread('DatosDanier.xls');

t = Datos(:,1);   % tiempo
T = Datos(:,2);   % señal de entrada
U = Datos(:,3);   % temperatura medida

%% =========================================================
% PARÁMETROS DEL MODELO (SEGUNDO ORDEN)
% ==========================================================
K   = 0.49313;%0.49109;
tp1 = 299.7747;%178.4663;
tp2 = 160.351;%11.8785;
td  = 0;   % retardo (no utilizado)

%% =========================================================
% DEFINICIÓN DE LA FUNCIÓN DE TRANSFERENCIA
% G(s) = K / [(tp1*s + 1)(tp2*s + 1)]
% ==========================================================
s = tf('s');
Gp = (K * exp(-td*s)) / ((tp1*s + 1)*(tp2*s + 1));

%% =========================================================
% SIMULACIÓN DEL SISTEMA
% ==========================================================
A = max(U);                      % amplitud de la señal
y_model = step(Gp * A, t);       % respuesta del modelo

% Ajuste opcional de condición inicial
% y_model = y_model + T(1);

%% =========================================================
% ELIMINACIÓN DE OFFSET
% ==========================================================
T1 = T - T(1);

%% =========================================================
% GRÁFICA COMPARATIVA
% ==========================================================
figure;

plot(t, T1, 'b', 'LineWidth', 2); hold on;
plot(t, y_model, '--r', 'LineWidth', 2);

grid on;
title('Modelo de segundo Orden vs Datos Experimentales');
xlabel('Tiempo (s)');
ylabel('Temperatura (°C)');

legend('Datos reales ajustados', 'Modelo', 'Location', 'best');

xlim([0 max(t)]);

%% =========================================================
% CÁLCULO DE ERRORES
% ==========================================================
ECM = immse(T1, y_model);
RMSE = sqrt(ECM);

fprintf('Error cuadrático medio: %.6f\n', ECM);
fprintf('RMSE: %.6f °C\n', RMSE);