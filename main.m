clc;
clear;
%************AP个数与坐标***********
AP_Num=4;             %AP点个数
%FP_Num=45;            %指纹个数
Simu_Num=200;
APx=[0 30 0 30];
APy=[0 0 30 30];
ap_power=30;%dbm
ap_gain=10; %dbm
%************指纹个数与坐标**********
FP_Num=225;
fp_gain=10; %db
FPx=zeros(1,FP_Num);                   %指纹横轴坐标
FPy=zeros(1,FP_Num);                   %指纹纵轴坐标


index=1;                       %对指纹坐标进行初始化，四个角落没有指纹点，合理
for i=1:0.2:7
    for j=1:0.2:7
        if ~(i==1&&j==1||i==1&&j==7||i==7&&j==1||i==7&&j==7)
            FPx(1,index)=(j-1)*5;
            FPy(1,index)=(i-1)*5;
            %index
            index=index+1;
            
        end
    end
end
%fprintf('FPx=%f\n',FPx);
%fprintf('FPy=%f\n',FPy);
FPx
FPy

%*************指纹信号数据*************
%fp_power=zeros(FP_Num,AP_Num);
fp_power=ReceivePowerFun(APx,APy,FPx,FPy,ap_power,ap_gain,fp_gain);

%*************定位仿真数据*************
nn_cdf=zeros(1,51);
knn2_cdf=zeros(1,51);
knn3_cdf=zeros(1,51);
knn4_cdf=zeros(1,51);
wknn2_cdf=zeros(1,51);
wknn3_cdf=zeros(1,51);
wknn4_cdf=zeros(1,51);
bayes_cdf=zeros(1,51);
Kbayes_cdf=zeros(1,51);
Dbayes_cdf=zeros(1,51);

base_array=[0:0.1:5];
n=0;
nn_sum=0;
knn2_sum=0;
knn3_sum=0;
knn4_sum=0;
wknn2_sum=0;
wknn3_sum=0;
wknn4_sum=0;
bayes_sum=0;
Kbayes_sum=0;
Dbayes_sum=0;

while (n<Simu_Num)
    p_x=rand*30;              %待定位点坐标，0~30
    p_y=rand*30;
    %noise=randn;
    noise=normrnd(0,0);
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,1,1);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            nn_cdf(i)=nn_cdf(i)+1;
            %nn_cdf(i)=nn_cdf(i)+error;
           % fprintf('nn_cdf=%f\n',nn_cdf(i));
        end
    end
    nn_sum=nn_sum+error;

    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,2,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            knn2_cdf(i)=knn2_cdf(i)+1;
        end
    end
    knn2_sum=knn2_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,2,3);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            knn3_cdf(i)=knn3_cdf(i)+1;
        end
    end
    knn3_sum=knn3_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,2,4);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            knn4_cdf(i)=knn4_cdf(i)+1;
            %knn4_cdf(i)=knn4_cdf(i)+error;
           % fprintf('knn4_cdf=%f\n',knn4_cdf(i));
        end
    end
    knn4_sum=knn4_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,3,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            wknn2_cdf(i)=wknn2_cdf(i)+1;
        end
    end
    wknn2_sum=wknn2_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,3,3);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            wknn3_cdf(i)=wknn3_cdf(i)+1;
        end
    end
    wknn3_sum=wknn3_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,3,4);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            wknn4_cdf(i)=wknn4_cdf(i)+1;
            %wknn4_cdf(i)=wknn4_cdf(i)+error;
            %fprintf('wknn4_cdf=%f\n',wknn4_cdf(i));
        end
    end
    wknn4_sum=wknn4_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,4,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            bayes_cdf(i)=bayes_cdf(i)+1;
            %bayes_cdf(i)=bayes_cdf(i)+error;
           % fprintf('bayes_cdf=%f\n',bayes_cdf(i));
        end
    end
    bayes_sum=bayes_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,5,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            Kbayes_cdf(i)=Kbayes_cdf(i)+1;
            %bayes_cdf(i)=bayes_cdf(i)+error;
           % fprintf('bayes_cdf=%f\n',bayes_cdf(i));
        end
    end
    Kbayes_sum=Kbayes_sum+error;
    
    loc_point=FingerLocFun(APx,APy,FPx,FPy,fp_power,ap_power,ap_gain,fp_gain,p_x,p_y,noise,6,2);
    error=sqrt((loc_point(1)-p_x)*(loc_point(1)-p_x)+(loc_point(2)-p_y)*(loc_point(2)-p_y));
    for i=1:1:51
        if (error<base_array(i))
            Dbayes_cdf(i)=Dbayes_cdf(i)+1;
            %bayes_cdf(i)=bayes_cdf(i)+error;
           % fprintf('bayes_cdf=%f\n',bayes_cdf(i));
        end
    end
    Dbayes_sum=Dbayes_sum+error;
    
    n=n+1;
end
fprintf('nn=%f\n',nn_sum/Simu_Num);
fprintf('knn2=%f\n',knn2_sum/Simu_Num);
fprintf('knn3=%f\n',knn3_sum/Simu_Num);
fprintf('knn4=%f\n',knn4_sum/Simu_Num);
fprintf('wknn2=%f\n',wknn2_sum/Simu_Num);
fprintf('wknn3=%f\n',wknn3_sum/Simu_Num);
fprintf('wknn4=%f\n',wknn4_sum/Simu_Num);
fprintf('bayes=%f\n',bayes_sum/Simu_Num);

%plot(base_array,nn_cdf/Simu_Num,'g+-','LineWidth',2);
%hold on
%plot(base_array,knn2_cdf/Simu_Num,'k:x');
%hold on
plot(base_array,knn4_cdf/Simu_Num,'b*-','LineWidth',2);
hold on
%plot(base_array,wknn2_cdf/Simu_Num,'m--x');
%hold on
plot(base_array,wknn4_cdf/Simu_Num,'ro-','LineWidth',2);
hold on
plot(base_array,bayes_cdf/Simu_Num,'k.-','LineWidth',2);
hold on
plot(base_array,Kbayes_cdf/Simu_Num,'g+-','LineWidth',2);
hold on
plot(base_array,Dbayes_cdf/Simu_Num,'m*-','LineWidth',2);
hold on

%legend('nn','knn2','knn4','wknn2','wknn4','bayes');
legend('KNN','WKNN','Bayes','KBayes','DBayes','fontname','times new roman','fontSize',14);
xlabel('Error Distance (m)','fontname','times new roman','fontSize',18);
ylabel('CDF','fontname','times new roman','fontSize',18);
title('Samples number=50','fontname','times new roman','fontSize',20);