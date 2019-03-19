clear all; close all;

%read file containing problem and store it
%To do different test cases change file name here
fileIn = fopen('nevilles1.txt','r');
inType = '%f';
temp = [1 Inf];
inArr = fscanf(fileIn,inType,temp);
inSize = size(inArr);

%get matrix dimensions, (x,y) points, and x0
matDim = inArr(1);
nums = inArr(2: inSize(2)-1);
x0 = inArr(inSize(2));

%extract and store all the Y values
itr = 2;
count = 1;
while itr <= (matDim*2)
    Y(1,count) = nums(1, itr);
    itr = itr + 2;
    count = count+1;
end

%extract and store all the X values
itr = 1;
count = 1;
while itr <= (matDim*2-1)
    X(1,count) = nums(1, itr);
    itr = itr + 2;
    count = count+1;
end

%Places the Y values along the diagonal of the table
matA = zeros(matDim, matDim);
for i=1:matDim
   matA(i,i) = Y(1,i); 
end

%loop through the upper diagonals AKA compute the upper right triangle
for d=2:matDim
    for i=1:(matDim-d+1)
        %comput j, then Pij and place it in the table
        j = i + d - 1;
        p1 = matA(i+1,j);
        p2 = x0 - X(1,i);
        p3 = matA(i,j-1);
        p4 = x0 - X(1,j);
        bot = X(1,j) - X(1,i);
        matA(i,j) = ((p1*p2) - (p3*p4))/bot;
    end
end

%display the result P(x0)
fprintf("P(x0) = " + matA(1,matDim) + "\n");

fclose(fileIn);