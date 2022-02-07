m=3.6;g=9.81;   %��������������С
Moi=0.0832057;  %ת������
k=sin(24*pi/180)/sin(12*pi/180)
cord_length=2;   %���ӳ���
drop=0.11;  %�������ˮƽʱ����߶�
distance=radius+sqrt(cord_length^2-drop^2) %��Ա���������Ӵ���ԭ���ˮƽ����
step=12:36:360
step=step*pi/180
R1=[    %����ϵ�У�������Ա�������Ӵ����꣬Ϊ��ģ�͡�������㣬�������£�����״̬��x��z��ƽ��Գ�
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
Fmin=21.72;%��Ĵ���������������õ�����Сֵ��
dF=Fmax-Fmin;
while(dF>0.001)
    y=-0.5*pi/180;
    omega=0;   %�����˶����ٶ�
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
