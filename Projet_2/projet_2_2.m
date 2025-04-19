clear all; close all

%Chargement, lecture et échantillonnage du signal audio
filename = 'canal.wav'; 
[x, fe] = audioread(filename);
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

% Transformée de Fourier du signal original et affichage 
TFx = fft(x) ;
f = linspace(0, (N-1)*fe/N, N );
figure(2)
plot(f, abs(TFx));
title('Transformée de Fourier du signal original');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_2','Format','png','color','cmyk');

%Permutation inverse du signal en separant en deux avant et apres fe/2
TFx_gauche=TFx(2:N/2);
TFx_droite=TFx(N/2+2:N);

TFx_new=[TFx(1);flip(TFx_gauche);TFx(N/2+1);flip(TFx_droite)] ;
% flip est une fonction Matlab permettant d'inverser les valeurs du signal ( comme si on lisait de droite a gauche ) 

% Affichage de la transformée de Fourier du signal permuté 
figure(3)
plot(f, abs(TFx_new));
title('Transformée de Fourier du signal permuté');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_3','Format','png','color','cmyk');

%Obtention du signal permuté
x_new=ifft(TFx_new) ;

%Affichage du signal permuté
figure(4)
plot(t, x_new);
title('Signal permuté');
xlabel('Temps (s)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_4','Format','png','color','cmyk');

%Ecriture et jouer le signal final 
audiowrite('canal_new.wav',x_new,fe);
sound(x_new, fe);
