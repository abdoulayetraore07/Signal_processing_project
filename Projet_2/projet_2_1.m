clear all; close all

clear B;
B=imread('fichier2.bmp','bmp');
B=255*B;
image(B);
colormap(gray);
[row_B,col_B ]=size(B);

for k=1:row_B-1
        ligne_1=B(k,:);
        ligne_2=B(k+1,:);
        correlation = xcorr( ligne_1, ligne_2 );
        [~, indice] = max (correlation) ;
        NO=circshift(ligne_2,indice);
        B(k+1,:)=NO;        
end
figure(1)
image(B)
colormap(gray)
exportfig(gcf,'image_1_auto','Format','png','color','cmyk');     

%L'image obtenue est un peu décalée par la droite ; on fait alors un nouveau
%decalage vers la gauche de façon à retrouver une image meilleure
for k=1:row_B-1
    B(k,:)=circshift(B(k,:),-275);
end
figure(2)
image(B)
colormap(gray)
exportfig(gcf,'image_2_manuel','Format','png','color','cmyk');
   