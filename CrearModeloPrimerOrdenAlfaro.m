
%% GRAFICAR DATOS REALES vs MODELO FOPDT (Método de Alfaro)
clear; clc; close all;

%% ===============================
% Cargar datos experimentales
% ================================
% Cambia el nombre si tu archivo tiene otro nombre
Datos = xlsread('DatosPractica2 - copia.xls');

t = Datos(:,1);     % tiempo real
u = Datos(:,2);     % temperatura real
y = Datos(:,3);     % señal de entrada (si existe tercera columna)

%% ===============================
% Parámetros obtenidos con Alfaro
% ================================
Kp   = 0.7621;
tau  = 179.27;
tm   = 36.886;   % tiempo muerto

%% ===============================
% Crear modelo FOPDT
% G(s)= Kp*exp(-tm*s)/(tau*s+1)
% ================================
s = tf('s');
Gp = Kp*exp(-tm*s)/(tau*s + 1);

%% ===============================
% Simular respuesta al escalón real
% Escalón aplicado de 0 a 57 en t=4.5 s
% ================================
du = 57;        % cambio de entrada
y0 = 24,2913000977517;     % temperatura inicial

% Tiempo de simulación igual al experimental
tsim = t;

% Respuesta del modelo
ym = step(du*Gp, tsim);

% Sumar condición inicial
ym = ym + y0;

%% ===============================
% Ajustar tiempo muerto del escalón real
% (escalón inició en t=4.5 s)
% ================================
tstep = 4.5;

ym_final = zeros(size(t));

for i=1:length(t)
    if t(i) >= tstep
        tiempo_local = t(i)-tstep;
        ym_final(i) = interp1(tsim, ym, tiempo_local, 'linear', y0);
    else
        ym_final(i)=y0;
    end
end

%% ===============================
% Gráfica comparativa
% ================================
figure
plot(t,y,'b','LineWidth',2); hold on
plot(t,ym_final,'r--','LineWidth',2)

grid on
xlabel('Tiempo (s)')
ylabel('Temperatura (°C)')
title('Datos Reales vs Modelo FOPDT (Método de Alfaro)')
legend('Datos Reales','Modelo Alfaro','Location','best')

%% ===============================
% Error cuadrático medio
% ================================
ECM = mean((y - ym_final).^2);
disp(['Error cuadrático medio = ', num2str(ECM)])
