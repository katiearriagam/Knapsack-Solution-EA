function output = DE(fitness, dimensionality, lowerBound, upperBound,...
    populationSize, crossoverRate, differentialWeight, stopCriterion,...
    maxIterationsNoImprovement, features, training_set)

population = lowerBound+(upperBound - lowerBound).*rand(populationSize, dimensionality);

actionMultipleIndex = length(features) + 1;
for i=actionMultipleIndex:actionMultipleIndex:dimensionality
    population(:, i) = round(population(:, i));
end

% obtain fitness for the current population
evals = [];
for i=1:populationSize
    evals = [evals fitness(population(i,:), features, training_set)];
end

best_fitness_iter = [];
mean_fitness_iter = [];
last_best_fitness = -Inf;
counter = populationSize;
iterationsNoImprovement = maxIterationsNoImprovement;
best_plot = animatedline('Marker', 'o');
best_plot.Color = 'green';
mean_plot = animatedline('Marker', 'o');
mean_plot.Color = 'blue';
worst_plot = animatedline('Marker', 'o');
worst_plot.Color = 'red';
iterations = 0;
while counter <= stopCriterion && iterationsNoImprovement > 0
    next_gen = [];
    next_gen_evals = [];
    for i=1:populationSize
        % index1 = randi(populationSize); % rand mutation
        [~, index1] = max(evals); % best mutation
        index2 = index1;
        index3 = index1;
        while index2 == index1
            index2 = randi(populationSize);
        end
        while index3 == index1 || index3 == index2 
            index3 = randi(populationSize);
        end
        
        xi1 = population(index1, :);
        xi2 = population(index2, :);
        xi3 = population(index3, :);
        trialVector = xi1 + differentialWeight * (xi2 - xi3);
        
        % binomial crossover
        k = randi(dimensionality);
        child = zeros(1,dimensionality);
        for j=1:dimensionality 
            if rand <= crossoverRate || j == k
                child(j) = trialVector(j);
            else
                child(j) = population(i, j);
            end
        end
        
        for j=actionMultipleIndex:actionMultipleIndex:dimensionality
            child(j) = round(child(j));
        end
        
        for j=1:dimensionality
            if child(j) < lowerBound(j)
                child(j) = lowerBound(j);
            end
            if child(j) > upperBound(j)
                child(j) = upperBound(j);
            end
        end
        
        child_fitness = fitness(child, features, training_set);
        counter = counter + 1;
        
        if child_fitness > evals(i)
            next_gen = [next_gen; child];
            next_gen_evals = [next_gen_evals child_fitness];
        else
            next_gen = [next_gen; population(i, :)];
            next_gen_evals = [next_gen_evals evals(i)];
        end

        if counter > stopCriterion
            % All remaining individuals pass to the last next generation in
            % order to obtain the best fitness.
            next_gen = [next_gen; population(i+1:end, :)];
            next_gen_evals = [next_gen_evals evals(i+1:end)];
            break;
        end
    end
    population = next_gen;
    evals = next_gen_evals;

    % select best fitness
    [best_fitness, index] = max(evals);
    best_sol = population(index,:);
    best_fitness_iter = [best_fitness_iter best_fitness];
    mean_fitness_iter = [mean_fitness_iter mean(evals)];

    if best_fitness > last_best_fitness
        last_best_fitness = best_fitness;
        iterationsNoImprovement = maxIterationsNoImprovement;
    else
        iterationsNoImprovement = iterationsNoImprovement - 1;
    end

    % plot stuff
    addpoints(best_plot,iterations,best_fitness);
    addpoints(mean_plot,iterations,mean(evals));
    addpoints(worst_plot,iterations,min(evals));
    iterations = iterations + 1;
    drawnow
end

output = struct; 
output(1).Students = {'Andres Altamirano', 'Ana Catalina Arriaga', 'Omar Manjarrez'};
output(1).IDs = {'A01191723', 'A01280132', 'A00815248'};
output(1).best_sol = best_sol;
output(1).best_fitness = best_fitness;
output(1).best_fitness_iter = best_fitness_iter;
output(1).mean_fitness_iter = mean_fitness_iter;
output(1).iterations = iterations;
end
