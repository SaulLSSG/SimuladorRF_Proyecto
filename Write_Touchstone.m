function touchstone = Write_Touchstone(Matriz_S, Frecuencias, Nombre, Formato,unidad_frecuencia,Z0,parametro)
sz = size(Matriz_S);
Formato = lower(Formato);
archivo = append(Nombre,'.',parametro,num2str(sz(1,1)),'p')
fileID = fopen(archivo,'wt+');
unidad_frecuencia = lower(unidad_frecuencia);


switch unidad_frecuencia
    case 'hz'
        Formato_frec = 'Hz';
        divisor = 1;
    case 'khz'
        Formato_frec = 'KHz';
        divisor = 1e3;
    case 'mhz'
        Formato_frec = 'MHz';
        divisor = 1e6;
    case 'ghz'
        Formato_frec = 'GHz';
        divisor = 1e9;
end

parametro = upper(parametro)

switch Formato

    case 'ri'
        Formato_2 = upper(Formato);
        fprintf(fileID,'%s %1s %1s %1s %1s %1s\n','#',Formato_frec,parametro,Formato_2,'R',num2str(Z0));
        fprintf(fileID,'\n');
        a = real(Matriz_S);
        b = imag(Matriz_S);

    case 'ma'
        Formato_2 = upper(Formato);
        fprintf(fileID,'%s %1s %1s %1s %1s %1s\n','#',Formato_frec,parametro,Formato_2,'R',num2str(Z0));
        fprintf(fileID,'\n');
        a = abs(Matriz_S);
        b = rad2deg(angle(Matriz_S));

    case 'db'
        Formato_2 = upper(Formato);
        fprintf(fileID,'%s %1s %1s %1s %1s %1s\n','#',Formato_frec,parametro,Formato_2,'R',num2str(Z0));
        fprintf(fileID,'\n');
        a = mag2db(abs(Matriz_S));        
        b = rad2deg(angle(Matriz_S));

end

    for i = 1 : sz(1,3)             %Itera en la cantidad de frencuencias
        fprintf(fileID,'%1.15e ',(Frecuencias(i,1)/(divisor)));
        for j = 1 : sz(1,1)         %Itera en los renglones de la matriz
            for k = 1 : sz(1,2)     %Itera en las columnas de la matriz

                if ((k == sz(1,2)) && (j ~= sz(1,1)))  %k == sz(1,2)               
                    fprintf(fileID,' % 1.16e % 1.16e ', a(j,k,i), b(j,k,i));
                elseif ((k == sz(1,2)) && (j == sz(1,1)))
                    fprintf(fileID,' % 1.16e % 1.16e', a(j,k,i), b(j,k,i));
                else
                    fprintf(fileID,'% 1.16e % 1.16e', a(j,k,i), b(j,k,i));
                end

            end
        end
        fprintf(fileID,'\n');
    end

fclose(fileID);

touchstone = fileID;



end



