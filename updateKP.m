function [knapsack, itemsKP] = updateKP(knapsack, itemsKP, itemID)
    % updateKP: this function stores a given item in the knapsack and
    % updates the available items
    
    % update free capacity in knapsack
    knapsack.freeCapacity = knapsack.freeCapacity - itemsKP(itemID, 1);
    knapsack.profit = knapsack.profit + itemsKP(itemID, 2);
    knapsack.weight = knapsack.weight + itemsKP(itemID, 1);
    % add new item to knapsack
    knapsack.items = [knapsack.items; itemsKP(itemID, :)];
    % remove item from itemsKP
    itemsKP(itemID, :) = [];
end
