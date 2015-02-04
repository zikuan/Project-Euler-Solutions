%% Quadratic Primes 27

%% Brute Force (Pretty Slow)
clear;close all;clc;
tic

p = primes(100);
nMax = 0;aMax=0;bMax=0;x = zeros(1,250);
for a = -999:2:999
    for j = 1:length(p)
        b = p(j);
        n = 0;
        i = 1;
        while (1)
            x(i) = n^2 + a*n + b;
            if isprime(abs(x(i))) == 1  %actually slower than using ismember(x(i),p).
                n = n+1;
                i = i+1;
            else
                break
            end
        end
        
        if n > nMax
            aMax = a;
            bMax = b;
            nMax = n;
        end
    end
end

final = aMax * bMax;
fprintf('A sequence of length %d, is generated by a=%d, b=%d, the product is %d\n',nMax, aMax,bMax, final);

toc;

%% Vectorized Version
clear;close all;clc;
tic

b = primes(1000);
a = [-999:2:999]';
p = [];
n = 0;

for i = 1:length(b)
    p = [p; b(i)*ones(size(a)) a];
end

while numel(p)~=2
    c = (n^2+n*p(:,2)+p(:,1));
    p(c<0,:) = '';
    p(~isprime(c(c>=0)),:) = '';    
    n = n + 1;   
end

disp(prod(p))

toc