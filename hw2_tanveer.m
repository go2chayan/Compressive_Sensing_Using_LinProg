% Answer to Question # 3 for HW 2
% Assignment done by Md. Iftekhar Tanveer
clc;clear
p = 1000; % Size of A is n x p
idx = 0;
for n = 100:100:900
    % Creating a sparse vector x_star
    x_star = zeros(p,1);
    x_star(round(p*rand(20,1)))=1; % set 20 randomly selected elements to 1
    x_star = x_star .* (rand(p,1)-1/2); % Assign uniformly random values
    countSuccess = 0;
    idx = idx + 1;
    fprintf('n = %d\n',n)
    for i =1:10
        % Generating A and b
        A = randn(n,p);
        b = A*x_star;
        
        % Solve P1
        x = linprog(ones(1,2*p),[],[],[A,-A],b,zeros(2*p,1),[]);
        x_opt = x(1:p) - x(p+1:end);
        
        % Check equivalence
        x_diff = (x_opt - x_star);
        if (sqrt(x_diff'*x_diff)/sqrt(x_star'*x_star) < 1e-4)
            countSuccess = countSuccess + 1;
        end
    end
    successRate(idx) = countSuccess/10;
    stem(successRate);pause(0.2);
end

plot(100:100:900,successRate)
xlabel('Number of Rows in A matrix')
ylabel('Success Ratio');