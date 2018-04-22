function [rules, actions, hh] = intermediateScript(individual, featureAmt)
    % hh = vec2mat(individual, featureAmt+1);
    cols = length(individual) / (featureAmt+1);
    hh = reshape(individual,[featureAmt+1,cols])';
    rules = hh(:, 1:end-1);
    actions = hh(:, end);
end
