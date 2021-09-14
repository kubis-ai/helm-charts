docker build -f Dockerfile-base -t nathaliamdc/kernelgateway .
docker push nathaliamdc/kernelgateway

docker build -f Dockerfile-tensorflow -t nathaliamdc/kernelgateway:tensorflow .
docker push nathaliamdc/kernelgateway:tensorflow