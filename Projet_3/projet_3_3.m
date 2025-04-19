clear all; close all

%Chargement, lecture et échantillonnage du signal audio
filename = 'Mo11.wav'; 
[x, fe]=audioread(filename);
T = 1/fe ;
N=length(x);

% Affichage du signal original
t = (0:N-1)*T;
figure(1)
plot(t, x);
title('Signal original');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_1','Format','png','color','cmyk');

%Pour un signal contenant deux fréquences sinusoïdales, un filtre autoregressif d'ordre 4  est nécessaire pour les prédire et les annuler

coeffs = lpc(x, 4);               %%% FONCTION TROUVER EN LIGNE  PUIS SUR MATLAB AVEC HELP 

% Filtrer le signal
x_new = filter(coeffs, 1, x);

% Transformée de Fourier du signal filtré et affichage 
TFx_new = ifftshift(fft(x_new)) ;
f = linspace(0, (N-1)*fe/N, N );
figure(2)
plot(f, abs(TFx_new));
title('Transformée de Fourier du signal filtré');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_2','Format','png','color','cmyk');

%Ecriture et lecture du signal final 
audiowrite('Mo11_new.wav',x_new,fe);
sound(x_new, fe);