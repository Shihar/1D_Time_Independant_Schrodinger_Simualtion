function psi = wave_function(E,V,dx,N)
    global m_e h_bar e ;
    C = (2*m_e*e/h_bar^2);
    psi = zeros(1,N);
    psi(2) = 1;
    for n = 2:N-1
       psi(n+1) = (2 - C*(E-V(n))*dx^2)*psi(n) - psi(n-1);
    end
    Area = trapz(psi.*psi);
    psi = psi /sqrt(Area);
    
end
