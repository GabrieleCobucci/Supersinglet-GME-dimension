%-------------------------------------------------------------------------%
%This function converts into vector notation a permutation expressed in its
%cyclic decomposition.

%Inputs:
% - cycles: cycle decomposition of the permutation;
% - n: number of elements in the permutation.

%Output:
% - perm: permutation in its vector notation.
%-------------------------------------------------------------------------%

function perm = cycltoperm(cycles,n)

%Permutation elements
perm = [1:n];

for l = 1 : length(cycles)
    cyc = cycles{l};
    if length(cyc) > 1 %Cycles
        for k = 1 : length(cyc)-1
            perm(cyc(k)) = cyc(k+1); %Permute cycle elements
        end
        perm(cyc(end)) = cyc(1); %Last element permutation
    end

end