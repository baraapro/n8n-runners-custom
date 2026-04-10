FROM n8nio/runners:latest
USER root
RUN cd /opt/runners/task-runner-javascript && pnpm add pdf-lib moment axios
USER runner
