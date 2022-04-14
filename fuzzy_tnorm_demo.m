clc
clear
close all

[a,b] = meshgrid(0:0.05:1);
colormap jet;

%% t-norms & t-conorms(s-norms)
figure(1);
tnorm_name = {'Godel', 'Hamcher', 'Product', 'Einstein', 'Giles', 'Fodor'};
n = 0;
for k =1:length(tnorm_name)
    [t,s] = fuzzy_tnorm(a, b, tnorm_name{k});

    n = n+1;
    plot_tnorm(a,b,t,tnorm_name{k},'t-norm',3,4,n);

    n = n+1;
    plot_tnorm(a,b,s,tnorm_name{k},'s-norm',3,4,n);
end

%% parametric t-norms & t-conorms(s-norms)
parameter_tnorm_name = {'yager', 'weber', 'frank', 'dubois'};
P{1} = [eps 0.5 1 3];
P{2} = [-1+eps 0 1 3];
P{3} = [eps 1+eps 3];
P{4} = [0 0.3 0.7 1];
for q = 1:length(parameter_tnorm_name)
    figure(q+1);
    p = P{q};
    for k = 1:length(p)
        [t,s] = fuzzy_tnorm(a, b, parameter_tnorm_name{q}, p(k));
    
        plot_tnorm(a,b,t,sprintf('%s (p=%.2f)',parameter_tnorm_name{q},p(k)),'t-norm',2,length(p),1+2*(k-1));
        plot_tnorm(a,b,s,sprintf('%s (p=%.2f)',parameter_tnorm_name{q},p(k)),'s-norm',2,length(p),2+2*(k-1));
    end
end

%% aux function
function plot_tnorm(a,b,Is,plot_title,z_label,m,n,selected_plot)
    subplot(m,n,selected_plot);
    surf(a,b,Is);
    xlabel('a');
    ylabel('b');
    zlabel(z_label);
    grid minor;
    title(plot_title);
    axis square;
end