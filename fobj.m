function fitness = fobj(individual, features, training_set)
    [rules, actions] = intermediateScript(individual, features);
    fitness = 0;
    for i=1:size(training_set, 2)
        [knapsack, items] = getInstance(training_set(i));
        knapsack = knapsackMain(knapsack, items, rules, actions, features);
        fitness = fitness + knapsack.fitness;
    end
end