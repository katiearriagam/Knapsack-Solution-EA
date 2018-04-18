function [knapsack] = knapsackMain(knapsack, items, rules, actions, featureIDs)
    knapsack = knapsackFitness(knapsack);
    
    while(size(items, 1) > 0)
        featureVec = getKPFeatures(items, featureIDs);
        
        isNullFeatureVec = isnan(featureVec);
        
        for i=1:length(isNullFeatureVec)
            if isNullFeatureVec(i) == 1
                featureIDs(i) = [];
                rules(:, i) = [];
                featureVec = getKPFeatures(items, featureIDs);
            end
        end
        
        Ft = featureVec;
        ds = sqrt(sum(abs(rules - featureVec).^2, 2));
        rules;
        
        [~, actionIndex] = min(sqrt(sum(abs(rules - featureVec).^2, 2)));
        heurID = actions(actionIndex);
        
        itemToAdd = selectItemKP(items, heurID);
 
        [knapsack, items, exFlag] = storeKPItem(knapsack, items, itemToAdd);
        
        if exFlag == -1
            items(itemToAdd, :) = [];
        else
            knapsack.items;
        end
    end
    
    knapsack = knapsackFitness(knapsack);
end