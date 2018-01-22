%PSO�Ĳ���
clc;
close all;
clear;
c1 = 1.4944;     %c1  c2����ѧϰ����
c2 = 1.4944;
W_max = 0.9;
W_min = 0.4;
M = 100;         %PSO���ӽ�������  
num = 20;        %���������õ�������10�����е�������20�������������10��
up_a = 20;       %a���Ͻ磬a��ȡֵ��Χ��[1,up_a]֮����������
up_f_sum = 40;   %f1+f2���Ͻ磬f1\f2��ȡֵ��Χ��[1,up_f_sum-10]֮����������

v = zeros(num,3);
x = zeros(num,3);
lbest = zeros(num,3);
fit = zeros(num,1);

lbest_x = zeros(M,3);
gbest_x = zeros(M,3);
lbest_x_fit = zeros(M,1);
gbest_x_fit = zeros(M,1);
gbest_poi = [0,0,0];

%���ɳ�ʼ��Ⱥ
for i = 1:num
   temp_v = new_v();
   v(i,1) = temp_v(1);    v(i,2) = temp_v(2);   v(i,3) = temp_v(3);  
   temp_x = new_x(up_a,up_f_sum);
   x(i,1) = temp_x(1);    x(i,2) = temp_x(2);   x(i,3) = temp_x(3);
   lbest(i,1) = temp_x(1);    lbest(i,2) = temp_x(2);   lbest(i,3) = temp_x(3); %����ǰ���ӵ�����ֵ��ʼ��Ϊ���ӱ���
   
   fit(i) = fitness(temp_x);   %�������Ӷ�Ӧ����Ӧ��  
end
[fmin,I] = min(fit);           % �ҵ�fitness�е���Сֵ
lbest_x(1,1) = x(I,1); lbest_x(1,2) = x(I,2);   lbest_x(1,3) = x(I,3);         % ��ʼ����ÿ������ֵ��Ӧ�ĸ��塱
lbest_x_fit(1)=  10^30;        % ��ʼ����ÿ������ֵ��   

gbest_poi(1) = x(I,1); gbest_poi(2) = x(I,2);gbest_poi(3) = x(I,3);        
gbest_fit =  10^30;         
gbest_x(1,1) = gbest_poi(1); gbest_x(1,2) = gbest_poi(2);gbest_x(1,3) = gbest_poi(3);    % ��ʼ����ȫ������ֵ��Ӧ�����Ӹ��塱
gbest_x_fit(1) = gbest_fit;    % ��ʼ����ȫ������ֵ��
                       
