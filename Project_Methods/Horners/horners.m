clear all; close all;

%read file containing problem and store it
%To do different test cases change file name here
fileIn = fopen('horners1.txt','r');
inType = '%f';
temp = [1 Inf];
inArr = fscanf(fileIn,inType,temp);
inSize = size(inArr);

%get poly degree, numbers in poly, and X0 
deg = inArr(1);
nums = inArr(2:inSize(2)-1);
x0 = inArr(inSize(2));
numsSize = size(nums);

%Get intial alpha and beta
alpha = nums(numsSize(2));
beta = nums(numsSize(2));

%input poly starts at lowest degree, so must go from the end to 1
i = numsSize(2)-1;
while i >= 1
    % if at the last number, only compute alpha, else compute both as beta
    % goes 1 less
   if i == 1
   alpha = alpha * x0 + nums(i);
   else 
   alpha = alpha * x0 + nums(i);
   beta = beta * x0 + alpha;
   end 
   i = i - 1;  
end

%alpha will be P(x0)
%beta will be P'(x0)
fprintf("P(x0) = " + alpha + "\n");
fprintf("P'(x0) = " + beta + "\n")

fclose(fileIn);