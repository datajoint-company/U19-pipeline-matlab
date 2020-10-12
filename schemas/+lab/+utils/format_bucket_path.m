function format_dir = format_bucket_path(bucket_dir)

%If we are in spock already directory is the same
if u19_dj_utils.is_this_spock()
    format_dir = bucket_dir;
    return
end

%Get all path table from u19_lab.Path ("official sites")
[path_table] = lab.utils.get_path_table();

%Get OS of the system
system = u19_dj_utils.get_OS();

%Check the base dir corresponds to which global path
idx_basedir = cellfun(@(s) contains(bucket_dir, s), path_table.global_path);

path_record = path_table(idx_basedir & path_table.system == system,:);

if isempty(path_record)
    error('The base directory is not found in official sites of u19')
elseif size(path_record,1) > 1
    error('The base directory makes reference to more than one official location of the u19')
end

%Remove bucket "base" dir from path 
bucket_base_dir  = path_record.bucket_path{:};
extra_bucket_dir = strrep(bucket_dir,bucket_base_dir, '');


if ispc
    %For pc the accesible path is the net_location field
    baseDir  = path_record.net_location{:};
    
    %Correct extra bucket dir to adjust to windows style
    extra_bucket_dir = strep(extra_bucket_dir,'/','\');
    
else
    %For mac and linux the accesible path is the local_path field
    baseDir = path_record.local_path{:};
end

%Format the local directory 
format_dir = fullfile(baseDir, extra_bucket_dir);

end

