% f_mean_3dpp Calcula el promedio por pixel de una matriz en 3 dimensiones 
% [m2d] = f_mean_3dpp(m3d)
%
%   INPUTS:
%      m3d  - Matriz de 3 dimensiones 
%
%   OUTPUTS:
%      m2d    - Matriz de 2 dimensiones con el promedio 
%  
%   Calcula el promedio por pixel de una matriz en 3 dimensiones 
%  
%   Example:
%      m3d = [];    
%      m2d = f_mean_3dpp(m3d);
%  
%   See also MEAN

function m2d = f_mean_3dpp(m3d)
    s = size(m3d);

    m2d = permute(m3d,[1 3 2]);
    m2d = mean(m2d,2,'omitnan');
    m2d = reshape(m2d,[s(1),s(2)]);
      
end