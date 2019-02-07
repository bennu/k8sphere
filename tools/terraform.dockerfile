ARG TF_VERSION
FROM hashicorp/terraform:${TF_VERSION}
ARG ANSIBLE_PLUGIN
ARG EXTERNAL_PLUGIN
ARG KUBECTL_VERSION
ARG LOCAL_PLUGIN
ARG VSPHERE_VERSION
ENV ANSIBLE_PLUGIN=${ANSIBLE_PLUGIN:-2.1.1} \
    EXTERNAL_PLUGIN=${EXTERNAL_PLUGIN:-1.0.0} \
    KUBECTL_VERSION=${KUBECTL_VERSION:-1.13.2} \
    KUSTOMIZE_VERSION=${KUSTOMIZE_VERSION:-1.0.11} \
    LOCAL_PLUGIN=${LOCAL_PLUGIN:-1.1.0} \
    VSPHERE_VERSION=${VSPHERE_VERSION:-1.9.1} \
    PLUGINS_DIR=/root/.terraform.d/plugins
RUN apk add --no-cache \
    ca-certificates && \
    update-ca-certificates && \
    apk add --no-cache \
    bash \
    curl \
    git \
    jq \
    openssh-client \
    sshpass \
    # upx \
    wget && \
    cd /bin/ && \
    # upx --best terraform && \
    wget https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    # upx --best kubectl && \
    wget https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 -O kustomize && \
    chmod +x kustomize && \
    # upx --best kustomize && \
    mkdir -p $PLUGINS_DIR && \
    cd $PLUGINS_DIR && \
    wget https://github.com/radekg/terraform-provisioner-ansible/releases/download/v${ANSIBLE_PLUGIN}/terraform-provisioner-ansible-linux-amd64_v${ANSIBLE_PLUGIN} -O $PLUGINS_DIR/terraform-provisioner-ansible_v${ANSIBLE_PLUGIN} && \
    chmod +x $PLUGINS_DIR/terraform-provisioner-ansible_v${ANSIBLE_PLUGIN} && \
    # upx --best terraform-provisioner-ansible_v${ANSIBLE_PLUGIN} && \
    wget https://releases.hashicorp.com/terraform-provider-external/${EXTERNAL_PLUGIN}/terraform-provider-external_${EXTERNAL_PLUGIN}_linux_amd64.zip && \
    unzip terraform-provider-external_${EXTERNAL_PLUGIN}_linux_amd64.zip && \
    # upx --best terraform-provider-external_v${EXTERNAL_PLUGIN}_x4 && \
    wget https://releases.hashicorp.com/terraform-provider-vsphere/${VSPHERE_VERSION}/terraform-provider-vsphere_${VSPHERE_VERSION}_linux_amd64.zip && \
    unzip terraform-provider-vsphere_${VSPHERE_VERSION}_linux_amd64.zip && \
    # upx --best terraform-provider-vsphere_v${VSPHERE_VERSION}_x4 && \
    # apk del upx && \
    wget https://releases.hashicorp.com/terraform-provider-local/${LOCAL_PLUGIN}/terraform-provider-local_${LOCAL_PLUGIN}_linux_amd64.zip && \
    unzip terraform-provider-local_${LOCAL_PLUGIN}_linux_amd64.zip && \
    rm -f *.zip && \
    rm -rf /var/cache/apk/* /tmp/*
