function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

C_cand = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
sigma_cand = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
err = zeros(length(C_cand), length(sigma_cand));

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%


for i = 1:length(C_cand)
    C = C_cand(i);
    for k = 1:length(sigma_cand)
        sigma = sigma_cand(k);
        model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
        predictions = svmPredict(model, Xval);
        err(i,k) = mean(double(predictions ~= yval));
    end
end
    
[M,I] = min(err(:));
[I_row,I_col] = ind2sub(size(err), I);
C = C_cand(I_row);
sigma = sigma_cand(I_col);

% =========================================================================

end
