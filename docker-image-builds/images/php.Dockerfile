# Start from base image (built on Docker host)
FROM coder-base:v1.4

# Install everything as root
USER root

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y yarn

# Install php and composer
RUN sudo apt install -y software-properties-common
RUN sudo add-apt-repository ppa:ondrej/php
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y php8.1 php8.1-cli php8.1-common php8.1-opcache php8.1-mcrypt php8.1-gd php8.1-curl php8.1-mysql php8.1-xml php8.1-mbstring
RUN sudo apt install 


RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig` && php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Set back to coder user
USER coder
