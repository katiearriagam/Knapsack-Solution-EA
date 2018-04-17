function output = DE(fitness, dimensionality, lowerBound, upperBound, populationSize, crossoverRate, differentialWeight, stopCriterion, maxEvaluationsNoImprovement)

NUMBER_OF_RANDS_TO_SELECT = 3;
DIMENSION_ARRAY = 1;

population = lowerBound+(upperBound - lowerBound).*rand(populationSize, dimensionality);
for i = 1:populationSize
    population(i, dimensionality) = round(population(i, dimensionality));
end

% obtain fitness for the current population
evals = [];
for i=1:populationSize
    evals = [evals fitness(population(i,:))];
end

best_fitness_iter = [];
mean_fitness_iter = [];

counter = populationSize

% stop criterion = total evaluations
while counter <= stopCriterion && maxEvaluationsNoImprovement > 0
    counter = counter + 1;
    next_gen = [];
    next_gen_evals = [];
    for i=1:populationSize
        % rand mutation
        xi1 = population(randi(populationSize), :);
        xi2 = population(randi(populationSize), :);
        xi3 = population(randi(populationSize), :);
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
        
        child_fitness = fitness(child);
        
        if child_fitness < evals(i)
            next_gen = [next_gen; children];
            next_gen_evals = [next_gen_evals child_fitness];
        else
            maxEvaluationsNoImprovement = maxEvaluationsNoImprovement - 1;
            if maxEvaluationsNoImprovement > 0
                next_gen = [next_gen; population(i, :)];
                next_gen_evals = [next_gen_evals evals(i)];
            end
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
