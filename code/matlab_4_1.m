m=3.6;g=9.81;   %鼓质量、重力大小
Moi=0.0832057;  %转动惯量
k=sin(24*pi/180)/sin(12*pi/180)
cord_length=2;   %绳子长度
drop=0.11;  %相较绳子水平时下落高度
distance=radius+sqrt(cord_length^2-drop^2) %队员们手握绳子处与原点的水平距离
step=12:36:360
step=step*pi/180
R1=[    %坐标系中，各个队员手握绳子处坐标，为简化模型、方便计算，此坐标下，发力状态以x、z轴平面对称
    distance*cos(step(10)),distance*sin(step(10)),0.11;
    distance*cos(step(1)),distance*sin(step(1)),0.11;
   distance*cos(step(2)),distance*sin(step(2)),0.11;
    distance*cos(step(3)),distance*sin(step(3)),0.11;
    distance*cos(step(4)),distance*sin(step(4)),0.11;
     distance*cos(step(5)),distance*sin(step(5)),0.11;
    distance*cos(step(6)),distance*sin(step(6)),0.11;
     distance*cos(step(7)),distance*sin(step(7)),0.11;
     distance*cos(step(8)),distance*sin(step(8)),0.11;
    distance*cos(step(9)),distance*sin(step(9)),0.11;
    ]

Fmax=100;
Fmin=21.72;%因鼓存在重力，经计算得到的最小值。
dF=Fmax-Fmin;
while(dF>0.001)
    y=-0.5*pi/180;
    omega=0;   %向上运动的速度
    vgu=0;
    mass=[0,0,0];
    Fc=(Fmax+Fmin)/2
    Ft=[Fc,k*Fc,64.2,64.2+12.747,64.2,64.2,64.2,64.2,64.2,64.2];
    for t=0:1:1000
        R2=[
        0.2*cos(step(10)),0.2*sin(step(10)),0.2*cos(step(10))*sin(y);
        0.2*cos(step(1)),0.2*sin(step(1)),0.2*cos(step(1))*sin(y);
        0.2*cos(step(2)),0.2*sin(step(2)),0.2*cos(step(2))*sin(y);
        0.2*cos(step(3)),0.2*sin(step(3)),0.2*cos(step(3))*sin(y);
        0.2*cos(step(4)),0.2*sin(step(4)),0.2*cos(step(4))*sin(y);
        0.2*cos(step(5)),0.2*sin(step(5)),0.2*cos(step(5))*sin(y);
        0.2*cos(step(6)),0.2*sin(step(6)),0.2*cos(step(6))*sin(y);
        0.2*cos(step(7)),0.2*sin(step(8)),0.2*cos(step(7))*sin(y);
        0.2*cos(step(8)),0.2*sin(step(8)),0.2*cos(step(8))*sin(y);
        0.2*cos(step(9)),0.2*sin(step(9)),0.2*cos(step(9))*sin(y);];

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
    
        m=omega*0.0001+u*(0.0001)^2/2;
        omega=omega+u*0.0001;
        y=y+m;
    end
y=y*180/pi;
if y>0.5
    Fmax=Fc;
else
    Fmin=Fc;
end
dF=Fmax-Fmin;
end
Fc;
k*Fc;
