function output = main(features, num_rules, seed, population, crossover,...
    differentialWeight, max_evals, max_iterations, training_percentaje)

    % Tested with:
    % main([1 2 3], 4, 0, 50, .85, .9, 10000, 3, 0)

    instancesNames = ["instances/knapPI_11_20_1000_1.kp"...
        "instances/knapPI_11_50_1000_1.kp"...
        "instances/knapPI_11_100_1000_1.kp"];

    % TODO: choose training_percentaje of instances to use as training set.
    training_set = loadInstances(instancesNames);
    test_set = training_set;
    
    lowerBound = repmat([repmat(-100,1,length(features)) 1],1,num_rules);
    upperBound = repmat([repmat(100,1,length(features)) 4],1,num_rules);
    
    evolution_output = DE(@fobj, (length(features) + 1) * num_rules,...
        lowerBound, upperBound, population, crossover, differentialWeight,...
        max_evals, max_iterations, features, training_set);
    
    output.students = {'Andres Altamirano', 'Ana Catalina Arriaga', 'Omar Manjarrez'};
    output.IDs = {'A01191723', 'A01280132', 'A00815248'};
    output.best_selector = evolution_output.best_sol; % Best individual
    output.best_fitness_training = evolution_output.best_fitness; % Best fitness for training set
    % output.best_fitness_test = ; % Best fitness for test set
    % output.training_iterations = ;
    % output.training_time = ;
    % output.training_sets = ;
    % output.test_sets = ;
end