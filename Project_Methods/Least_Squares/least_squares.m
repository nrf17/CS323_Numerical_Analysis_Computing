clear all; close all;

%read file containing problem and store it
%To do different test cases change file name here
fileIn = fopen('ls1.txt','r');
inType = '%f';
temp = [1 Inf];
inArr = fscanf(fileIn,inType,temp);
inSize = size(inArr);

%get the number of points, the degree, and (x,y) points
n = inArr(1);
deg = inArr(2);
points = inArr(3:inSize(2));
pointsSize = size(points);

%extract and store the X and Y points
X = points(1:2:pointsSize(2));
Y = points(2:2:pointsSize(2));

%compute N
N = size(X,1);
if N == 1
   N = size(X,2);
end

%compute the RHS b vector, which is made of sums of powers of X times Ys
b = zeros(deg+1,1);
for i = 1:N
   for j = 1:deg+1
      b(j) = b(j) + Y(i)*X(i)^(j-1);
   end
end

%compute Z, which sums the Xs powers
Z = zeros(2*deg+1,1);
for i = 1:N
   for j = 1:2*deg+1
      Z(j) = Z(j) + X(i)^(j-1);
   end
end

%distribute among matrix A, Xs sums of powers
for i = 1:deg+1
   for j = 1:deg+1
      matA(i,j) = Z(i+j-1);
   end
end

Res = matA\b;

%creating and evaluate x-axis and least square polynomial for graph
t = min(X):0.05:max(X);
N = size(t,2);
for i = 1:N
   F(i) = Res(deg+1);
   for j = deg:-1:1
      F(i) = Res(j) + F(i)*t(i);
   end
end

%display the result
for i=1:deg+1
   fprintf(Res(i) + " ");
end
fprintf("\n");

%display graph with least squares polynomial and the points
figure;
plot(t,F);
hold on;
plot(X, Y, 'r*');
grid on;

fclose(fileIn);