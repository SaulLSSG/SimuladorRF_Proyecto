function [Frecuencias, Matriz_R, Z0, Parametro] = ReadTouchstones(File)


fileID = fopen(File,'r');

Datos_S_parameters = textscan(fileID,'%f %f %f %f %f %f %f %f %f','CommentStyle','!','HeaderLines',2);

frewind(fileID);
while true
   Datos_Formato = fgets(fileID);
   Datos_Formato = split(Datos_Formato,' ');
    if strcmpi(Datos_Formato(1,1),'#')
        break
    end
end

Formato_datos = cell2mat(Datos_Formato(4,1));
Formato_datos = lower(Formato_datos);
Parametro = cell2mat(Datos_Formato(3,1))
Unidad_Frecuencia = cell2mat(Datos_Formato(2,1));
Unidad_Frecuencia = lower(Unidad_Frecuencia);
%Puertos = 2;
Z0 = cell2mat(Datos_Formato(6,1));
Z0 = str2double(Z0);

switch Unidad_Frecuencia

    case 'hz'
        multiplicador = 1;
    case 'khz'
        multiplicador = 1e3;
    case 'mhz'
        multiplicador = 1e6;       
    case'ghz'
        multiplicador = 1e9;

end

Frecuencias = (Datos_S_parameters{1,1})*multiplicador;

D_1 = Datos_S_parameters{1,2};
D_2 = Datos_S_parameters{1,3};
D_3 = Datos_S_parameters{1,4};
D_4 = Datos_S_parameters{1,5};
D_5 = Datos_S_parameters{1,6};
D_6 = Datos_S_parameters{1,7};
D_7 = Datos_S_parameters{1,8};
D_8 = Datos_S_parameters{1,9};
sz_2 = size(D_1);
Matriz_R = zeros(2,2,sz_2(1,1));

switch Formato_datos

    case 'ma'        
        for i = 1 : sz_2(1,1)
            Matriz_R(1,1,i) = D_1(i,1)*cos(deg2rad(D_2(i,1))) + D_1(i,1)*sin(deg2rad(D_2(i,1)))*1i;
            Matriz_R(1,2,i) = D_3(i,1)*cos(deg2rad(D_4(i,1))) + D_3(i,1)*sin(deg2rad(D_4(i,1)))*1i;
            Matriz_R(2,1,i) = D_5(i,1)*cos(deg2rad(D_6(i,1))) + D_5(i,1)*sin(deg2rad(D_6(i,1)))*1i;
            Matriz_R(2,2,i) = D_7(i,1)*cos(deg2rad(D_8(i,1))) + D_7(i,1)*sin(deg2rad(D_8(i,1)))*1i;
        end

    case 'ri'     
         for i = 1 : sz_2(1,1)
            Matriz_R(1,1,i) = D_1(i,1) + D_2(i,1)*1i;
            Matriz_R(1,2,i) = D_3(i,1) + D_4(i,1)*1i;
            Matriz_R(2,1,i) = D_5(i,1) + D_6(i,1)*1i;
            Matriz_R(2,2,i) = D_7(i,1) + D_8(i,1)*1i;
         end

    case 'db'
        for i = 1 : sz_2(1,1)
            Matriz_R(1,1,i) = db2mag(D_1(i,1))*cos(deg2rad(D_2(i,1))) + db2mag(D_1(i,1))*sin(deg2rad(D_2(i,1)))*1i;
            Matriz_R(1,2,i) = db2mag(D_3(i,1))*cos(deg2rad(D_4(i,1))) + db2mag(D_3(i,1))*sin(deg2rad(D_4(i,1)))*1i;
            Matriz_R(2,1,i) = db2mag(D_5(i,1))*cos(deg2rad(D_6(i,1))) + db2mag(D_5(i,1))*sin(deg2rad(D_6(i,1)))*1i;
            Matriz_R(2,2,i) = db2mag(D_7(i,1))*cos(deg2rad(D_8(i,1))) + db2mag(D_7(i,1))*sin(deg2rad(D_8(i,1)))*1i;
        end


end




end
