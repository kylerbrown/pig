function [ adjmx ] = adjList2Mx(adjlist)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = numel(adjlist);
adjmx = zeros(n);
for i=1:n
    adjmx(i,adjlist{i})=1;
end

