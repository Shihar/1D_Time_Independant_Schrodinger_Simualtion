function potential = potentialGenShooting(sel,x,debug)
%generating symmetrical potential functions for shooting method
global Wb Lw V_upper A_0 V_lower;
V = zeros(1,length(x)); %create and initially assign the matrix

if sel ==1
    disp('Running Simulation for Linear Well Using Shooting Method');
    f_linear = @(x)2*V_upper*x*A_0/Lw/A_0 +(2*V_upper);              %function to generate Linear Well
      for i = 1:length(x)
        if -Wb<=x(i)
            V(i) = f_linear(-x(i));
        else
              V(i) = f_linear(x(i));
        end     
    end
    for i = 1:length(x) 
        if x(i)>=-Wb && x(i)<=Wb
            V(i) = V_lower;
        end
    end
    
elseif sel==2
    disp('Running Simulation for Quadratic Well Using Shooting Method');
    f_quad   = @(x) V_upper/((Wb-Lw)*A_0)^2*(x*A_0 + Lw*A_0).^2; 
    for i = 1:length(x)
        if -Wb<=x(i)
            V(i) = f_quad(-x(i));
        else
              V(i) = f_quad(x(i));
        end     
    end
    for i = 1:length(x) 
        if x(i)>=-Wb && x(i)<=Wb
            V(i) = V_lower;
        end
    end
    
elseif sel==3
    disp('Running Simulation for Harmonic Oscillator Well Using Shooting Method');
    f_harmo  = @(x)V_upper/(Lw*A_0)^2*(x*A_0).^2;  %function to generate harmonic oscialltor
    V_harmon     = f_harmo(x); 
    V = V_harmon;
    
elseif sel==0
    disp('Running Simulation for finite Square Well Using Shooting Method');
     for i = 1:length(x)
        if -Wb<=x(i) && x(i)<=Wb
            V(i) = V_lower;
        else
            V(i) = V_upper;
        end
     end                      
end

%required to check the plot of the potential function to see if it was
%developed appropriately
if debug
plot(x*10^10,V);
end

potential = V ; 
end
