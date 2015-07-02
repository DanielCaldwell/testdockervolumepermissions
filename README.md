# testdockervolumepermissions
This repository is has examples of building docker containers which are using volumes and listing them to see the permissions of the folders and files in the volume.

The Dockerfile creates a machine that is very simple. It is based off of ubuntu and it will create a new user, named testuser, and a directory and a file in that directory. The file and directory are both owned by the testuser. Note that the user and group are created independently. This is because I was testing on a machine where the UID and GID of the test user matched a user on the host vagrant machine. In otherwords I was running it on a vagrant machine as the vagrant user who had a uid of 1000, and a gid of 1000. Then when I ran the docker machine, the testuser had a uid of 1000 and a gid of 1000. Thus when mounting volumes if it used the uid and gid of the vagrant user, it would appear as the testuser in the docker machine. So I am creating them manually so they don't match. 


Example 1: No volumes being mounted

In example 1, we create a docker container with no volumes and check the permissions. As we should see, it is owned by the test user and we see the file created during the build of the machine.

Example 2: A volume created when running, that has no matching folder in the docker container

In example 2, we see that the new folder is owned by a user with no name, it's represented as an ID, which happens to be the UID and GID of the user in the host machine running the docker container. So permissions of the folder in a docker container maintain the same permissions on the host machine. If the users don't match, then the permissions don't match.

Example 3: A volume created when running, that matches a folder in the docker container

In example 3, we see that the folder has overridden the existing folder. The file created during the build is gone and the file from the host machine is there. The permissions match that of the host machine as well. 

Example 4: A volume created in a docker container we use as a data container, and then mounted to the running docker container. The folder did not exist in the data container.

In this example, we get exactly what we had in example 3. The user id and the group id of the host container is carried into the data container, and then into the running docker container. 

Example 5: A volume created in a docker container we use as a data container, and then mounted to the running docker container. The folder DID exist in the data container, owned by testuser.

We get the same behavior as in Example 4. 

