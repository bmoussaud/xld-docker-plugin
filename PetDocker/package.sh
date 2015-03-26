#!/bin/sh
$(docker-machine env dev-machine)
VERSION=$1
echo "Buid Version $VERSION"
docker build -t petdocker/petdocker-app:$VERSION petclinic
docker build -t petdocker/petdocker-backend-app:2.0 petclinic-backend
sed -e "s/##VERSION##/$VERSION/g"   ./template/deployit-manifest.xml > ./dar/deployit-manifest.xml
jar cvf PetDocker-$VERSION.dar -C dar .