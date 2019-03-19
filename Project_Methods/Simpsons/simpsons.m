clear all; close all;

%read file containing problem and store it
%To do different test cases change file name here
fileIn = fopen('simpsons3.txt','r');

%get the function, a, b, N
func = fgetl(fileIn);
f = inline(func, 'x');
a = fgetl(fileIn);
a = str2double(a);
b = fgetl(fileIn);
b = str2double(b);
N = fgetl(fileIn);
N = str2double(N);
N = N + 1;

%compute h, for the problem
h = (b-a)/(N-1);

%break up interval a to b by N times, compute each Xi
for i=0:N-1
   X(1,i+1) = a + h * i; 
end

%plug in the X values and compute the Y values
for i=1:N
    Y(1,i) = feval(f, X(1,i));
end

%breaking the problem into parts
p1 = h/3;
p2 = Y(1,1);
p3 = Y(1,N);

%summation of the odd Xi indexes
i = 2;
odd = 0;
while i < N
    odd = odd + Y(1,i);
    i = i + 2;
end

%summation of the even Xi indexes
i = 3;
even = 0;
while i < N
    even = even + Y(1,i);
    i = i + 2;
end

%finish the summation parts
p4 = 2*even;
p5 = 4*odd;

%compute the result
res = p1 * (p2 + p3 + p4 + p5);

%display the answer
fprintf("The result of computing this integral is: " + res + "\n");

fclose(fileIn);