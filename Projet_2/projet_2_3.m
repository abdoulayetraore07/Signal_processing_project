clear all; close all

%Chargement, lecture et échantillonnage du signal audio
filename = 'encode.wav'; 
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


%Completion par des zéro
y=zeros(2*N,1);
for i=1:N
    y(2*i)=x(i);
end

% Transformée de Fourier du signal modifié et affichage ( cf indice )
TFy = fft(y) ;
f = linspace(0, (2*N-1)*fe/2*N, 2*N );
figure(3)
plot(f, abs(TFy));
title('Transformée de Fourier du signal avec des zeros intercalés');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_3','Format','png','color','cmyk');


%Séparation des deux signaux selon la parité après visualisation
x_new_1=zeros(N/2,1);
x_new_2=zeros(N/2,1);
for i=1:N/2
    x_new_1(i)=x(2*i);
    x_new_2(i)=x(2*i-1);
end

%Transformée de Fourier des signaux obtenus apres separation et affichage 
%Celle de x_new_1
TFx_1=fft(x_new_1);
f = linspace(0, ((N/2)-1)*fe/(N/2), N/2 );
figure(4)
plot(f,abs(TFx_1));
title("Transformée de Fourier du signal x_new_1");
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_4','Format','png','color','cmyk');

%Celle de x_new_2
TFx_2=fft(x_new_2);
f = linspace(0, ((N/2)-1)*fe/(N/2), N/2 );
figure(5)
plot(f,abs(TFx_2));
title("Transformée de Fourier du signal x_new_2");
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_5','Format','png','color','cmyk');

%Ecriture affichage et jouer le signal final 
x_new=[x_new_1,x_new_1];
TFx_new = fft(x_new) ;
f = linspace(0, (N-1)*fe/N, length( TFx_new));
figure(6)
plot(f, abs(TFx_new));
title('Transformée de Fourier du signal final');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis tight;
exportfig(gcf,'figure_6','Format','png','color','cmyk');

audiowrite('encode_new.wav',x_new,fe);
sound(x_new,fe);

