function pdf = fit2pdf( fitnesses, w)
%FIT2PDF
% fitnesses - the n-by-1 matrix of fitnesses
% w - the selection strength
% returns a probability density function

if (min(fitnesses) == 0),
    threshold_w = -1/min(fitnesses);
else,
    threshold_w = 0;
end;

if (threshold_w > 0) && (w > threshold_w),
    'WARNING'
end;


if (nargin < 2) || isempty(w), %set the default w
    if ~sum(fitnesses < 0), %if all fitnesses are non-zero then inf-w
        if sum(fitnesses) == 0,
            pdf = (fitnesses + 1)/length(fitnesses);
        else
            pdf = fitnesses/sum(fitnesses);
        end;
    else
        w = 1/abs(min(fitnesses));
        pdf = (1 + w*fitnesses)/(length(fitnesses) + w*sum(fitnesses));
    end;   
else
    pdf = (1 + w*fitnesses)/(length(fitnesses) + w*sum(fitnesses));
end;

if (min(pdf) < 0)
    'We fucked up'
    
end;

end

