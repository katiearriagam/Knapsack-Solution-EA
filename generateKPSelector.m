function selector = generateKPSelector(featuresAmt, rulesAmt, lb, ub)
    selector = [];
    for i=1:rulesAmt
        for j=1:featuresAmt
            selector = [selector lb + (ub - lb).*rand];
        end
        selector = [selector randi(4)];
    end
end
