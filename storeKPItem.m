function [knapsack, itemsKP, exFlag] = storeKPItem(knapsack, itemsKP, itemID)
    if knapsack.freeCapacity - itemsKP(itemID, 1) >= 0
        exFlag = 0;
        [knapsack, itemsKP] = updateKP(knapsack, itemsKP, itemID);
    else
        exFlag = -1;
    end
end

