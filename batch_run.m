% this script runs and saves data

num_iterations = 1;
datadir = '/home/2007/kbrown53/pigdata/';
dataname = 'test';
for i = 1:num_iterations
  latticeRun
  data_files = dir(datadir);
  save_num = size(data_files,1)-1;
  save([datadir,dataname,sprintf('%04d',save_num)]);
end

exit