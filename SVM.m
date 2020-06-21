clear;
%örnek pdfte verilen noktalar dýþarýdan okundu.
data=dlmread('traindata1.txt');

train(:,1)=data(:,1);
train(:,2)=data(:,2);
B=data(:,3);%etiketleri alýndý.

%noktalar bu döngüyle sýnýflara ayrýldý.
z=0;m=0;
for l=1:size(train,1)
    if data(l,3)>0
        z=z+1;
        C1(z,:)=train(l,1:2);
    else
        m=m+1;
        C2(m,:)=train(l,1:2);
    end
end
data(:,3)=1;%kural gereði noktalarýn saðýna 1 eklendi.

%kuralda bulunan çarpým iþlemleri bu döngü sayesinde yapýldý.    
for i=1:size(data,1)
    for j=1:size(data,1)
    A(i,j)=data(j,:)*data(i,:)';
    end
end

alfa=pinv(A)*B;
for j=1:size(data,1)
    a(j)=alfa(j);
end
for i=1:size(data,1)
    W(i,:)=a(i)*data(i,:);
end

%w1,w2,w0 belirlenerek çizim yapýldý.
w1=sum(W(:,1));
w2=sum(W(:,2));
w0=sum(W(:,3));
w=[w1;w2;w0];
x=-1:0.1:4;
y=(-w1*x-w0)/w2;
plot(C1(:,1),C1(:,2),'r.','DisplayName','class1');
legend
hold on
plot(C2(:,1),C2(:,2),'b+','DisplayName','class2');
plot(x,y,'m')
axis([min(train(:,1))-1 max(train(:,1))+1 min(train(:,2))-1 max(train(:,2))+1])
grid