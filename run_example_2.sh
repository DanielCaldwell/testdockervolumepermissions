# now we will mount the a volume from the host machine to the directory

current_dir=$(pwd)
docker run --rm --name "testpermissions2" --volume "$current_dir/testdata:/testmountedatrun" testpermissions
docker run --rm --name "testpermissions2" --volume "$current_dir/testdata:/testmountedatrun" testpermissions ls -larh /testmountedatrun

