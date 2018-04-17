function [featureVec] = getKPFeatures(items, featuresIDs)
    tam = size(featuresIDs, 2);
    featureVec = zeros(tam, 1)';
    for i=1:tam
        switch featuresIDs(i)
            case 1 % promedio normalizado del peso
                featureVec(i) = mean(items(:,1)) / max(items(:, 1));
            case 2 % mediana normalizada del peso
                featureVec(i) = median(items(:,1)) / max(items(:, 1));
            case 3 % desviacion estandar del peso
                featureVec(i) = std(items(:,1)) / max(items(:, 1));
            case 4 % promedio normalizado del profit
                featureVec(i) = mean(items(:,2)) / max(items(:, 2));
            case 5 % mediana normalizada del profit
                featureVec(i) = median(items(:,2)) / max(items(:, 2));
            case 6 % desviacion estandar del profit
                featureVec(i) = std(items(:,2)) / max(items(:, 2));
            case 7 % correlacion normalizada entre el peso y el profit
                featureVec(i) = corr(items(:,1), items(:,2)) / 2.0 + 0.5;
        end
    end
end