FROM n8nio/runners:latest
USER root

# Install packages
RUN cd /opt/runners/task-runner-javascript && pnpm add pdf-lib moment axios

# Update the allowlist in the launcher config
RUN sed -i 's/"NODE_FUNCTION_ALLOW_EXTERNAL": "[^"]*"/"NODE_FUNCTION_ALLOW_EXTERNAL": "pdf-lib,moment,axios"/' /etc/n8n-task-runners.json && \
    sed -i 's/"NODE_FUNCTION_ALLOW_BUILTIN": "[^"]*"/"NODE_FUNCTION_ALLOW_BUILTIN": "*"/' /etc/n8n-task-runners.json

USER runner
