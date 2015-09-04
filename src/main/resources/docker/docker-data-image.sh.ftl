cp ${deployed.file.path} docker/volume
echo "....."
find .
echo "....."

cat docker/volume/Dockerfile

echo "Docker Build Data Image"
echo docker build -t ${deployed.name} docker/volume
docker build -t ${deployed.name} docker/volume

