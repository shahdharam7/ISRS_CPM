function [cov_ED]=CPM(Y,n)

%Data Size
[Bands,num] = size(Y);

for i=1:1:Bands
    for j=(i+1):1:Bands
        n_x1=i;
        n_y1=j;
        x1=Y(n_x1,:)';
        y1=Y(n_y1,:)';
        vi = convhull(x1,y1);
        ar(i,j) = polyarea(x1(vi),y1(vi));
    end
end
[q1,q2]=max(ar);
[q3,q4]=max(q1);
n_y1=q2(q4);
n_x1=q4;
x1=Y(n_x1,:)';
y1=Y(n_y1,:)';
vi = convhull(x1,y1);
ar(i,j) = polyarea(x1(vi),y1(vi));

p11=[x1,y1];
[m1,n1]=size(vi);
if(m1<=n)
    for i=0:0.01:1
        conv_points = boundary(p11,i);
        [m1,n1]=size(conv_points);
        if(m1>n)
            break
        end
    end
    cov_ED=conv_points;
   

else
    cov_ED=vi;
end
k11=cov_ED;
 z=(size(cov_ED)-1);
    for i=1:z(1)
        [t1]=p11(cov_ED(i),:);
        [t2]=p11(cov_ED(i+1),:);
        dist(i,1)=sqrt(sum((t1-t2).^2));
    end
    e=[p11(cov_ED),p11(cov_ED,2)];
    e(end,:)=[];
    cov_ED(end,:)=[];

        [m1,n1]=size(cov_ED);
    for k=1:1:(m1-n)
        [d1,d2]=min(dist);
        e(d2,:)=[];
        dist(d2,:)=[];
        cov_ED(d2,:)=[];
    end
end