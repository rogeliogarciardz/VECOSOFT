function f_draw_kml(dir_data,kml,varargin)
    % F_DRAW_KML draw a kml file over a map. 
    %
    %
    % F_DRAW_KML("C:\dirdata","kmlfile") draw a kml with a thin black line 
    %
    % F_DRAW_KML("C:\dirdata","kmlfile",n) draw a kml whit a npx black line 
    %
    % F_DRAW_KML("C:\dirdata","kmlfile",n,color)  draw a kml whit a npx color line 
    %
    % F_DRAW_KML("C:\dirdata","kmlfile",n,color,"Label") draw a kml whit a
    % npx color line and over a label 
    %
    %  Written by:  (2024) Rogelio García Rodríguez 
    if(nargin<2)
        error('Faltan parametros a la función');
    elseif(nargin==2)
        plinewi=1;
        pcolor='k';
    elseif(nargin==3 && isnumeric(varargin{1}))
        plinewi = varargin{1};
        pcolor='k';
    elseif(nargin==4 && isnumeric(varargin{1}))
        plinewi = varargin{1};
        pcolor=varargin{2};
    elseif(nargin==5 && isnumeric(varargin{1}) && isstring(varargin{3}))
        plinewi = varargin{1};
        pcolor=varargin{2};
    else
        error('Parametros incorrectos');
    end

    [bndry_lon,bndry_lat,~] = read_kml(dir_data+'KML\'+kml+'.kml');
    m_line(bndry_lon,bndry_lat,'linewi',plinewi,'color',pcolor); 
    %disp("PL "+plinewi)
    %disp("PC "+pcolor)

    if nargin==5
        m_text( mean(bndry_lon,'all'), mean(bndry_lat,'all'),sprintf('%s',varargin{3}));
        %disp(varargin(3))
    end
end