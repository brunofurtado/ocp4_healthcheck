Usage 
====

Local execution 
===


~~~
#!/bin/bash
#
TOKEN=$(oc whoami -t)
URL="$(oc whoami --show-server)"
TLS=false
CLUSTER_ID=$(oc get clusterversion -o jsonpath='{.items[].spec.clusterID}{"\n"}')
LOCALDIR=/tmp/$CLUSTER_ID

function prepareDirectory() {
if [ ! -d $LOCALDIR ]; then
  mkdir $LOCALDIR
  chcon -Rt container_file_t $LOCALDIR
  restorecon -RvF $LOCALDIR
else
  chcon -Rt container_file_t $LOCALDIR
  restorecon -RvF $LOCALDIR
fi
}

function healthCheck() {
if [ "$TLS" = true ]; then
  podman run -e TOKEN=$TOKEN -e URL=$URL -v $LOCALDIR:/tmp quay.io/rhn_support_bfurtado/ocp4-healthcheck
else
  podman run -e TOKEN=$TOKEN -e URL=$URL -e INSECURE="--insecure-skip-tls-verify" -v $LOCALDIR:/tmp quay.io/rhn_support_bfurtado/ocp4-healthcheck
fi
}

function compactReport() {
echo ""
echo "Compacting the report ..."

tar czf $LOCALDIR/report.tgz $LOCALDIR/report

echo ""
echo "Report created! Please, share the $LOCALDIR/report.tgz ."
}


prepareDirectory
healthCheck
compactReport

~~~



* The host directory must be configured with the context container_file_t .

__
~~~
# User and Password authentication
$ podman run -e OCP_USER=kubeadmin -e PASSWORD=password -e URL=api.crc.testing:6443 -e INSECURE="--insecure-skip-tls-verify" -v /home/user/RedHat/healthcheck/tmp:/tmp  localhost/healthcheck-playbook:latest

# Token authentication 
$ podman run -e TOKEN=$(oc whoami  -t) -e URL=api.crc.testing:6443 -e INSECURE="--insecure-skip-tls-verify" -v /home/user/RedHat/healthcheck/tmp:/tmp  localhost/healthcheck-playbook:latest
___
~~~
For insecure connections declare the var INSECURE with the value "--insecure-skip-tls-verify"

INSECURE="--insecure-skip-tls-verify"

OCP deployment
===

The necessary objects for this script are in the openshift-objects directory. You should define some kind of volume persistence to be able to retrieve the reports at this moment.

It's possible to authenticate with combination of USERNAME and PASSWORD or TOKEN, choose the one that suits you better.

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


For insecure connections declare the var INSECURE with the value "--insecure-skip-tls-verify"

INSECURE="--insecure-skip-tls-verify"
