# now we will mount a volume from another docker container. So we create another docker container, which 
# will hold the volumes. this will be a data container, then we will mount the volumes from the data container
# to our container

# in this example, we use the same type of container as we are running, so they should have similar
# directory structures

current_dir=$(pwd)

docker run --name "testdatacontainer" --volume "$current_dir/testdata:/testmadeinbuild" testpermissions

docker run --rm --name "testpermissions" --volumes-from testdatacontainer testpermissions

docker rm -v testdatacontainer
