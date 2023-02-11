# Start from base image (built on Docker host)
FROM coder-base:v1.4

# Install everything as root
USER root

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y yarn

# Set back to coder user
USER coder
