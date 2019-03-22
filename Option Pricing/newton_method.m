
% `newton_method` solves equation f(x)=0 and print out each iteration.
% f is the scalar function to solve
% df is the derivative function of f
% x0 is the initial point
% tol is the tolerance
function x = newton_method(f, df, x0, tol)
   n = 1;
   x(n) = x0;
   fn = f(x0);
   xn = [x0];
   fxn = [fn];
   while 1
       dn = -fn(n)/df(x(n));
       alpha = 1;
       fkn = f(x(n) + alpha * dn);
     while abs(fkn) >= abs(fn(n))
         alpha = alpha/2;
         fkn = f(x(n) + alpha * dn);
     end

     x(n+1) = x(n) + alpha*dn;
     fn(n+1) = fkn;
     n = n+1;
     xn = [xn;x(n)];
     fxn = [fxn; fn(n)];
     if (abs(fn(n)) <= tol || abs(x(n) - x(n-1)) <= tol)
         break
     end
   end
   n = [0:n-1]'
   t = table(n, xn, fxn)
   disp(t)
end
        
      



