%% ==========================================================
% DATOS Experimentales vs MODELO Alfaro Primer Orden 
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
% MODELO TOOLBOX (System Identification)
% ================================
K     = 0.7621;
tau   = 179.27;
tdead = 36.886;

%% ===============================
% Crear modelo:
% G(s)=K*exp(-Td*s)/(tau*s+1)
% ================================
s = tf('s');
Gp = K*exp(-tdead*s)/(tau*s + 1);

%% ===============================
% Simular respuesta al escalón real
% ================================
A = max(U);              % amplitud real del escalón
y_model = step(A*Gp, t);

%% ===============================
% Gráfica comparativa
% ================================
T1= T-24,2913000977517;
figure('Name','Modelo Toolbox vs Datos Reales', ...
       'NumberTitle','off');

plot(t,T1,'y','LineWidth',2); hold on;
plot(t,y_model,'--b','LineWidth',2);

grid on;
xlabel('Tiempo (s)');
ylabel('Temperatura (°C)');
title('Datos Reales vs Modelo de Alfaro');

legend('Datos Reales','Modelo Alfaro','Location','best');

xlim([0 max(t)])

%% ===============================
% Error cuadrático medio
% ================================
ECM = mean((T1 - y_model).^2);

disp(['Error cuadrático medio = ', num2str(ECM)]);