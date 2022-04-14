function [t,s] = fuzzy_tnorm(a, b, tnorm_type, tnorm_param)

tnorm_type = upper(tnorm_type);
% 
% a = reshape(a,1,[]);
% b = reshape(b,1,[]);

switch tnorm_type
    case 'GODEL'
        t = min(a,b);
        s = max(a,b);
    case 'HAMCHER'
        t = (a.*b) ./ (a+b-a.*b);
        s = (a+b-2*a.*b) ./ (1-a.*b);
    case 'PRODUCT'
        t = a.*b;
        s = a+b-a.*b; 
    case 'EINSTEIN'
        t = (a.*b)./(1+(1-a).*(1-b));
        s = (a+b)./(1+a.*b);
    case 'GILES'
        t = max(0,a+b-1);
        s = min(1,a+b);
    case 'FODOR'
        t = ((a+b)>1) .* min(a,b) + ((a+b)<=1) .* 0;
        s = ((a+b)<1) .* max(a,b) + ((a+b)>=1) .* 1;
    case 'YAGER'
        p = tnorm_param;
        t = 1-min(1, ((1-a).^p+(1-b).^p).^(1./p) );
        s = min(1,(a.^p+b.^p).^(1./p));
    case 'WEBER'
        p = tnorm_param;
        t = max(0, (a+b-1+p.*a.*b)./(1+p));  %p>-1
        s = min(1,a+b+p.*a.*b);
    case 'FRANK'
        p = tnorm_param;
        t = logB(1+((p.^a-1).*(p.^b-1))./(p-1), p);  %p>0, p<>0
        s = 1-logB(1+((p.^(1-a)-1).*(p.^(1-b)-1))./(p-1), p);
    case 'DUBOIS'
        p = tnorm_param;
        t = a.*b./max(max(a,b),p);  %p>=0, p<=1
        s = 1-(1-a).*(1-b)./max(max(1-a,1-b),p);
end
end
