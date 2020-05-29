function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples
n = length(theta); % number of features

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

%Compute cost (regularized)
z=X*theta; %m x n * n x 1 = m x 1
H=sigmoid(z); %m x 1
y1=-1*y'*log(H); %1 x m * m x 1 = scalar; summed via transpose
y2=(-1*(1-y'))*log(1-H); %1 x m * m x 1 = scalar; summed via transpose
%skip theta 0
theta(1)=0;
regular=(lambda*(1/(2*m)))*(theta'*theta); %scalar * ((1 x n) * (n x 1))
J=((1/m)*(y1+y2))+regular;

Diff=H-y; %m x 1 - m x 1
Sum=Diff'*X;  %1 x m * m x n
regular2=(lambda/m)*theta; %scalar * n x 1
regular2=regular2';
regular2(1)=0;
grad=((1/m)*Sum)+regular2; %(1 x n * scalar) + 1 x n

% =============================================================

%transpose
grad = grad(:);

end
