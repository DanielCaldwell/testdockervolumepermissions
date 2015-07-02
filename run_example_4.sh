# now we will mount a volume from another docker container. So we create another docker container, which 
# will hold the volumes. this will be a data container, then we will mount the volumes from the data container
# to our container

# The data container is not the same kind of container as our test container is as it is only holding
# volumes and doesn't need anything else. At least, that's what our hypothesis says. 

current_dir=$(pwd)

docker run --name "testdatacontainer" --volume "$current_dir/testdata:/testmadeinbuild" ubuntu:14.04

echo "Checking directories in the data container"

docker run --rm --name "testpermissions" --volumes-from testdatacontainer ubuntu:14.04 ls -larh /testmadeinbuild

docker run --rm --name "testpermissions" --volumes-from testdatacontainer ubuntu:14.04 ls -larh /


echo "Checking directories in our running process container"

docker run --rm --name "testpermissions" --volumes-from testdatacontainer testpermissions

docker rm -v testdatacontainer
