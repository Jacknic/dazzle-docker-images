# run as root
BUILDKIT_VERSION=0.12.3
BUILDKIT_FILENAME=buildkit-v${BUILDKIT_VERSION}.linux-amd64.tar.gz
DAZZLE_VERSION=0.1.17
curl -sSL https://github.com/moby/buildkit/releases/download/v${BUILDKIT_VERSION}/${BUILDKIT_FILENAME} | tar -xvz -C /usr
curl -sSL https://github.com/gitpod-io/dazzle/releases/download/v${DAZZLE_VERSION}/dazzle_${DAZZLE_VERSION}_Linux_x86_64.tar.gz | tar -xvz -C /usr/local/bin
curl -sSL https://github.com/mvdan/sh/releases/download/v3.5.1/shfmt_v3.5.1_linux_amd64 -o /usr/bin/shfmt && chmod +x /usr/bin/shfmt
curl -sSL https://github.com/mikefarah/yq/releases/download/v4.22.1/yq_linux_amd64 -o /usr/bin/yq && chmod +x /usr/bin/yq