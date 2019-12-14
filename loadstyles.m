function [imagesIds, gender, masterCategory, subCategory, ...
    articleType, baseColour, season] = loadstyles()

    stylesTable = readtable('styles.xlsx','FileType','spreadsheet','Range','A:I');
    imagesIds = stylesTable.('id');
    gender = stylesTable.('gender');
    masterCategory = stylesTable.('masterCategory');
    subCategory = stylesTable.('subCategory');
    articleType = stylesTable.('articleType');
    baseColour = stylesTable.('baseColour');
    season = stylesTable.('season');
end

