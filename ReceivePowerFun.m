function fp_power=ReceivePowerFun(APx,APy,FPx,FPy,ap_power,ap_gain,fp_gain);

[ap_r,ap_num]=size(APx);  %AP个数矩阵的行数和列数
[fp_r,fp_num]=size(FPx);  %指纹矩阵的行数和列数
fp_power=zeros(fp_num,ap_num);

for i=1:1:fp_num      
    for j=1:1:ap_num
        dis=sqrt((FPx(i)-APx(j))*(FPx(i)-APx(j))+(FPy(i)-APy(j))*(FPy(i)-APy(j)));
        loss_db=32.44+20*log10(2400)+20*log10(dis/1000); 
        fp_power(i,j)=ap_power+ap_gain+fp_gain-loss_db;
    end
end
fp_power