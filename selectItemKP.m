function [itemID] = selectItemKP(items,HeurID)
    switch HeurID
        case 1
            itemID = 1;
        case 2
            % max profit
            item_with_max_profit = 1;
            for current = 1:size(items, 1)
                if items(current, 2) > items(item_with_max_profit, 2)
                    item_with_max_profit = current;
                end
            end
            itemID = item_with_max_profit;
        case 3
            % max profit/weight
            item_with_max_pw = 1;
            for current = 1:size(items, 1)
                if (items(current, 2)/items(current, 1)) > (items(item_with_max_pw, 2)/items(item_with_max_pw, 1))
                    item_with_max_pw = current;
                end
            end
            itemID = item_with_max_pw;
            
        case 4
            % min weight
            item_with_min_weight = 1;
            for current = 1:size(items, 1)
                if items(current, 1) < items(item_with_min_weight, 1)
                    item_with_min_weight = current;
                end
            end
            itemID = item_with_min_weight;
    end 
end