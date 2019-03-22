

% simulation for american/european call and put option value
function V  = call_put(S,r,sigma,T,K,N, opttype, extype, t)
    dt = T/N
    u = exp(sigma*sqrt(dt))
    d = 1./u
    a = exp(r*dt)
    p = (a-d)/(u-d)    
    n = t*N/T

    V = S*d.^([N:-1:0]').*u.^([0:N]');
    if(opttype ==0)%put
        V = max(K-V,0);           
    else %call
        V = max(V-K, 0)
    end

    %backward recursion
    for i = N:-1:n+1
        if(extype == 1)
            %American
            W = S*d.^([i-1:-1:0]').*u.^([0:i-1]');
            if(opttype ==0) %put
                W = max(K-W,0)
            else %call
                W = max(W-K,0)
            end
            V = max(W,exp(-r*dt)*(p*V(2:i+1)+(1-p)*V(1:i)));            
        else
            V = exp(-r*dt)*(p*V(2:i+1)+(1-p)*V(1:i));
        end
    end
end
  

   

% run code for Q4 and show the results
function put_call_plot_payoff
    
    vac= call_put(S,r,sigma,T,K,N, 1, 1, t);
    A = S*d.^([n:-1:0]').*u.^([0:n]');
    plot(A,vac,A,max(A - K,0));
    legend('Price', 'Value');
    title('American call vs. payoff');

    %  American put option
    vap= call_put(S,r,sigma,T,K,N, 0, 1, t);
    plot(A,vap,A,max(K-A,0));
    legend('Price', 'Value');
    title('American put vs. payoff')

     %table output
     % put
     opttype =0;
     v0_us_put = call_put(S,r,sigma,T,K,N, opttype, 1, t);%American
     v0_eu_put = call_put(S,r,sigma,T,K,N, opttype, 0, t);%European
     % call
     opttype =1;
     v0_us_call = call_put(S,r,sigma,T,K,N, opttype, 1, t);%American
     v0_eu_call = call_put(S,r,sigma,T,K,N, opttype, 0, t);%European
     fprintf('European call and put option values at time t, versus that of American options\n')
     T = table(v0_us_call,v0_eu_call ,v0_us_put,v0_eu_put);
     disp(T);
end



