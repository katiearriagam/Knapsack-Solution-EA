function instances = loadInstances(names)
    instances = [];
    for k=1:length(names)
        M = csvread(names(k));
        knapsackCapacity = M(1,2);
        items = zeros(M(1,1), 2);
        for i=1:M(1,1)
            items(i, 1) = M(i+1, 1);
            items(i, 2) = M(i+1, 2);
        end
        instance.items = items;
        instance.capacity = knapsackCapacity;
        instances = [instances instance];
    end
end