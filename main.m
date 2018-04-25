function output = main(features, num_rules, population, crossover,...
    differentialWeight, max_evals, max_iterations, training_percentaje, seed)

    NUMBER_OF_INSTANCES = 250; % max 603
    UPPER_BOUND = 200;

    % Tested with:
    % main([1 2 3 4 5 6 7], 5, 50, .85, .9, 5000, 15, .80)
    % main([1 4 7], 6, 30, .85, .9, 5000, 15, .80)

    if (exist('seed', 'var'))
        rng(seed);
    end

    if (~exist('training_percentaje', 'var'))
        training_percentaje = .50;
    end

    % Load instances
    
    files = dir('instances');
    instancesNames = [];
    for i=3:NUMBER_OF_INSTANCES
        instancesNames = [instancesNames {files(i).name}];
    end

    instances = loadInstances(instancesNames);
    n_instances = length(instances);
    training_set = [];
    % Divide instances in training set and test test
    while length(training_set) / n_instances < training_percentaje
        k = randi([1, length(instances)]);
        training_set = [training_set instances(k)];
        instances(k) = [];
    end
    test_set = instances;
    
    % Define boundaries
    lowerBound = repmat([repmat(0,1,length(features)) 1],1,num_rules);
    upperBound = repmat([repmat(UPPER_BOUND,1,length(features)) 4],1,num_rules);
    
    % Call DE, measuring time
    tic;
    evolution_output = DE(@fobj, (length(features) + 1) * num_rules,...
        lowerBound, upperBound, population, crossover, differentialWeight,...
        max_evals, max_iterations, features, training_set);
    tElapsed = toc;
    
    % Validate best selector with test_set
    test_output = fobj(evolution_output.best_sol, features, test_set);
    
    % We need another selector to compare with
    best_random_selector = [];
    best_fitness_random = -Inf;
    iterations = 5;
    while iterations > 0
        random_selector = generateKPSelector(length(features), num_rules, lowerBound(1), upperBound(1));
        random_fitness = fobj(random_selector, features, test_set);
        if random_fitness > best_fitness_random
            best_fitness_random = random_fitness;
            best_random_selector = random_selector;
        end
        iterations = iterations - 1;
    end

    output.students = {'Andres Altamirano', 'Ana Catalina Arriaga', 'Omar Manjarrez'};
    output.IDs = {'A01191723', 'A01280132', 'A00815248'};
    [~, ~, selector] = intermediateScript(evolution_output.best_sol, length(features));
    output.best_selector = selector;% Best individual
    output.best_fitness_training = evolution_output.best_fitness; % Best fitness for training set
    output.best_fitness_test = test_output; % Best fitness for test set
    output.training_iterations = evolution_output.iterations;
    output.training_time = tElapsed;
    output.training_sets = training_set;
    output.test_sets = test_set;
    [~, ~, random_selector] = intermediateScript(best_random_selector, length(features));
    output.best_random_selector = random_selector;
    output.best_fitness_random = best_fitness_random;
end