%��ѭ��������fitness�����ʱ����ʹ����a,f1,f2�������������Խ���ʹ����������ͬʱ����
for t = 1:M    
    
    %����
    for i = 1:num-1
        for j =i+1:num
            if(fit(j)<fit(i))   %�������i����Ӧ��С�ڵ�ǰֵ���Ǿͽ���
                 temp1 = fit(i);  fit(i) = fit(j);  fit(j) = temp1; 
                 temp2_1 = x(i,1); x(i,1) = x(j,1); x(j,1) = temp2_1;
                 temp2_2 = x(i,2); x(i,2) = x(j,2); x(j,2) = temp2_2;
                 temp2_3 = x(i,3); x(i,3) = x(j,3); x(j,3) = temp2_3;
                    
                 temp3_1 = v(i,1); v(i,1) = v(j,1); v(j,1) = temp3_1;
                 temp3_2 = v(i,2); v(i,2) = v(j,2); v(j,2) = temp3_2;
                 temp3_3 = v(i,3); v(i,3) = v(j,3); v(j,3) = temp3_3;
                            
                 temp4_1 = lbest(i,1); lbest(i,1) = lbest(j,1); lbest(j,1) = temp4_1;
                 temp4_2 = lbest(i,2); lbest(i,2) = lbest(j,2); lbest(j,2) = temp4_2;
                 temp4_3 = lbest(i,3); lbest(i,3) = lbest(j,3); lbest(j,3) = temp4_3;                                         
            end            
        end        
    end
    
    %����ÿ�����ӵġ���ʷ����ֵ��
    for i = 1:num
        temp_lbest(1) = lbest(i,1); 
        temp_lbest(2) = lbest(i,2);
        temp_lbest(3) = lbest(i,3);
        
        if(fitness( temp_lbest) < fit(i)  )   %�����ǰ��¼�����Ÿ���û�С���ǰ���塱�ã��Ǿ͸���
            lbest(i,:) = x(i,:); 
        end
    end
    
    %��¼����������ֵ,����ǰ���Ѿ��Ź�����������ֱ��ȡ��һ���ͺá�
    lbest_x(t,1) = x(1,1);  lbest_x(t,2) = x(1,2); lbest_x(t,3) = x(1,3);   % ��¼����������ֵ��Ӧ�����Ӹ��塱
    lbest_x_fit(t) =   fit(1);         % ��¼����������ֵ��
    
    %����ȫ������ֵ,����ǰ���Ѿ��Ź�����������ֱ��ȡ��һ���ͺá�
    if(lbest_x_fit(t)<gbest_fit )
        gbest_fit = lbest_x_fit(t);   %����ȫ������ֵ
        gbest_poi(1) = lbest_x(t,1); 
        gbest_poi(2) = lbest_x(t,2);
        gbest_poi(3) = lbest_x(t,3);  %����ȫ������ֵ��Ӧ������
    end 
    gbest_x_fit(t) = gbest_fit;       % ��ʼ����ȫ������ֵ��
    gbest_x(t,1) = gbest_poi(1); 
    gbest_x(t,2) = gbest_poi(2);
    gbest_x(t,3) = gbest_poi(3);      % ��ʼ����ȫ������ֵ��Ӧ�����Ӹ��塱
    
    
    %�á��С�������ӵ�������
    num_good = num * 0.25;
    num_mid = num * 0.5;
    num_bad = num * 0.25;
        
    
    %��������������
    %�õ�����    
    for i1 = 1:num_good
        r1_1 = rand;                          %r1_1��[0,1]֮��������
        W_better = 0.5 + sqrt(0.3)*randn ;    %��0.5Ϊ��ֵ��0.3Ϊ����������̬�ֲ�    
        v(i1,1) = round( W_better*v(i1,1) + c1*r1_1*( lbest(i1,1)  - x(i1,1) )   ); %��������ȡ�� 
        v(i1,2) = round( W_better*v(i1,2) + c1*r1_1*( lbest(i1,2)  - x(i1,2) )   ); %��������ȡ�� 
        v(i1,3) = round( W_better*v(i1,3) + c1*r1_1*( lbest(i1,3)  - x(i1,3) )   ); %��������ȡ�� 
        x(i1,1) = x(i1,1) + v(i1,1);
        x(i1,2) = x(i1,2) + v(i1,2);
        x(i1,3) = x(i1,3) + v(i1,3);
      %  legal(x(i1,1),x(i1,2),x(i1,3));  %����Ƿ�Խ�磬���Խ�磬��Խ�粿����Ϊ�߽�ֵ
        
        if(x(i1,1)<1)  
            x(i1,1) = 1;  end
        if(x(i1,1)>up_a)  
            x(i1,1) = up_a;  end
        if(rand<=0.5)
            if(x(i1,2)<10) 
                x(i1,2) = 10; end
            if(x(i1,2)>up_f_sum-10) 
                x(i1,2) = up_f_sum-10; end 
            if(x(i1,3)<10) 
                x(i1,3) = 10; end 
            if(x(i1,3)>up_f_sum-x(i1,2)) 
                x(i1,3) = up_f_sum-x(i1,2);end %f2��f1��Լ��
        else            
            if(x(i1,3)<10) 
                x(i1,3) = 10; end
            if(x(i1,3)>up_f_sum-10) 
                x(i1,3) = up_f_sum-10; end 
            if(x(i1,2)<10) 
                x(i1,2) = 10; end 
            if(x(i1,2)>up_f_sum-x(i1,3)) 
                x(i1,2) = up_f_sum-x(i1,3);end %f1��f2��Լ��             
        end

        %������������һ��Լ��������f1\f2���μ�1��ֱ������Լ��
        [T1,T2] = computer_T1_T2(x(i1,1));    
        count = round(rand*100);
        while(T1*x(i1,2)/3600 + T2*x(i1,3)/3600 > 41)          
            if(mod(count,2)==1 )
                if(x(i1,2)>1)  
                    x(i1,2) = x(i1,2) - 1; end 
                count = count + 1;
            else
                if(x(i1,3)>1) 
                    x(i1,3) = x(i1,3) - 1; end 
                count = count + 1;
            end        
        end    
        
        
    end
    
    %�е�����    
    %y_meand�ǵ�dά�������ӵ���ʷ���ŵ�ƽ��ֵ
    temp_sum_a = 0;
    temp_sum_f1 = 0;
    temp_sum_f2 = 0;
    for ii = 1:num
        temp_sum_a =  temp_sum_a + lbest(ii,1);
        temp_sum_f1 = temp_sum_f1 + lbest(ii,2);
        temp_sum_f2 = temp_sum_f2 + lbest(ii,3);
    end        
    y_meand.a = temp_sum_a / num;
    y_meand.f1 = temp_sum_f1 / num;
    y_meand.f2 = temp_sum_f2 / num;
    
    w = W_max - t/M*(W_max-W_min);        %����Ȩ��
    for i2 = num_good+1:num_good+num_mid
        r1_2 = rand;                          %r1  r2��[0,1]֮��������
        r2_2 = rand;
        v(i2,1) = round( w*v(i2,1) + c1*r1_2*( lbest(i2,1) - x(i2,1) ) + c2*r2_2*(y_meand.a -x(i2,1) )) ;
        v(i2,2) = round( w*v(i2,2) + c1*r1_2*( lbest(i2,2) - x(i2,2) ) + c2*r2_2*(y_meand.f1 -x(i2,2) )) ;
        v(i2,3) = round( w*v(i2,3) + c1*r1_2*( lbest(i2,3) - x(i2,3) ) + c2*r2_2*(y_meand.f2 -x(i2,3) )) ;
        x(i2,1) = x(i2,1) + v(i2,1);
        x(i2,2) = x(i2,2) + v(i2,2);
        x(i2,3) = x(i2,3) + v(i2,3);
    % legal(x(i2,1),x(i2,2),x(i2,3)); 
        if(x(i2,1)<1)  
            x(i2,1) = 1;  end
        if(x(i2,1)>up_a)  
            x(i2,1) = up_a;  end
        if(rand<=0.5)
            if(x(i2,2)<10) 
                x(i2,2) = 10; end
            if(x(i2,2)>up_f_sum-10) 
                x(i2,2) = up_f_sum-10; end 
            if(x(i2,3)<10) 
                x(i2,3) = 10; end 
            if(x(i2,3)>up_f_sum-x(i2,2)) 
                x(i2,3) = up_f_sum-x(i2,2);end %f2��f1��Լ��
        else            
            if(x(i2,3)<10) 
                x(i2,3) = 10; end
            if(x(i2,3)>up_f_sum-10) 
                x(i2,3) = up_f_sum-10; end 
            if(x(i2,2)<10) 
                x(i2,2) = 10; end 
            if(x(i2,2)>up_f_sum - x(i2,3)) 
                x(i2,2) = up_f_sum - x(i2,3);end %f2��f1��Լ��            
        end
        
        %������������һ��Լ��������f1\f2���μ�1��ֱ������Լ��
        [T1,T2] = computer_T1_T2(x(i2,1));    
        count = round(rand*100);
        while(T1*x(i2,2)/3600 + T2*x(i2,3)/3600 > 41)          
            if(mod(count,2)==1 )
                if(x(i2,2)>1)  
                    x(i2,2) = x(i2,2) - 1; end 
                count = count + 1;
            else
                if(x(i2,3)>1) 
                    x(i2,3) = x(i2,3) - 1; end 
                count = count + 1;
            end        
        end   
    
    
    end
    
    %�������
    for i3 = num_good+num_mid+1:num
        r1_3 = rand;                          %r1_3��[0,1]֮��������
        poi = round(rand * (num_good-1)) + 1; %����[1,num_good]֮����������
        v(i3,1) = round (c1*r1_3* (x(poi,1) - x(i3,1) ));
        v(i3,2) = round (c1*r1_3* (x(poi,2) - x(i3,2) )) ;
        v(i3,3) = round (c1*r1_3* (x(poi,3) - x(i3,3) )) ;
        x(i3,1) = x(i3,1) + v(i3,1);
        x(i3,2) = x(i3,2) + v(i3,2);
        x(i3,3) = x(i3,3) + v(i3,3);
