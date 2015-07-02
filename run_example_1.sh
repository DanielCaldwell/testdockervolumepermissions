# This is a test that checks the permissions of a folder and file created in the build script. 
# No volumes are used.
docker build -t "testpermissions" .
docker run --rm --name "testpermissions" testpermissions

