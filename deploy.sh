docker build -t tahanyc/multi-client:latest -t tahanyc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tahanyc/multi-server:latest -t tahanyc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tahanyc/multi-worker:latest -t tahanyc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tahanyc/multi-client:latest
docker push tahanyc/multi-server:latest
docker push tahanyc/multi-worker:latest

docker push tahanyc/multi-client:$SHA
docker push tahanyc/multi-server:$SHA
docker push tahanyc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tahanyc/multi-server:$SHA
kubectl set image deployments/client-deployment client=tahanyc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tahanyc/multi-worker:$SHA

