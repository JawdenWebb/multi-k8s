docker build -t jawdenwebb/multi-client:latest -t jawdenwebb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jawdenwebb/multi-server:latest -t jawdenwebb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jawdenwebb/multi-worker:latest -t jawdenwebb/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jawdenwebb/multi-client:latest  
docker push jawdenwebb/multi-server:latest  
docker push jawdenwebb/multi-worker:latest 
docker push jawdenwebb/multi-client:$SHA  
docker push jawdenwebb/multi-server:$SHA  
docker push jawdenwebb/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jawdenwebb/multi-server:$SHA 
kubectl set image deployments/client-deployment client=jawdenwebb/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=jawdenwebb/multi-worker:$SHA 