docker build -t khoaln6/multi-client:latest -t khoaln6/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t khoaln6/multi-server:latest -t khoaln6/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t khoaln6/multi-worker:latest -t khoaln6/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push khoaln6/multi-client:latest
docker push khoaln6/multi-client:$SHA
docker push khoaln6/multi-server:latest
docker push khoaln6/multi-server:$SHA
docker push khoaln6/multi-worker:latest
docker push khoaln6/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=khoaln6/multi-server:$SHA
kubectl set image deployments/client-deployment client=khoaln6/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=khoaln6/multi-worker:$SHA