%        legal(x(i3,1),x(i3,2),x(i3,3));            
        if(x(i3,1)<1)  
            x(i3,1) = 1;  end
        if(x(i3,1)>up_a)  
            x(i3,1) = up_a;  end
        
        if(rand<=0.5)            
            if(x(i3,2)<10) 
                x(i3,2) = 10; end
            if(x(i3,2)>up_f_sum-10) 
                x(i3,2) = up_f_sum-10; end 
            if(x(i3,3)<10) 
                x(i3,3) = 10; end 
            if(x(i3,3)>up_f_sum-x(i3,2)) 
                x(i3,3) = up_f_sum-x(i3,2);end %f2��f1��Լ��
        else
            if(x(i3,3)<10) 
                x(i3,3) = 10; end
            if(x(i3,3)>up_f_sum-10) 
                x(i3,3) = up_f_sum-10; end 
            if(x(i3,2)<10) 
                x(i3,2) = 10; end 
            if(x(i3,2)>up_f_sum-x(i3,3)) 
                x(i3,2) = up_f_sum-x(i3,3);end %f2��f1��Լ��
        end        

        %������������һ��Լ��������f1\f2���μ�1��ֱ������Լ��
        [T1,T2] = computer_T1_T2(x(i3,1));    
        count = round(rand*100);
        while(T1*x(i3,2)/3600 + T2*x(i3,3)/3600 > 41)          
            if(mod(count,2)==1 )
                if(x(i3,2)>1)  
                    x(i3,2) = x(i3,2) - 1; end 
                count = count + 1;
            else
                if(x(i3,3)>1) 
                    x(i3,3) = x(i3,3) - 1; end 
                count = count + 1;
            end        
        end           
    end
    
    %���½���������ӵ���Ӧ��
    for i4 = 1:num
        temp_xi4(1) = x(i4,1); temp_xi4(2) = x(i4,2); temp_xi4(3) = x(i4,3);
        fit(i4) = fitness(temp_xi4 ); 
    end
    
end

draw(lbest_x_fit,gbest_x_fit,gbest_x,M,up_a,up_f_sum);   %��ͼ
disp('the best result is:');               %�������ֵ
disp(gbest_x_fit(M));
disp('The corresponding solution are:');
disp(gbest_x(M,1)); 
disp(gbest_x(M,2));
disp(gbest_x(M,3));
