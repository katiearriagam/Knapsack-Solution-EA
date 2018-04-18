function [rules, actions] = intermediateScript(individual, featureAmt)
    % hh = vec2mat(individual, featureAmt+1);
    cols = length(individual) / (featureAmt+1);
    hh = reshape(individual,[cols,featureAmt+1]);
    rules = hh(:, 1:end-1);
    actions = hh(:, end);
end
