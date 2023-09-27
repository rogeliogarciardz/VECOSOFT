function f_draw_map(lon_map,lat_map,lon,lat,data,ptitle,pclim,ppcolor,plabel)

    % NDVI colormap - 256 colors - values 0 to 1 like NASA
    ndvi_map_r = [ (33:80)  80*ones(1,79)  (80:-1:0)  zeros(1,48) ]' /80;  % red
    ndvi_map_g = flipud( ndvi_map_r );                                     % green
    ndvi_map_b = zeros( size( ndvi_map_r ) );                              % blue
    ndvi_colormap = [ ndvi_map_r  ndvi_map_g  ndvi_map_b ];
 
    if(~isnumeric( ppcolor))
        colormap(ndvi_colormap);
    else
        colormap(ppcolor);
    end

    %%dibujar mapa ndvi proyeccion mercator 
    m_proj('mercator','lon',lon_map,'lat',lat_map);
      
    %%dibujar el mapa
    m_pcolor(lon,lat,data); shading interp ;
  
    if plabel ~= ""    
        colorbar('eastoutside');
        c = colorbar;
        c.Label.String = plabel;
    end

    if length (pclim) == 2
       clim(pclim);
    end 
    
    %dibuja el recuadro del mapa
    %m_grid('box','fancy','grid','none','fontsize',10);
    m_grid('linestyle','none','box','fancy','tickdir','out');
    %m_grid('linewi',2,'tickdir','out');

    % Regla de escala
    m_ruler([.05 .36],.1,3,'fontsize',7)
    
    %m_northarrow(-101,23.5,.4,'type',2);
    % Estrella del norte 
    %m_northarrow(-97.9,23.5,.4,'type',2);

    if(~isempty (ptitle))
        title(ptitle);
    end
end