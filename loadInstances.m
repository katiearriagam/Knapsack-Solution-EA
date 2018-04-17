function [items, knapsackCapacity] = loadInstances(instanceName)
    M = csvread(instanceName);
    knapsackCapacity = M(1,2);
    items = zeros(M(1,1), 2);
    for i=1:M(1,1)
        items(i, 1) = M(i+1, 1);
        items(i, 2) = M(i+1, 2);
    end
end