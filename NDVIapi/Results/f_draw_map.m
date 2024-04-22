function f_draw_map(lon_map,lat_map,lon,lat,data,varargin) 
%ppcolor,pclim,ptitle,plabel)
    % f_draw_map draw a map using m_map lib, using by default NDVI_COLORMAP
    %
    % Ej: f_draw_map(lon_mapa,lat_mapa,lon,lat,ma1,m_colmap('jet',256),[-1 1],"NDVI","Titulo");
    %  Written by:  (2024) Rogelio García Rodríguez 

    % NDVI colormap - 256 colors - values 0 to 1 like NASA
    ndvi_map_r = [ (33:80)  80*ones(1,79)  (80:-1:0)  zeros(1,48) ]' /80;  % red
    ndvi_map_g = flipud( ndvi_map_r );                                     % green
    ndvi_map_b = zeros( size( ndvi_map_r ) );                              % blue
    ndvi_colormap = [ ndvi_map_r  ndvi_map_g  ndvi_map_b ];
    load elevation_colormap.mat;
    ptitle="";
    pclim=0;
    plabel="";
    if(nargin<5)
        error('Faltan parametros a la función');
    elseif(nargin==5)
        colormap(ndvi_colormap); 
    elseif(nargin>=6 && ~isnumeric(varargin{1}))
        if(varargin{1}=="NDVI")
            colormap(ndvi_colormap);
        elseif(varargin{1}=="Elevation")
            colormap(elevation_colormap);
        end
    elseif(nargin>=6 && isnumeric(varargin{1}))
        colormap(varargin{1}); 
    end
   
    if(nargin==7 && isnumeric(varargin{2}) && length(varargin{2})==2)
        pclim = varargin{2};
    elseif(nargin==8 &&  isnumeric(varargin{2}) && length(varargin{2})==2  && isstring(varargin{3}))
        pclim = varargin{2};
        plabel=varargin{3};
   elseif(nargin==9 &&  isnumeric(varargin{2}) && length(varargin{2})==2  && isstring(varargin{3})&& isstring(varargin{4}))
        pclim = varargin{2};
        plabel=varargin{3};
        ptitle=varargin{4};
    end

    %%dibujar mapa ndvi proyeccion mercator 
    m_proj('mercator','lon',lon_map,'lat',lat_map);
      
    %%dibujar el mapa
    m_pcolor(lon,lat,data); shading interp ;
    %dibuja el recuadro del mapa
    %m_grid('box','fancy','grid','none','fontsize',10);
    m_grid('linestyle','none','box','fancy','tickdir','out','fontsize',10);
    %m_grid('linewi',2,'tickdir','out');
    % Regla de escala
    m_ruler([.05 .36],.1,3,'fontsize',5)

    if plabel ~= ""    
        colorbar('eastoutside');
         c = colorbar;
        c.Label.String = plabel;
    end
    if( length(pclim)==2)
        clim(pclim);
    end  
   
    if( ~isempty(ptitle))
        title(ptitle);
    end
end


% % 
% %     
% %     if(~isnumeric( ppcolor))
% %         if (ppcolor=="NDVI")
% %             colormap(ndvi_colormap);
% %         end
% %     else
% %         colormap(ppcolor);
% %     end
% % 
% %     %%dibujar mapa ndvi proyeccion mercator 
% %     m_proj('mercator','lon',lon_map,'lat',lat_map);
% %       
% %     %%dibujar el mapa
% %     m_pcolor(lon,lat,data); shading interp ;
% %   
% %     if plabel ~= ""    
% % %         colorbar('eastoutside');
% % %          c = colorbar;
% % %         c.Label.String = "plabel";
% %     end
% % 
% %     if length (pclim) == 2
% %        clim(pclim);
% %     end 
% %     
% %     %dibuja el recuadro del mapa
% %     %m_grid('box','fancy','grid','none','fontsize',10);
% %     m_grid('linestyle','none','box','fancy','tickdir','out');
% %     %m_grid('linewi',2,'tickdir','out');
% % 
% %     % Regla de escala
% %     m_ruler([.05 .36],.1,3,'fontsize',7)
% %     
% %     % colocar estrella en posición correcta
% %     
% %     %m_northarrow(-101,23.5,.4,'type',2);
% %     % Estrella del norte 
% %     %m_northarrow(-97.9,23.5,.4,'type',2);
% % 
    
% % end