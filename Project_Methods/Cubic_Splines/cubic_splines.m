clear all; close all;

%read file containing problem and store it
%To do different test cases change file name here
fileIn = fopen('cs1.txt','r');
inType = '%f';
temp = [1 Inf];
inArr = fscanf(fileIn,inType,temp);
inSize = size(inArr);

%get the dimension and (x,y) points
n = inArr(1);
vals = inArr(2:inSize(2));
valsSize = size(vals);

%extract and store X and Y values
%The Y array will act as the A array for the Ai values
X = vals(1:2:valsSize(2));
Y = vals(2:2:valsSize(2));

%Create and set the matrix
A = zeros(n, n);
A(1,1) = 1;
A(n,n) = 1;

%compute h values
for i=2:n
    hVals(1,i-1) = X(1,i) - X(1,i-1);
end

%set the A matrix, goes by the main diagonal, along with the ones above and
%below
for i=2:n-1
    A(i,i) = 2*( hVals(1,i-1) + hVals(1,i) );
    A(i,i-1) = hVals(1,i-1);
    A(i,i+1) = hVals(1,i);
end

%create and compute the RHS vector, needed in order to compute C values
rhs = zeros(n, 1);
for i=1:n-2
    p1 = 3/hVals(1,i+1);
    p2 = Y(1, i+2) - Y(1, i+1);
    p3 = 3/hVals(1, i);
    p4 = Y(1, i+1) - Y(1, i);
    res = (p1*p2) - (p3*p4);
    rhs(i+1,1) = res;
end

%solve for all the Ci values
C = inv(A)*rhs;

%solve for all Di values
for i=1:n-1
    D(i,1) = (1/(3*hVals(1,i))) * (C(i+1,1) - C(i,1));
end

%solve for all Bi values
for i=1:n-1
    p1 = (Y(1,i+1) - Y(1,i)) / hVals(1,i);
    pA = (2*C(i,1) + C(i+1)) / 3;
    p2 = pA * hVals(1, i);
    res = p1 - p2;
    B(i,1) = res;
end

%print out the Ai, Bi, Ci, Di values aka Si(x)
for i=1:n-1
   fprintf(Y(1,i) + "\t" + B(i,1) + "\t" + C(i,1) + "\t" + D(i,1) + "\n");
end

%take Si(x) polynomials and plot them
t = 1:n;
points = 20;
for i=1:n-1
   aa = linspace(t(i),t(i+1),points);
   Xi = repmat(t(i),1,points);
   bb = (Y(1,i)+B(i,1)*(aa-Xi)) + (C(i,1) * (aa-Xi).^2)+(D(i,1)*(aa-Xi).^3); 
   plot(X,Y,'r*', aa,bb,'LineWidth',2);
   hold on;
end
xlim([0 max(X)+1]);
ylim([0 max(Y)+1]);

fclose(fileIn);