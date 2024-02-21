function[silhouettes]=get_silhouettes(alldistances,ident)
% Function that calculates silhouette scores for each neurons

% INPUTS: 
%   alldistances = distance to each centroid for each neuron returned by
%       the MATLAB kmeans function 
%   ident = identity of the cluster assigned to each neuron

% OUTPUTS: 
%   silhouettes = vector containing the silhouette score for each neuron

% Christian Potter- updated 2/5/2024


silhouettes=nan(size(alldistances,1),1);

for i= 1:size( alldistances,1)                                           % get silhouette score 
    if ident(i)==1            
        silhouettes(i)=(alldistances(i,2)-alldistances(i,1))/max(alldistances(i,[1 2]));
    elseif ident(i)==2
        silhouettes(i)=(alldistances(i,1)-alldistances(i,2))/max(alldistances(i,[1 2]));
    end
end

end


