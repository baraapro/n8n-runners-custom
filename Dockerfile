FROM n8nio/runners:latest
USER root

# The base image ships a standalone pnpm binary (/usr/local/bin/pnpm, pnpm 12+)
# and no longer includes npm or corepack, so use it directly.
#
# --ignore-scripts: pnpm 12 fails with ERR_PNPM_IGNORED_BUILDS on any unapproved
# build scripts in the tree (isolated-vm, ssh2, @sentry/* from the base image,
# which are already built). pdf-lib, moment and axios have no build scripts.
RUN cd /opt/runners/task-runner-javascript && \
    pnpm add pdf-lib moment axios --ignore-scripts

# Update the allowlist in the launcher config
RUN sed -i 's/"NODE_FUNCTION_ALLOW_EXTERNAL": "[^"]*"/"NODE_FUNCTION_ALLOW_EXTERNAL": "pdf-lib,moment,axios"/' /etc/n8n-task-runners.json && \
    sed -i 's/"NODE_FUNCTION_ALLOW_BUILTIN": "[^"]*"/"NODE_FUNCTION_ALLOW_BUILTIN": "*"/' /etc/n8n-task-runners.json && \
    grep -q '"NODE_FUNCTION_ALLOW_EXTERNAL": "pdf-lib,moment,axios"' /etc/n8n-task-runners.json

USER runner
