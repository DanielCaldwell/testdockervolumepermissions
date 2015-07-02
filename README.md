# Testing Docker Volume Permissions

This repository is has examples of building docker containers which are using volumes and listing them to see the permissions of the folders and files in the volume.

The Dockerfile creates an image that is very simple. It is based off of ubuntu and it will create a new user, named testuser, and a directory and a file in that directory. The file and directory are both owned by the testuser. It also creates an unchanged directory to test the default permissions of a directory created during the build of the image. 

Note that the user and group are created independently. This is because I was testing on a vagrant created virtual machine. My linux virtual machine's vagrant user had uid:gid of 1000:1000, which matched the testuser created in the docker image. This caused some confusion on my part when I was initially testing the permissions. So I am explicitly setting the user's group id and user id to be something that won't match an existing user on a host machine. 

## Example 1: No volumes being mounted, directories created during build

In example 1 we create two directories when building the docker image: 

```
/testmadeinbuild
/testmadeinbuildunchanged
```

Checking the permissions we find that directories made during the build of the docker container will have root:root as their permissions.  However, we can change permissions as needed.


## Example 2: Volume created using --volume, volume exists on host, no matching folder in the docker container

The volume folder is owned by a user with no name, it's represented as an ID, which happens to be the UID and GID of the user in the host machine running the docker container. So permissions of the folder in a docker container maintain the same permissions on the host machine. If the users don't match, then the permissions don't match.


## Example 3: Volume created using --volume, volume exists on host, folder exists in image

The host's folder has overridden the image's existing folder. The file created during the build is gone and the file from the host machine is there. The permissions match that of the host machine as well. 

## Example 4: Volume created in a data container bound to host folder, added using --volumes-from. The folder did not exist in the data container.

In this example, we get exactly what we had in example 3. The user id and the group id of the host container is carried into the data container, and then into the running docker container. 

## Example 5: Volume created in a data container bound to host folder, the folder does exist in the data container, owned by testuser.

We get the same behavior as in Example 4. The folder is overridden by the data container's permissions, which come from the host machine.


## Example 6: Volume is declared in a dockerfile, doesn't match anything in the run container

Instead of decaring it at runtime and mounting it to a host folder, we declare it in a dockerfile so it exists in the docker container, but not on the host. 
the permissions are for the root user. 

## Example 7: A volume is declared in a dockerfile, and does match a folder in the run container

The volume overrides the folder in the run docker container, and now has a permissions for root. 

## Example 8: A volume is declared in a dockerfile, run with a --volume to match the host when creating the data container, then added to the run container

The volume gets the user id and the group id of the user on the host machine. the --volume overrides the declared one in the dockerfile. 
