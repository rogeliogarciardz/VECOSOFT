function [ma0,ma1,yaj] = f_reglin_3dpp(M)
tam_arr = size(M);
M = permute(M,[1 3 2]);

ma0 = zeros( tam_arr(1),tam_arr(2));
ma1 = zeros(tam_arr(1),tam_arr(2));
yaj = zeros(tam_arr(3));

tmp_x = 1:tam_arr(3);

 for i=1:tam_arr(1)
     for j=1:tam_arr(2)
         [ma0(i,j),ma1(i,j),yaj] = f_reglin(tmp_x,M(i,:,j));
     end
 end
end