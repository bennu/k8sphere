ARG TF_VERSION
FROM hashicorp/terraform:${TF_VERSION}
ARG ANSIBLE_PLUGIN
ENV PLUGINS_DIR=/root/.terraform.d/plugins \
    ANSIBLE_PLUGIN=${ANSIBLE_PLUGIN}
RUN apk add --no-cache \
    curl \
    git \
    upx && \
    cd /bin/ && \
    upx --ultra-brute terraform && \
    mkdir -p $PLUGINS_DIR && \
    cd $PLUGINS_DIR && \
    wget https://github.com/radekg/terraform-provisioner-ansible/releases/download/v${ANSIBLE_PLUGIN}/terraform-provisioner-ansible-linux-amd64_v${ANSIBLE_PLUGIN} -O $PLUGINS_DIR/terraform-provisioner-ansible_v${ANSIBLE_PLUGIN} && \
    chmod +x $PLUGINS_DIR/terraform-provisioner-ansible_v${ANSIBLE_PLUGIN} && \
    upx --ultra-brute terraform-provisioner-ansible_v${ANSIBLE_PLUGIN} && \
    apk del upx && \
    rm -rf /var/cache/apk/* /tmp/* 
