function PlotGraphs(Energy,V,dx,N,x)
i =1;
%funtion to plot wave function and probablity of finding it

%limits to plot function
xmin = 8;
xmax = xmin;
ymin_p = 0;
ymax_p = 3e-3;
%call from the 2nd energy as the first one is 0 so to bypass it 
for e = 2:length(Energy)
    psi_e = wave_function(Energy(e),V,dx,N); %generate wave fucntion for eigen energy states using found 
    figure(i);
    subplot(211);
    yyaxis right
    plot(x*10^10,V,'k','LineWidth',2)
    ylabel('Potential Energy eV','fontweight','bold')
    axis([-xmin xmax -2 12])
    hold on
    grid on
    yyaxis left
    plot(x*10^10,psi_e,'r','linewidth',1);
    axis([-xmin xmax -0.1 1.5*max(max(psi_e))])
    hold on
    xlabel('Well Length A^0','fontweight','bold')
    ylabel('\psi(x)','fontweight','bold','fontsize',16)
    title(sprintf('n =  %.0f', i),'fontsize',16)
    subplot(212);
    yyaxis right
    plot(x*10^10,V,'k','LineWidth',2)
    ylabel('Potential Energy eV','fontweight','bold')
    hold on
    grid on
    yyaxis left
    plot(x*10^10,psi_e.^2,'r','linewidth',1);
    hold on
    xlabel('Well Length A^0','fontweight','bold')
    ylabel('|\psi(x)|^2','fontweight','bold','fontsize',16)
    axis([-xmin xmax -0 1.5*max(psi_e.^2)])
    i=i+1;
end
figure(i);
ymin = 2;
ymax = 12;
plot(x*10^10,V,'k','linewidth',2)
hold on
grid on
%function to plot energy levels with potential function 
for e = 2:length(Energy)
   plot(x*10^10,Energy(e)*ones(size(x)),'r','linewidth',2);
   text(-3,Energy(e)+0.4,sprintf('%.3f eV     n_E = %.0f',Energy(e),e-1),'fontweight','bold','fontsize',12)
   hold on 
end
axis([-xmin xmax -ymin max(V)+4])
xlabel('Well Length A^0','fontweight','bold')
ylabel('Potential Energy eV','fontweight','bold')

end