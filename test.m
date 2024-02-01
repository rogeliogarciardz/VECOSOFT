% load fisheriris; 
  3
% Combine the four features into a matrix 
% X = [meas(:,1), meas(:,2), meas(:,3), meas(:,4)]; 
  
% Apply k-means clustering with k=3 
k = 2; 
[idx, centroids] = kmeans(X, k); 
  
% Plot the results 
figure; 
gscatter(X(:,1), X(:,2), idx, 'bgr', '.', 10); 
hold on; 
plot(centroids(:,1), centroids(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3); 
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids'); 
title('K-Means Clustering Results'); 
xlabel('Sepal Length'); 
ylabel('Sepal Width'); 


% % Generate random data 
% rng(1); 
% X = [randn(100,2)*0.75+ones(100,2); randn(100,2)*0.5-ones(100,2)]; 
% 
% % Apply k-means clustering with k=2 
% k = 2; 
% [idx, centroids] = kmeans(X, k); 
% 
% % Plot the results 
% figure; 
% gscatter(X(:,1), X(:,2), idx, 'bgr', '.', 10); 
% hold on; 
% plot(centroids(:,1), centroids(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3); 
% legend('Cluster 1', 'Cluster 2', 'Centroids'); 
% title('K-Means Clustering Results'); 
% xlabel('X1'); 
% ylabel('X2'); 

% data_km_1=[data_km.Mediana(:),data_km.Promedio(:),data_km.Moda(:),data_km.Rango(:),data_km.Desviacion(:),data_km.Minimos(:),data_km.Maximos(:),data_km.Mad(:)];

