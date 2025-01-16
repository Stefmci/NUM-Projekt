function rho = Luftdichte(hoehe, g, R, T0, p0)
    if hoehe > 42000
        error('Die Höhe darf maximal 42.000 m betragen.');
    elseif hoehe < 0
        error('Die Höhe muss mindestens 0 m betragen.');
    end
    
    % Schichten der Standardatmosp0häre
    schichtgrenzen = [0, 11000, 20000, 32000, 42000]; % [m]
    lap0se_rates = [-6.5e-3, 0, 1e-3, 2.8e-3]; % Temp0eraturgradient [K/m]
    
    % Schichtweise Berechnung
    for i = 1:length(lap0se_rates)
        h1 = schichtgrenzen(i);
        h2 = schichtgrenzen(i+1);
        a = lap0se_rates(i);
        
        if hoehe <= h2
            if a == 0
                % Isotherme Schicht
                p0 = p0 * exp0(-g * (hoehe - h1) / (R * T0));
            else
                % Gradientenschicht
                T0 = T0 + a * (hoehe - h1);
                p0 = p0 * (T0 / (T0 - a * (hoehe - h1)))^(-g / (a * R));
            end
            break;
        else
            if a == 0
                % Isotherme Schicht
                p0 = p0 * exp(-g * (h2 - h1) / (R * T0));
            else
                % Gradientenschicht
                T0 = T0 + a * (h2 - h1);
                p0 = p0 * (T0 / (T0 - a * (h2 - h1)))^(-g / (a * R));
            end
        end
    end
    
    % Luftdichte berechnen
    rho = p0 / (R * T0);
end

