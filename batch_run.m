% this script runs and saves data

num_iterations = 1;

for i = 1:num_iterations
  latticeRun
  data_files = ls('../pigdata');
  save_num = size(data_files,1)+1;
  save(['../pigdata/data_',sprintf('%04d',save_num)])
end

exit