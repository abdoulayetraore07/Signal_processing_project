clear all; close all

v=340;
d=0.25;
[x1,Fe]=audioread('Erlk.wav') ;
y1=fft(x1);
figure(1)
plot(abs(y1));
title("Spectre de x1");
axis tight;
exportfig(gcf,'x1','Format','png','color','cmyk');
L=length(x1);
x2=zeros(L,1);

%Construction de x2
for n=1:L
    theta=pi*(1/2-n/L);
    tau=d*sin(theta)/v;
    if(n-floor(tau*Fe)<=L && n-floor(tau*Fe)>0)
    x2(n)=x1(n-floor(tau*Fe));
    end
end

 y=[x1 x2]; 
 Stereo=fft(y);
 figure(2)
 plot(abs(Stereo));
 title("Spectre stéreo")
 axis tight;
 exportfig(gcf,'Specstr','Format','png','color','cmyk');
 audiowrite('resultat.wav',y,Fe) ;
 sound(y,Fe);




