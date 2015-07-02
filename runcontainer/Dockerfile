FROM ubuntu:14.04

# first add a user
RUN groupadd --gid 2342342 testuser
RUN useradd testuser -u 2342342 -g testuser

# make a directory
RUN mkdir /testmadeinbuildunchanged

# next add a directory
RUN mkdir /testmadeinbuild

# add a file into the directory
RUN touch /testmadeinbuild/testfilemadeinbuild

# change the owner of that directory to the testuser that we added earlier
RUN chown -R testuser:testuser /testmadeinbuild

# switch to that user
USER testuser

# run the command as that user
CMD ls -larh /testmadeinbuild && ls -larh /

