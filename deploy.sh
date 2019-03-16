docker build -t saintzst/multi-client:latest -t saintzst/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saintzst/multi-server:latest -t saintzst/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saintzst/multi-worker:latest -t saintzst/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push saintzst/multi-client:latest
docker push saintzst/multi-server:latest
docker push saintzst/multi-worker:latest

docker push saintzst/multi-client:$SHA
docker push saintzst/multi-server:$SHA
docker push saintzst/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saintzst/multi-server:$SHA
kubectl set image deployments/client-deployment client=saintzst/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saintzst/multi-worker:$SHA