FROM jenkins/jnlp-slave

USER root

# Install packages.
# Install packages.
RUN apt-get update
RUN apt-get install -y \
	git \
	curl \
	wget \
	gnupg2 \
	ca-certificates \
	lsb-release \
	apt-transport-https \
	software-properties-common

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt-get update

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash

RUN apt-get install -y \
	php7.1-common \
	php7.1-fpm \
	php7.1-cli \
	php7.1-curl \
	php7.1-mbstring \
	php7.1-xml \
	php7.1-gd \
	ruby \
	ruby-dev \
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
RUN npm install -g bower gulp gulp-cli yarn

# Install n
RUN npm install -g n
RUN n 7.2.1
RUN ln -sf /usr/local/n/versions/node/7.2.1/bin/node /usr/bin/node

RUN git config --global user.email "info@activelamp.com" && git config --global user.name "Jenkins CI"