clear all; close all;

%read file containing problem and store it
%To do different test cases change file name here
fileIn = fopen('cramers1.txt','r');
inType = '%f';
temp = [1 Inf];
inArr = fscanf(fileIn,inType,temp);
inSize = size(inArr);

%Get matrix dimensions, and totals number in matrix
matN = inArr(1);
matSize = matN * matN;

%get the numbers for and create matrix on LHS
matA = inArr(2 : matSize+1 );
lhs = vec2mat(matA, matN);

%get numbers for and create matrix on RHS
matB = inArr(matSize+2 : inSize(2) );
rhs = vec2mat(matB, 1);

%----------------------------------------------------------------------

%Do Gaussian Elimination for matrix A
A = lhs;
[n, ~] = size(A);
for i=1:n-1
    m = A(i+1:n,i)/A(i,i);
    A(i+1:n,:) = A(i+1:n,:) - m*A(i,:);
end

%After Gaussian Elimination, get the diagonal of the matrix and compute the
%determinant of matrix A
diagonal = diag(A);
detA = 1;
for j=1:n
    detA = detA * diagonal(j);
end
dets(1,1) = detA;

%----------------------------------------------------------------------

%Repeat the same process for each matrix Ai with vector b for cramers rule
for i=1:matN
    %Create matrix Ai for cramers rule, with vector b
    Ai = lhs;
    Ai(:,i) = rhs(:);
    
    %Guassian Elimination
    [n, ~] = size(Ai);
    for j=1:n-1
        m = Ai(j+1:n,j)/Ai(j,j);
        Ai(j+1:n,:) = Ai(j+1:n,:) - m*Ai(j,:);
    end

    %Compute determinant for matrix Ai, store result
    diagonal = diag(Ai);
    detAi = 1;
    for j=1:n
        detAi = detAi * diagonal(j);
    end
    dets(1,i+1) = detAi;
end

%----------------------------------------------------------------------

%Display determinant for matrix A and each matrix Ai
for i=1:n+1
    if(i == 1)
        fprintf("determinant A = " + dets(1,i) + "\n");
    else
        fprintf("determinant A" + (i-1) + " = " + dets(1,i) + "\n");
    end
end

%Compute and display each Xi
for i=2:n+1
    res = dets(1,i)/dets(1,1);
    fprintf("x" + (i-1) + " = " + res + "\n");
end

fclose(fileIn);