function [ lambdaMin ] = smallEigenvalue( I, sigma )
%SMALLEIGENVALUE Summary of this function goes here
%   Detailed explanation goes here
    [w1,~] = gauss(sigma);
    g = grad(I);
    g1 = g{1,1};
    g2 = g{2,1};
    p = g1.*g1;
    r = g1.*g2;
    q = g2.*g2;
    p = conv2(w1, w1', p);
    r = conv2(w1, w1', r);
    q = conv2(w1, w1', q);
    lambdaMin = p + q - ((p-q).^2 + 4 * r.*r).^0.5;
end

