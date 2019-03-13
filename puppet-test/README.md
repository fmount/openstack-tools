puppet-unit tests for stable/queens
===

It's just an attempt to create a containerized environment used to run
tests or other stuff against puppet openstack modules.


Build the container:
---
Just build on your local environment the container:

    $ docker build -t fmount/tripleopp .

and run it:

    $ docker run -it --rm -v $(pwd):/openstack-puppet:z --workdir /openstack-puppet fmount/tripleopp ./puppet-test.sh

