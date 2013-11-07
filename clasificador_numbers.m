function letter=clasificador_numbers(imagn,num_numbers)
% Computes the correlation between template and input image
% and its output is a string containing the letter.
% Size of 'imagn' must be 42 x 24 pixels
% Example:
% imagn=imread('D.bmp');
% letter=read_letter(imagn)
global templates
comp=[ ];
for n=27:num_numbers
    sem=corr2(templates{1,n},imagn);
    comp=[comp sem];
end
vd=find(comp==max(comp));
%*-*-*-*-*-*-*-*-*-*-*-*-*-
if vd==1
    letter='1';
elseif vd==2
    letter='2';
elseif vd==3
    letter='3';
elseif vd==4
    letter='4';
elseif vd==5
    letter='5';
elseif vd==6
    letter='6';
elseif vd==7
    letter='7';
elseif vd==8
    letter='8';
elseif vd==9
    letter='9';
else
    letter='0';
end

