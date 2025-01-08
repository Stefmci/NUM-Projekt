function g = schwerkraft_hoehe(h)
    g0 = 9.81; % Schwerkraft auf der Erdoberfläche in m/s^2
    R = 6371;  % Erdradius in Kilometern
    
    % Schwerkraftberechnung
    g = g0 .* (R ./ (R + h)).^2;
end
