Usage 
====

Local execution 
===

* The host directory must be configured with the context container_file_t .

__
~~~
# User and Password authentication
$ podman run -e OCP_USER=kubeadmin -e PASSWORD=password -e URL=api.crc.testing:6443 -e INSECURE="--insecure-skip-tls-verify" -v /home/user/RedHat/healthcheck/tmp:/tmp  localhost/healthcheck-playbook:latest

# Token authentication 
$ podman run -e TOKEN=$(oc whoami  -t) -e URL=api.crc.testing:6443 -e INSECURE="--insecure-skip-tls-verify" -v /home/user/RedHat/healthcheck/tmp:/tmp  localhost/healthcheck-playbook:latest
___
~~~
For insecure connection declare the var INSECURE with the value "--insecure-skip-tls-verify"
INSECURE="--insecure-skip-tls-verify"

OCP deployment
===

The necessary objects are in the openshift-objects directory. It's necessary to define some kind of volume persistence to be able to retrieve the reports at this momento. In the near future will be possible the send this report through email.

Is possible to make use of USER and PASSWORD or TOKEN to authenticate, choose the form that suits you better.

USER authentication
==
#Define the vars

URL

OCP_USER

PASSWORD
___



TOKEN authentication
==
#Define the vars

TOKEN

URL

___


ServiceAccount 
== 
NO VAR IS NEED


For insecure connection declare the var INSECURE with the value "--insecure-skip-tls-verify"
INSECURE="--insecure-skip-tls-verify"
