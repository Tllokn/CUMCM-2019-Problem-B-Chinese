m=3.6;g=9.81;   %���������������ٶ�
Moi=0.0832057;  %ת������
Ft=[90,80,80,80,80,80,80,80];  %���η���������
mass=[0,0,0];   %���ĳ�ʼλ��
cord_length=1.7;   %����
drop=0.11;  %�������ˮƽ�߶�
distance=radius+sqrt(cord_length^2-drop^2); %��Ա�����������Ĵ�ˮƽ����
R1=[    %Ϊ���ڼ��㣬����״̬�Գ���xoyƽ�棬���Ը��ݲ�ͬ�ķ�����������Ҫȷ����ͬ��R1��Ϊ����������ԭ���ʸ��
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
y=0;   %��ʼ��ת�Ƕ�
omega=0;   %��ʼ���ٶ�
vgu=[0,0,0]; %�������������е��ٶ�
for t=0:1:1000
    R2=[ %�ı߸��㵽���ĳ�ʼλʸ
    0.2,0,0.2*sin(y);
    j,j,j*sin(y);
    0,0.2,0;
    -j,j,-j*sin(y);
    -0.2,0,-0.2*sin(y);
    -j,-j,-j*sin(y);
    0,-0.2,0;
    j,-j,j*sin(y);];
 
    m=[cos(y),1,1];
    L=R2.*m; %��תy��������£��ı߸��㵽����λʸ
    r=L+mass;%�ı߸������ԭ��λʸ
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
