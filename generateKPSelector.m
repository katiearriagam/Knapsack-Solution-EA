function selector = generateKPSelector(featuresAmt, rulesAmt, lb, ub)
    selector = lb + (ub - lb).*rand(rulesAmt, featuresAmt);
    actions = randi([1,4], rulesAmt,1);
    selector = [selector actions];
end