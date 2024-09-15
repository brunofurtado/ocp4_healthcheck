FROM registry.redhat.io/ansible-automation-platform/ee-minimal-rhel8:2.17.3-1

RUN mkdir -p /playbook/.kube /report-dir/{healthcheck report}  && curl https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz --output openshift-client-linux.tar.gz  && tar -xzvf openshift-client-linux.tar.gz && rm openshift-client-linux.tar.gz kubectl && mv oc /usr/bin/ && chmod -R 775 /playbook/ 

ADD playbook/ocp4_cluster_full_healthcheck /playbook/ocp4_cluster_full_healthcheck
ADD playbook/healthcheck.yaml /playbook

# ENV DEST_DIR=/report_dir/healthcheck 

WORKDIR /playbook/

ENTRYPOINT [ "ansible-playbook","healthcheck.yaml" ]
