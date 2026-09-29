%-------------------------------------------------------------------------%
%This function finds the cycle decomposition of a given permutation p,
%expressed in vector notation, and computes the number of cycles of p
%contained in the set S.

%Inputs:
% - p: permutation expressed in vector notation;
% - S: subset

%Output:
% - cycles: cycles contained in the cycle decomposition of p;
% - cyclesrem: cycles remaining after performing a partial trace over the
% subsystem S;
% - num: number of cycles contained in the subset S.
%-------------------------------------------------------------------------%

function [cycles,cyclesrem,num] = cycle_decomp(p,S)

%Length of the permutation
n = length(p);

%Inizialisation of the visited array
visit = false(1,n); %All the positions have not been visited yet
cycles = {};

for i = 1 : n
    if visit(i) == 0 %Position not visited
        cycle = []; %Start cycle
        j = i;

        while visit(j) == 0 %Position not visited
            cycle = [cycle, j];
            visit(j) = 1; %Position visited
            j = p(j); %Next index = position of the permutation
        end
        cycles{end+1} = cycle;
    end
end

%Number of cycles in S
num = 0;
for k = 1 : length(cycles)
    memb = ismember(cycles{k},S); %Elements of S included in the cycles
    if sum(memb) == length(cycles{k})
        num = num + 1;
    end
    cyclesrem{k} = cycles{k};
    for l = 1 : length(memb)
        if memb(l) == 1 %Elements in the set
            cyclesrem{k}(l) = 0; %Substitution with 0
        end
    end
    cyclesrem{k} = nonzeros(cyclesrem{k}); %Remotion of the elements
end
cyclesrem(cellfun(@isempty,cyclesrem)) = [];
