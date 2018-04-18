function fitness = fobj(individual, features, training_set)
    [rules, actions] = intermediateScript(individual, length(features));
    fitness = 0;
    for i=1:length(training_set)
        [knapsack, items] = getInstance(training_set(i));
        knapsack = knapsackMain(knapsack, items, rules, actions, features);
        fitness = fitness + knapsack.profit;
    end
end