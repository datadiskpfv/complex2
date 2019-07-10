docker build -t datadiskpfv/multi-client:latest -t datadiskpfv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t datadiskpfv/multi-server:latest -t datadiskpfv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t datadiskpfv/multi-worker:latest -t datadiskpfv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push datadiskpfv/multi-client:latest
docker push datadiskpfv/multi-server:latest
docker push datadiskpfv/multi-worker:latest

docker push datadiskpfv/multi-client:$SHA
docker push datadiskpfv/multi-server:$SHA
docker push datadiskpfv/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=datadiskpfv/multi-server:$SHA
kubectl set image deployments/client-deployment server=datadiskpfv/multi-client:$SHA
kubectl set image deployments/worker-deployment server=datadiskpfv/multi-worker:$SHA

