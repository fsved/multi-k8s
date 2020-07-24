docker build -t fsved/std-complex_client:latest -t fsved/std-complex_client:$SHA -f ./client/Dockerfile ./client
docker build -t fsved/std-complex_server:latest -t fsved/std-complex_server:$SHA -f ./server/Dockerfile ./server
docker build -t fsved/std-complex_worker:latest -t fsved/std-complex_worker:$SHA -f ./worker/Dockerfile ./worker
docker push fsved/std-complex_client:latest
docker push fsved/std-complex_server:latest
docker push fsved/std-complex_worker:latest

docker push fsved/std-complex_client:$SHA
docker push fsved/std-complex_server:$SHA
docker push fsved/std-complex_worker:$SHA
kubectl apply -f k8s # executes before deploy image assignment ??
kubectl set image deployments/server-deployment server=fsved/std-complex_server:$SHA
kubectl set image deployments/client-deployment client=fsved/std-complex_client:$SHA
kubectl set image deployments/worker-deployment worker=fsved/std-complex_worker:$SHA
