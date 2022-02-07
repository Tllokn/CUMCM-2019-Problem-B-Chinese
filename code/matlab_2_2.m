m=3.6;
g=9.81;
Moi=0.0832057;
Ft=[90,90,80,80,80,80,80,80];
mass=[0,0,0];
radius=0.2;
cord_length=1.7;
drop=0.11;
distance=radius+sqrt(cord_length^2-drop^2);
cosd=cos(22.5*pi/180);
sind=sin(22.5*pi/180);
R1=[
    distance*cosd,-distance*sind,drop;
    distance*cosd,distance*sind,drop;
    distance*sind,distance*cosd,drop;
    -distance*sind,distance*cosd,drop;
    -distance*cosd,distance*sind,drop;
     -distance*cosd,-distance*sind,drop;
    -distance*sind,-distance*cosd,drop;
     distance*sind,-distance*cosd,drop;
    ];
j=0.2/sqrt(2);
y=0;
v=0;
vgu=0;
for t=0:1:1000
    R2=[
    0.2*cosd,-0.2*sind,0.2*sin(y);
    0.2*cosd,0.2*sind,0.2*sin(y);
    0.2*sind,0.2*cosd,0;
    -0.2*sind,0.2*cosd,-0.2*sin(y);
    -0.2*cosd,0.2*sind,-0.2*sin(y);
    -0.2*cosd,-0.2*sind,-0.2*sin(y);
    -0.2*sind,-0.2*cosd,0;
    0.2*sind,-0.2*cosd,0.2*sin(y);];
 
    m=[cos(y),1,1];
    L=R2.*m;
    r=L+mass;
    direction=(R1-r)./sum(abs(R1-r).^2,2).^(1/2);
    F=Ft'.*direction;
    
    z=cross(F,L);
    c=sum(z);
    A=c/Moi;
    u=A(2);
       
    Fs=sum(F);
    agu=Fs./3.6;
    agu(3)=agu(3)-g;
    mass=mass+vgu*0.0001+agu.*(0.0001)^2/2;
    vgu=vgu+agu*0.0001;
    
    m=v*0.0001+u*(0.0001)^2/2;
    v=v+u*0.0001;
    y=y+m;
end
y=y*180/pi


%3的Ft、R1、R2如下，其余按思路，基本都可由已有的1、2、3代码更改F或R1或R2推出，其余人在未发力时，力的大小经受力平衡计算，为68.2左右
%3：
% cosd=cos(22.5*pi/180);
% sind=sin(22.5*pi/180);
% Ft=[90,80,80,90,80,80,80,80];
% R1=[
%     distance*sind,-distance*cosd,drop;
%     distance*cosd,-distance*sind,drop;
%     distance*cosd,distance*sind,drop;
%     distance*sind,distance*cosd,drop;
%     -distance*sind,distance*cosd,drop;
%     -distance*cosd,distance*sind,drop;
%      -distance*cosd,-distance*sind,drop;
%     -distance*sind,-distance*cosd,drop; 
%     ]
% R2=[
%     0.2*sind,-0.2*cosd,0.2*sin(y);
%     0.2*cosd,-0.2*sind,0.2*sin(y);
%     0.2*cosd,0.2*sind,0.2*sin(y);
%     0.2*sind,0.2*cosd,0;
%     -0.2*sind,0.2*cosd,-0.2*sin(y);
%     -0.2*cosd,0.2*sind,-0.2*sin(y);
%     -0.2*cosd,-0.2*sind,-0.2*sin(y);
%     -0.2*sind,-0.2*cosd,0;
%    ]





