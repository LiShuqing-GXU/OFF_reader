function b = offread(filename)
% offread: read a file in OFF format
% b = offread(filename)
% See the documentation for a description of OFF format.
% OFF format was developed at the University of Minnesota
% Geometry Center.
fi = fopen(filename,'r');
if fi < 0
  error('File %s not found', filename)
end
lineco = 1;
x=fgetl(fi);
pos = isspace(x);
m = find(~pos);
if (isempty(m))
    line = '';
else
    line = x(m(1):m(length(m)));
end
lineco = lineco + 1;
if ~strcmpi(line, 'off')
  error('File must begin with keyword OFF')
end
a = sscanf(fgetl(fi), '%d %d %d');
lineco = lineco + 1;
if length(a) ~= 3
  error ('Second line of file must contain three integers')
end
numvtx = a(1);
numfacet = a(2);
numedge = a(3);
cplist = zeros(3,numvtx);
for vnum = 1 : numvtx
  coord = sscanf(fgetl(fi), '%e %e %e');
  if length(coord) ~= 3
    error('Each vertex line must contain three coordinates (error on line %d)', lineco)
  end
  lineco = lineco + 1;
  cplist(:,vnum) = coord;
end
count=1;
for fnum = 1 : numfacet
  li = fgets(fi);
  numv(:,count) = sscanf(li, '%d');
  if isempty(numv)
    error('Missing vertex count field in facet entry (line #%d)', lineco);
  end
  count=count+1;
end
b = cell({numvtx; numfacet; numedge; cplist; numv});