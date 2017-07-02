function j_p = judge_point(x,y,xi,yi,xa,ya)
%un point est sous ou su un ligne
yj=(x-xi)*(ya-yi)/(xa-xi)+yi;
if y>=yj
	j_p=1;
else 
	j_p=0;
end


end
