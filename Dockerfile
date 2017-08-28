FROM jenkins:2.60.2

USER root

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash

# Install packages.
RUN apt-get update
RUN apt-get install -y \
	git \
	curl \
	php7.0-fpm \
	php7.0-cli \
	php7.0-curl \
	ruby \
	rubygems-integration \
	build-essential \
	libssl-dev \
	nodejs \
	rsync
RUN apt-get clean

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install Drush
RUN composer global require drush/drush:8.1.13
RUN cp -Rf /root/.composer /usr/share/composer
RUN ln -nsf /usr/share/composer/vendor/bin/drush /usr/local/bin/drush

# Install Bundler
RUN gem install bundler
RUN chown -R jenkins /var/lib/gems /usr/local/bin

# Install Bower
RUN npm install -g bower

# Install n
RUN npm install -g n
RUN n 7.2.1
RUN ln -sf /usr/local/n/versions/node/7.2.1/bin/node /usr/bin/node

RUN git config --global user.email "info@activelamp.com" && git config --global user.name "Jenkins CI"
