function [output] = fnum2str(n)
nstr = num2str(n);
output = nstr;
if n < 100
   output = strcat('0', nstr);
end
if n < 10
   output = strcat('0', '0', nstr);
end
end

