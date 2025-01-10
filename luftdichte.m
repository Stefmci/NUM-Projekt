function rho = luftdichte(hoehe)
    % Funktion zur Berechnung der Luftdichte in Abhängigkeit von der Höhe
    % nach dem Standardatmosphärenmodell (ISA).
    % 
    % Eingabe:
    % hoehe - Höhe über dem Meeresspiegel [m], 0 <= hoehe <= 42000
    % 
    % Ausgabe:
    % rho - Luftdichte [kg/m^3]
    
    % Maximale Höhe begrenzen
    if hoehe > 42000
        error('Die Höhe darf maximal 42.000 m betragen.');
    elseif hoehe < 0
        error('Die Höhe muss mindestens 0 m betragen.');
    end
    
    % ISA-Parameter
    R = 287.05; % spezifische Gaskonstante [J/(kg*K)]
    g = 9.80665; % Erdbeschleunigung [m/s^2]
    T0 = 288.15; % Bodentemperatur [K]
    p0 = 101325; % Bodendruck [Pa]
    rho0 = 1.225; % Luftdichte auf Meereshöhe [kg/m^3]
    
    % Schichten der Standardatmosphäre
    schichtgrenzen = [0, 11000, 20000, 32000, 42000]; % [m]
    lapse_rates = [-6.5e-3, 0, 1e-3, 2.8e-3]; % Temperaturgradient [K/m]
    
    T = T0;
    p = p0;
    
    % Schichtweise Berechnung
    for i = 1:length(lapse_rates)
        h1 = schichtgrenzen(i);
        h2 = schichtgrenzen(i+1);
        a = lapse_rates(i);
        
        if hoehe <= h2
            if a == 0
                % Isotherme Schicht
                p = p * exp(-g * (hoehe - h1) / (R * T));
            else
                % Gradientenschicht
                T = T + a * (hoehe - h1);
                p = p * (T / (T - a * (hoehe - h1)))^(-g / (a * R));
            end
            break;
        else
            if a == 0
                % Isotherme Schicht
                p = p * exp(-g * (h2 - h1) / (R * T));
            else
                % Gradientenschicht
                T = T + a * (h2 - h1);
                p = p * (T / (T - a * (h2 - h1)))^(-g / (a * R));
            end
        end
    end
    
    % Luftdichte berechnen
    rho = p / (R * T);
end

