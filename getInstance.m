function [knapsack, items] = getInstance(instance_data)
    items = instance_data.items;
    knapsack.items = [];
    knapsack.maxWeight = instance_data.capacity;
    knapsack.profit = 0;
    knapsack.weight = 0;
    knapsack.isValid = 1;
    knapsack.freeCapacity = knapsack.maxWeight;
end