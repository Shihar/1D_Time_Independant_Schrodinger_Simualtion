function [V_hat,V] = potential_Generator(sel,x,debug)

global Lw Wb e A_0 V_upper V_lower;
V = zeros(1,length(x)); %create and initially assign the matrix

%selection of potential functions to perform simulations
if  sel==1
    
    f_linear = @(x)2*V_upper*e*x*A_0/Lw/A_0 +(2*V_upper*e);
    for i = 1:length(x)
        if -Wb<=x(i)
            V(i) = f_linear(-x(i));
        else
              V(i) = f_linear(x(i));
        end      
    end
    for i = 1:length(x) 
        if x(i)>=-Wb && x(i)<=Wb
            V(i) = V_lower*e;
        end
    end
    disp('Running Sim for Linear Potential Well');
    
elseif sel == 2    
    
    f_quad   = @(x) 2*V_upper*e/((Wb-Lw)*A_0)^2*(x*A_0 + Lw*A_0).^2;
     for i = 1:length(x)
        if -Wb<=x(i)
            V(i) = f_quad(-x(i));
        else
              V(i) = f_quad(x(i));
        end      
    end
    for i = 1:length(x) 
        if x(i)>=-Wb && x(i)<=Wb
            V(i) = V_lower*e;
        end
    end
    
    disp('Running Sim for Quadratic Potential Well');
    
elseif sel ==3 
    
    f_harmo  = @(x)V_upper/(Lw*A_0)^2*(x*A_0).^2;                %function to generate harmonic oscialltor
    V_harmon= f_harmo(x)*e; %Harmonic oscillator
    V = V_harmon;
    disp('Running Sim for Harmonic Oscillator Potential Well');
    
elseif sel==4 
    
    for i = 1:length(x)
        if -Wb<=x(i) && x(i)<=Wb
            V(i) = V_lower*e;
        else
            V(i) = V_upper*e;
        end
    end  
    disp('Running Sim for Square Potential Well');
    
elseif sel==5
    
    disp('Running Sim for Stepped Potential Well');
    V =V_upper*e*ones(1,length(x));
    V(-Wb <= x &x<=Wb ) = 0;
    V( x >= 0 & x<= Wb ) = V_upper*e/2;
    
elseif sel==6
    
    disp('Running Sim for Double Well Potential');
     V = zeros(1,length(x));
     V(-Wb/2 <= x & x <= Wb/2 ) = 4*V_upper*e;
     for i = 1:length(x)
         if x(i)<=-Wb|| x(i)>=Wb
             V(i) = 2*V_upper*e;
         end
     end
     
elseif sel==7
    disp('Running Sim for Triangle Well Potential');
    for i = 1:length(x)
        if x(i) <=-Wb || x(i)>=Wb
            V(i) = V_upper*e;
        elseif  -Wb<=x(i)  && x(i)<=0
            V(i) =-e*x(i)*A_0*10/4;
        else
            V(i) =e*x(i)*A_0*10/4;
        end
    end
    
 elseif sel==9
    disp('Running Sim for Asymmetrical Double Well Potential');
     V = zeros(1,length(x));
     V(-Wb/2 <= x & x <= Wb/2 ) = 4*V_upper*e;
     for i = 1:length(x)
         if x(i)<=-Wb
             V(i) = 2*V_upper*e;
         elseif x(i) >=Wb+(1/A_0)
             V(i) = V_upper*e*3;
         end
     end
     V = zeros(1,length(x));
     V(-Wb/2 <= x & x <= Wb/2 ) = 4*V_upper*e;
     for i = 1:length(x)
         if x(i)<=-Wb
             V(i) = 2*V_upper*e;
         elseif x(i) >=Wb+(1/A_0)
             V(i) = V_upper*e*3;
         end
     end
     
elseif sel==8
    disp('Running Sim for Series Well Potential');
     V = zeros(1,length(x));
     z = [1,2,3,4];
     
     for i = 1:length(x)
         if x(i)*A_0 >=-2 && x(i)*A_0 <=-1
             V(i) = V_upper*e;
         elseif x(i)*A_0 >=-5 && x(i)*A_0 <=-4
             V(i) = V_upper*e;
           elseif x(i)*A_0 >=-8 && x(i)*A_0 <=-7
             V(i) = V_upper*e; 
           elseif x(i)*A_0 >=1 && x(i)*A_0 <=2
             V(i) = V_upper*e;   
             elseif x(i)*A_0 >=4 && x(i)*A_0 <=5
             V(i) = V_upper*e;
             elseif x(i)*A_0 >=7 && x(i)*A_0 <=8
             V(i) = V_upper*e;
         end
         
     end
     
elseif sel==10
    disp("Running for Free Particle");
    V = zeros(1,length(x));
     
end

%for debug to check if potential well is correct
if debug
    plot(x*10^10,V/e);
end

V_hat = zeros(length(x),length(x));

%fill the matrix correct indices with the potential values 
for r = 1:length(x)
   V_hat(r,r) = V(r);
end
end






