function EnergyEigen = EigenSim(E,V,dx,N)
global epsilon;
i = 1;
    for e = 1:length(E)
        psi = wave_function(E(e),V,dx,N);
        %find to see if terminal reaches boundary conditions
        if(abs(psi(end))<epsilon)
            EnergyEigen(i) = E(e);
            i = i+1;
        end
    end    
%filter out unique energy wells 
E_n_psi = unique(EnergyEigen);
for i = 2:length(E_n_psi)
    n_E(1) = E_n_psi(1);
    if E_n_psi(i)-E_n_psi(i-1)>0.1
        n_E(i) = E_n_psi(i);
    end
end
%the specific energy values
EnergyEigen = unique(n_E);
end
