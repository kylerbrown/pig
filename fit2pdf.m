function pdf = fit2pdf( fitnesses, w)
%FIT2PDF
% fitnesses - the n-by-1 matrix of fitnesses
% w - the selection strength
% returns a probability density function

if (nargin < 2) || isempty(w), %set the default w
    if ~sum(fitnesses <= 0), %if all fitnesses are non-zero then inf-w
        pdf = fitnesses/sum(fitnesses);
    else
        w = 1/abs(min(fitnesses));
        pdf = (1 + w*fitnesses)/(length(fitnesses) + w*sum(fitnesses));
    end;
else
    pdf = (1 + w*fitnesses)/(length(fitnesses) + w*sum(fitnesses));
end;

end
