function output = main(features, num_rules, population, crossover,...
    differentialWeight, max_evals, max_iterations, training_percentaje, seed)

    % Tested with:
    % main([1 2 3], 4, 50, .85, .9, 10000, 3, .25)
    % main([1 2 3 4 5 6 7], 5, 50, .85, .9, 10000, 3, .25)

    if (exist('seed', 'var'))
        rng(seed);
    end

    if (~exist('training_percentaje', 'var'))
        training_percentaje = .50;
    end

    instancesNames = ["instances/knapPI_11_20_1000_1.kp"...
        "instances/knapPI_11_50_1000_1.kp"...
        "instances/knapPI_11_100_1000_1.kp"...
        "instances/knapPI_11_200_1000_1.kp"];

    instances = loadInstances(instancesNames);
    n_instances = length(instances);
    training_set = [];
    while length(training_set) / n_instances < training_percentaje
        k = randi([1, length(instances)]);
        training_set = [training_set instances(k)];
        instances(k) = [];
    end
    test_set = instances;
    
    lowerBound = repmat([repmat(-100,1,length(features)) 1],1,num_rules);
    upperBound = repmat([repmat(100,1,length(features)) 4],1,num_rules);
    
    tic;
    evolution_output = DE(@fobj, (length(features) + 1) * num_rules,...
        lowerBound, upperBound, population, crossover, differentialWeight,...
        max_evals, max_iterations, features, training_set);
    tElapsed = toc;
    
    test_output = fobj(evolution_output.best_sol, features, test_set);

    output.students = {'Andres Altamirano', 'Ana Catalina Arriaga', 'Omar Manjarrez'};
    output.IDs = {'A01191723', 'A01280132', 'A00815248'};
    [~, ~, selector] = intermediateScript(evolution_output.best_sol, length(features));
    output.best_selector = selector;% Best individual
    output.best_fitness_training = evolution_output.best_fitness; % Best fitness for training set
    output.best_fitness_test = test_output; % Best fitness for test set
    % output.training_iterations = ;
    output.training_time = tElapsed;
    output.training_sets = training_set;
    output.test_sets = test_set;
end