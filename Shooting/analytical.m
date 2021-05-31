% E = habr^2*pi^2/2/m n^2;

global m_e h_bar e ;
m_e = 9.11e-31;
e = 1.602e-19;
h_bar = 1.055e-34;
Lw = 8e-10
C =-h_bar^2/2/m_e;


for i = 1:3
    En(i) = -C*3.14^2*i^2/Lw^2/e;
end

x = linspace(0,Lw,N);   %in nm 

A = sqrt(2/Lw);
for i = 1:length(x)
    psi(i) = A * sin(1*3.14*x(i)/Lw);
end
plot(x,psi)