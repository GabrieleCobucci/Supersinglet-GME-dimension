%-------------------------------------------------------------------------%
%This function evaluates the symmetrised SDP for the white noise robustness
%of the GME-dimension for the supersinglet state.

%Inputs:
% - n: dimension and number of parties
% - k: GME-dimension

%Output:
% - v: maximum visibility at which a noisy supersinglet state has
% GME-dimension = k.
%-------------------------------------------------------------------------%

function v = GMEdimSS(n,k)

%% Permutations and Young tableaux

%Dimension
d = n;

%Number of bipartitions
s = Stirling2nd(n,2);

%Set of bipartitions
bipartitions = SetPartition(n,2);

%Permutations
pp = perms([1:n]);
nperm = length(pp);

%Permutation map
permIndex = containers.Map('KeyType','char','ValueType','double');
for q = 1 : nperm
    key = sprintf('%d_',pp(q,:));
    permIndex(key) = q;
end

%Identity index
inde = permIndex(sprintf('%d_',[1:n]));

%Young basis
for p = 1 : nperm
    rho{p} = rhoYoungAll(pp(p,:));
end

%Number of Young tableaux
numlambda = numel(rho{1});

%Bipartition permutations
for m = 1 : floor(n/2)
    permS{m} = [];
    permSinv{m} = [];
end

for j = 1 : s
    b = cell2mat(bipartitions{j}(1));
    c = cell2mat(bipartitions{j}(2));
    if length(b) <= length(c)
        set = [b];
        comp = [c];
    else
        set = [c];
        comp = [b];
    end
    order = [set comp];
    lset = length(set);
    [~,perm1] = sort(order);
    [~,perm2]= sort(perm1);
    permS{lset} = [permS{lset}; perm1];
    permSinv{lset} = [permSinv{lset}; perm2];
end

%% SDP

%Constraints
C = [];

%Variables
v = sdpvar(1);
for m = 1 : floor(n/2)
    for p = 1 : nperm
        x{m,p} = sdpvar(1);
    end
    for p = 1 : nperm
        [~,perminv] = sort(pp(p,:)); 
        pinv = permIndex(sprintf('%d_',perminv));
        if ne(pinv,p)
            C = [C, x{m,p} == x{m,pinv}];
        end
    end
end

for p = 1 : nperm
    sumop = 0;
    for m = 1 : floor(n/2)
        oldp = pp(p,:);
        [nrow,ncol] = size(permS{m});
        for j = 1 : nrow
            PgS = permS{m}(j,:);
            PgSinv = permSinv{m}(j,:);
            q = permIndex(sprintf('%d_',PgS(oldp(PgSinv))));
            sumop = sumop + x{m,q};
        end
    end
    C = [C, v/factorial(n)*(-1)^permutationparity(pp(p,:)) + (1-v)/d^n*[p == inde] == sumop];
end

for m = 1 : floor(n/2)
    ptset = [1:m];
    ptcomp = setdiff([1:n],ptset);
    for l = 1 : numlambda
        %Positivity
        sumop = 0;
        for p = 1 : nperm
            sumop = sumop + x{m,p}*rho{p}(l).rho;
        end
        sumop = (sumop + sumop')/2;
        C = [C, sumop >= 0];
        %Reduction map
        sumopset = 0;
        for p = 1 : nperm
            [cycles,cyclesrem,num] = cycle_decomp(pp(p,:),ptset);
            for j = 1 : length(ptset)
                indj = length(cyclesrem);
                cyclesrem{indj+1} = ptset(j);
            end
            tildep = permIndex(sprintf('%d_',cycltoperm(cyclesrem,n)));
            sumopset = sumopset + x{m,p}*(d^(num)*rho{tildep}(l).rho - 1/k*rho{p}(l).rho);
        end
        sumopset = (sumopset + sumopset')/2;
        C = [C, sumopset >= 0];
        sumopcomp = 0;
        for p = 1 : nperm
            [cycles,cyclesrem,num] = cycle_decomp(pp(p,:),ptcomp);
            for j = 1 : length(ptcomp)
                indj = length(cyclesrem);
                cyclesrem{indj+1} = ptcomp(j);
            end
            tildep = permIndex(sprintf('%d_',cycltoperm(cyclesrem,n)));
            sumopcomp = sumopcomp + x{m,p}*(d^(num)*rho{tildep}(l).rho - 1/k*rho{p}(l).rho);
        end
        sumopcomp = (sumopcomp + sumopcomp')/2;
        C = [C, sumopcomp >= 0];
    end
end


%SolveSDP
disp('Options')
ops=sdpsettings('solver','mosek', 'cachesolvers', 1);
diagnostic=solvesdp(C,-v,ops)

v=double(v)

end