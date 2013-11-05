%Letter
A=imread('train/caracteres/A.jpg');B=imread('train/caracteres/B.jpg');
C=imread('train/caracteres/C.jpg');D=imread('train/caracteres/D.jpg');
E=imread('train/caracteres/E.jpg');F=imread('train/caracteres/F.jpg');
G=imread('train/caracteres/G.jpg');H=imread('train/caracteres/H.jpg');
I=imread('train/caracteres/I.jpg');J=imread('train/caracteres/J.jpg');
K=imread('train/caracteres/K.jpg');L=imread('train/caracteres/L.jpg');
M=imread('train/caracteres/M.jpg');N=imread('train/caracteres/N.jpg');
O=imread('train/caracteres/O.jpg');P=imread('train/caracteres/P.jpg');
Q=imread('train/caracteres/Q.jpg');R=imread('train/caracteres/R.jpg');
S=imread('train/caracteres/S.jpg');T=imread('train/caracteres/T.jpg');
U=imread('train/caracteres/U.jpg');V=imread('train/caracteres/V.jpg');
W=imread('train/caracteres/W.jpg');X=imread('train/caracteres/X.jpg');
Y=imread('train/caracteres/Y.jpg');Z=imread('train/caracteres/Z.jpg');

%Number
one=imread('train/caracteres/1.jpg');  two=imread('train/caracteres/2.jpg');
three=imread('train/caracteres/3.jpg');four=imread('train/caracteres/4.jpg');
five=imread('train/caracteres/5.jpg'); six=imread('train/caracteres/6.jpg');
seven=imread('train/caracteres/7.jpg');eight=imread('train/caracteres/8.jpg');
nine=imread('train/caracteres/9.jpg'); zero=imread('train/caracteres/0.jpg');

letter=[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z];
number=[one two three four five six seven eight nine zero];
character=[im2bw(rgb2gray(letter),0.5) im2bw(rgb2gray(number),0.5)];
templates=mat2cell(character,100,[42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42]);
save ('templates','templates')
% clear all