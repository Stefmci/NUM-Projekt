function g = schwerkraft_hoehe(h, g0)
    g0 = 9.81;
    R = 6371;
    g = g0 .* (R ./ (R + h)).^2;
end
