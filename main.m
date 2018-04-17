function output = main(features, num_rules, seed, population, crossover,...
    max_evals, max_iterations, training_percentaje, differentialWeight)
    % TODO: choose training_percentaje of instances to use as training set.
    
    lowerBound = repmat([repmat(-100,1,features) 1],1,num_rules);
    upperBound = repmat([repmat(100,1,features) 4],1,num_rules);
    
    evolution_output = DE(@fobj, (lenght(features) + 1) * num_rules,...
        lowerBound, upperBound, population, crossover, differentialWeight,...
        max_evals, max_iterations, features);
    
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