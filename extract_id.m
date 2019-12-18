function imagesIds = extract_id(files)
    imagesIds = zeros(size(files,1),1);
    j = 1;
    for ii = 1:size(files,1)
        filename = files{ii,1};
        start = find(filename == '\',1,'last');
        id = filename(start+1:(length(filename)-4));
        imagesIds(j,1) = str2double(id);
        j = j + 1;
    end
end