[imagesIds, gender, masterCategory, subCategory, ...
    articleType, baseColour, season] = loadstyles();

figure, h1 = histogram(categorical(gender));title('Gender');
figure, h2 = histogram(categorical(masterCategory));title('Master Category');
figure, h3 = histogram(categorical(subCategory));title('Sub Category');
figure, h4 = histogram(categorical(articleType));title('Article Type');
figure, h5 = histogram(categorical(baseColour));title('Base Colour');
figure, h6 = histogram(categorical(season));title('Season');

h = h1;
fprintf("\nGender: %d classes\n",size(h.Categories,2));
disp([char(h.Categories) num2str(h.Values.') repmat(' ',size(h.Categories,2),1) num2str((h.Values.')./sum(h.Values).*100)]);

h = h2;
fprintf("\nMaster Category: %d classes\n",size(h.Categories,2));
disp([char(h.Categories) num2str(h.Values.') repmat(' ',size(h.Categories,2),1) num2str((h.Values.')./sum(h.Values).*100)]);

h = h3;
fprintf("\nSub Category: %d classes\n",size(h.Categories,2));
disp([char(h.Categories) num2str(h.Values.') repmat(' ',size(h.Categories,2),1) num2str((h.Values.')./sum(h.Values).*100)]);

h = h4;
fprintf("\nArticle Type: %d classes\n",size(h.Categories,2));
disp([char(h.Categories) num2str(h.Values.') repmat(' ',size(h.Categories,2),1) num2str((h.Values.')./sum(h.Values).*100)]);

h = h5;
fprintf("\nBase Colour: %d classes\n",size(h.Categories,2));
disp([char(h.Categories) num2str(h.Values.') repmat(' ',size(h.Categories,2),1) num2str((h.Values.')./sum(h.Values).*100)]);

h = h6;
fprintf("\nSeason: %d classes\n",size(h.Categories,2));
disp([char(h.Categories) num2str(h.Values.') repmat(' ',size(h.Categories,2),1) num2str((h.Values.')./sum(h.Values).*100)]);
