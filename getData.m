function  data  = getData( genotypes, n_strats )
%getData Summary of this function goes here
%   Detailed explanation goes here

max_mat_age = 100;
data = zeros(max_mat_age,n_strats);
for i = 1:max_mat_age
    for j = 1:n_strats
        data(i,j)=sum( (genotypes(:,1) == ones(length(genotypes),1)*j) & ...
            (genotypes(:,2) == ones(length(genotypes),1)*(i-1)));
    end
end

%TODO, chech if max_mat_age is exceeded.