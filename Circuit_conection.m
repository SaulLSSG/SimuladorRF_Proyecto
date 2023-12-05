function [Circuito_Final, Parametro] = Circuit_conection(Netlist_1, Piedra_manoseada, Netlist_2)

%Touchstone = sparameters(Piedra_manoseada);
%Frecuencias = Touchstone.Frequencies;
%Z0 = Touchstone.Impedance;
%Matriz_S_TS = Touchstone.Parameters;

[Frecuencias,Matriz_S_TS,Z0,Parametro] = ReadTouchstones(Piedra_manoseada)
sz = size(Frecuencias);
Muestreo = sz(1,1);
Frec_inicial = Frecuencias(1,1);
Frec_final = Frecuencias(sz(1,1),1);

if isreal(Netlist_1)
    Input_Matriz = 1;
else
    Input_Matriz = ABCD_Parameters(Netlist_1,Frec_inicial,Frec_final,Muestreo,2);
end

if isreal(Netlist_2)
    Output_Matriz = 1;
else
    Output_Matriz = ABCD_Parameters(Netlist_2,Frec_inicial,Frec_final,Muestreo,2);
end

%El la matriz de parametros s del touchstone lo convierto a parametros Z
Parametro = lower(Parametro)

switch Parametro
    case 's'
        Matriz_ABCD_TS = s2abcd(Matriz_S_TS,Z0);
    case 'z'
        Matriz_ABCD_TS = z2abcd(Matriz_S_TS);        
    case 'y'
        Matriz_ABCD_TS = y2abcd(Matriz_S_TS)
end

%Matriz_ABCD_TS = s2abcd(Matriz_S_TS,Z0);

In_Ts = pagemtimes(Input_Matriz,Matriz_ABCD_TS);
IN_TS_OUT = pagemtimes(In_Ts,Output_Matriz);

Circuito_Final = abcd2s(IN_TS_OUT,Z0);

end