function [knapsack] = knapsackFitness(knapsack)
    if (size(knapsack.items, 1) > 0)
        if (size(knapsack.items, 1) == 1)
            knapsackSum = knapsack.items;
        else
            knapsackSum = sum(knapsack.items);
        end
        knapsack.profit = knapsackSum(2);
        knapsack.weight = knapsackSum(1);
        knapsack.isValid = knapsack.weight <= knapsack.maxWeight;
    else
        knapsack.profit = 0;
        knapsack.weight = 0;
        knapsack.isValid = 1;
    end
end