function rho = luftdichte_in_hoehe(hoehe)
    R = 287.05;          % Spezifische Gaskonstante für trockene Luft [J/(kg·K)]
    g0 = 9.80665;         % Erdbeschleunigung [m/s^2]
    T0 = 288.15;          % Standardtemperatur auf Meereshöhe [K]
    p0 = 101325;          % Standarddruck auf Meereshöhe [Pa]
    L = 0.0065;           % Temperaturgradient in der Troposphäre [K/m]

    % Höhengrenze für die Berechnung (Troposphäre, bis 11 km)
    hoehe_max = 40000;    % Maximale Höhe [m]

    if any(hoehe > hoehe_max) || any(hoehe < 0)
        error('Die Höhe muss zwischen 0 und %d Metern liegen.', hoehe_max);
    end

    % Temperatur in Abhängigkeit von der Höhe
    T = T0 - L * hoehe;

    % Druck in Abhängigkeit von der Höhe (Barometrische Höhenformel)
    p = p0 * (T / T0).^(g0 / (R * L));

    % Luftdichte in Abhängigkeit von der Höhe
    rho = p ./ (R * T);
end