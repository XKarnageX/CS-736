function I_filtered = myFilter(I,theta,xp,type,L)
%     type=2  Shepp-logan
%     type=3  cos
%     type=1  Ram-Lak

N = length(xp);
N_theta = length(theta);
freqs = abs(linspace(-1, 1, N)');
pi_wby2 = linspace(-pi/2, pi/2, N)';
% myFilter3 = abs(freqs);
% myFilter3 = repmat(myFilter3, [1 N_theta]);

if (type == 2)
    filter = freqs .* (sin(pi_wby2/L) ./ (pi_wby2/L));
    filter((N+1)/2) = 0;
elseif (type == 3)
    filter = freqs .* cos(pi_wby2/L);
elseif (type == 1)
    filter = freqs;
end

filter(freqs>L) = 0;
myFilt = repmat(filter, [1 N_theta]);

ft_I = fftshift(fft(I),1);
filteredProj = ft_I .* myFilt;
filteredProj = ifftshift(filteredProj,1);
I_filtered = ifft(filteredProj);
end
