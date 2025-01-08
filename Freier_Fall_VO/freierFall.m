function uPunkt=freierFall(t,u)
 rho=1.3;    % Dichte der Luft in kg/m³
 cw=0.4;     % cw-Wert einer Kugel
 A=0.25;     % Querschnittsfläche der Kugel
 m=25;       % Masse der Kugel
 g=9.81;     % Schwerbeschleunigung an der Erdoberfläche
 uPunkt = [ u(2) -g + rho*cw*A*0.5/m*u(2).^2];