function output = DE(fitness, dimensionality, lowerBound, upperBound, populationSize, crossoverRate, differentialWeight, stopCriterion)

NUMBER_OF_RANDS_TO_SELECT = 3;
DIMENSION_ARRAY = 1;

% are bounds scalar variables?
population = lowerBound+(upperBound - lowerBound).*rand(populationSize, dimensionality);

% obtain fitness for the current population
evals = [];
for i=1:populationSize
    evals = [evals fitness(population(i,:))];
end

best_fitness_iter = [];
mean_fitness_iter = [];
for x=1:stopCriterion % stopCriterion means new evaluations or total evaluations (x=populationSize instead of x=1)?
    next_gen = [];
    next_gen_evals = [];
    for i=1:populationSize
        % mutation
        xi1 = population(randi(populationSize), :);
        xi2 = population(randi(populationSize), :);
        xi3 = population(randi(populationSize), :);
        trialVector = xi1 + differentialWeight * (xi2 - xi3);
        
        % crossover
        k = randi(dimensionality);
        child = zeros(1,dimensionality);
        for j=1:dimensionality 
            if rand <= crossoverRate || j == k
                child(j) = trialVector(j);
            else
                child(j) = population(i, j);
            end
        end
        
        child_fitness = fitness(child);
        
        if child_fitness < evals(i)
            next_gen = [next_gen; children];
            next_gen_evals = [next_gen_evals child_fitness];
        else
            next_gen = [next_gen; population(i, :)];
            next_gen_evals = [next_gen_evals evals(i)]
        end
    end
    population = next_gen;
    evals = next_gen_evals;

    % select best fitness
    [best_fitness, index] = min(evals);
    best_sol = population(index,:);
    best_fitness_iter = [best_fitness_iter best_fitness];
    mean_fitness_iter = [mean_fitness_iter mean(evals)];
end

output = struct; 
output(1).Students = {'Andres Altamirano', 'Ana Catalina Arriaga', 'Omar Manjarrez'};
output(1).IDs = {'A01191723', 'A01280132', 'A00815248'};
output(1).best_sol = best_sol;
output(1).best_fitness = best_fitness;
output(1).best_fitness_iter = best_fitness_iter;
output(1).mean_fitness_iter = mean_fitness_iter;
end