b = offread('F:\ModelNet10\sofa\test\sofa_0681.off');
a=b{4,1};
x=a(1,:);
y=a(2,:);
z=a(3,:);
figure();
scatter3(x,y,z,'.'); 