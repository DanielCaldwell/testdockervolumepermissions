# now we will mount the a volume from the host machine to the directory
# we created in the build file to see what the permissions are.
current_dir=$(pwd)
docker run --rm --name "testpermissions2" --volume "$current_dir/testdata:/testmadeinbuild" testpermissions

