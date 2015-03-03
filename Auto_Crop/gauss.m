function [ w1, u ] = gauss( sigma )
%GAUSS Summary of this function goes here
%   Detailed explanation goes here
    h = ceil(2.5 * sigma);
    u = (-h:h)';
    w1(1:2*h+1,1) = (2*pi*sigma*sigma)^(-0.5)*exp(-0.5.*((u/sigma).^2));
    % normalize
    c = sum(w1);
    w1 = w1/c;
end


