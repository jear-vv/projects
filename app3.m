for i=1:256
y(257-i) = 1.2*i + 10;
end;
for n=1:256
for m=1:256
if (n > y(m))
f(n,m) = 255;
else
f(n,m) = 0;
end;
end;
end;