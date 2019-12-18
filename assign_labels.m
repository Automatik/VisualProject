function imds = assign_labels(imdsSource, imdsTarget)
    sourceFiles = imdsSource.Files;
    targetFiles = imdsTarget.Files;
    targetLabels = cellstr(imdsTarget.Labels);
    
    labels = cell(size(sourceFiles,1),1);
    count = 1;
    
    for ii = 1:size(sourceFiles,1)
        filename = sourceFiles{ii,1};
        pos = find(strcmp(targetFiles,filename),1);
        labels{count,1} = targetLabels{pos,1};
        count = count + 1;
    end
    imds = imageDatastore(sourceFiles,'Labels',categorical(labels));
end