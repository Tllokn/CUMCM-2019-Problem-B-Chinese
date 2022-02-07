m=3.6;g=9.81;   %鼓质量、重力加速度
Moi=0.0832057;  %转动惯量
Ft=[90,80,80,80,80,80,80,80];  %本次发力参数，
mass=[0,0,0];   %质心初始位置
cord_length=1.7;   %绳长
drop=0.11;  %鼓面距绳水平高度
distance=radius+sqrt(cord_length^2-drop^2); %队员握绳处距质心处水平距离
R1=[    %为便于计算，发力状态对称于xoy平面，所以根据不同的发力参数，需要确定不同的R1，为手握绳处到原点的矢量
    distance,0,drop;
    distance/sqrt(2),distance/sqrt(2),drop;
    0,distance,drop;
    -distance/sqrt(2),distance/sqrt(2),drop;
    -distance,0,drop;
     -distance/sqrt(2),-distance/sqrt(2),drop;
    0,-distance,drop;
     distance/sqrt(2),-distance/sqrt(2),drop;
    ];
j=0.2/sqrt(2);
y=0;   %初始旋转角度
omega=0;   %初始角速度
vgu=[0,0,0]; %鼓在受力过程中的速度
for t=0:1:1000
    R2=[ %鼓边各点到质心初始位矢
    0.2,0,0.2*sin(y);
    j,j,j*sin(y);
    0,0.2,0;
    -j,j,-j*sin(y);
    -0.2,0,-0.2*sin(y);
    -j,-j,-j*sin(y);
    0,-0.2,0;
    j,-j,j*sin(y);];
 
    m=[cos(y),1,1];
    L=R2.*m; %旋转y弧度情况下，鼓边各点到质心位矢
    r=L+mass;%鼓边各点相对原点位矢
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
    
    m=omega*0.0001+u*(0.0001)^2/2;
    omega=omega+u*0.0001;
    y=y+m;
end
y=y*180/pi
