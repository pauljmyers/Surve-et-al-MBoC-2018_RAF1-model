function [I] = simpsons(f,x)
%[I] = simpsons(f,x)
%Calculates the integral I of F over X using Simpson's combined quadrature rule. X and
%F must be vectors of equal length. This function works for both evenly and
%unevenly spaced points and for both even and odd numbers of integration
%panels.

N = length(x)-1;
I = 0; %initialize integral;

for i = 1:N/2
    %Simpson's rule for unevenly spaced points
    h2i1 = x(2*i+1)-x(2*i);
    h2i = x(2*i)-x(2*i-1);
    
    alpha = (2*h2i1^3 - h2i^2 + 3*h2i*h2i1^2)/(6*h2i1*(h2i1+h2i));
    beta = (h2i1^2 + h2i^3 + 3*h2i1*h2i*(h2i1+h2i))/(6*h2i1*h2i);
    eta = (2*h2i^3-h2i^3+3*h2i1*h2i*(h2i1+h2i))/(6*h2i*(h2i1+h2i));
    
    S = alpha*f(2*i+1) + beta*f(2*i) + eta*f(2*i-1);
    I = I + S;
end

if rem(N+1,2) == 0 
    hN1 = x(N+1)-x(N);
    hN2 = x(N)-x(N-1);
    
    alphaN = (2*hN1^2 + 3*hN1*hN2)/(6*(hN2+hN1));
    betaN = (hN1^2 + 3*hN1*hN2)/(6*hN2);
    etaN = -hN1^3/(6*hN2*(hN2-hN1));
    
    S = alphaN*f(N+1)+betaN*f(N)+etaN*f(N-1);
    I = I + S;
end
end
