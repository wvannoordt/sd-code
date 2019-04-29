function [output] = custom_insertMarker(image,location, mcolor, size)
output = image;
vec1 = [(location(2) - size):(location(2) + size)];
vec2 = [(location(1) - size):(location(1) + size)];
vec1 = uint16(vec1);
vec2 = uint16(vec2);
output(vec1, vec2 ,1) = mcolor(1);
output(vec1, vec2 ,2) = mcolor(2);
output(vec1, vec2 ,3) = mcolor(3);
end

