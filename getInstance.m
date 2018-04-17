function [knapsack, items] = getInstance(instance_id)
    instanceName = "some_prefix" + instance_id;
    [items, knapsackCapacity] = loadInstances(instanceName);
    
    knapsack.items = [];
    knapsack.maxWeight = knapsackCapacity;
    knapsack.profit = 0;
    knapsack.weight = 0;
    knapsack.isValid = 1;
    knapsack.freeCapacity = knapsack.maxWeight;
end