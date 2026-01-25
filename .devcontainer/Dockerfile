# Development container for Probot GitHub App
FROM node:18-alpine

# Install system dependencies
RUN apk add --no-cache \
    git \
    make \
    curl \
    bash \
    postgresql-client \
    redis \
    sudo

# Create non-root user with sudo access
ARG USERNAME=node
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set working directory
WORKDIR /workspace

# Switch to non-root user
USER $USERNAME

# Install global npm packages for development
RUN npm install -g npm@latest

# Set default shell to bash
ENV SHELL=/bin/bash

# Keep container running
CMD ["sleep", "infinity"]
