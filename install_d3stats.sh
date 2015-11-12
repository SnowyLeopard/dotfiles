#!/bin/bash

source `which virtualenvwrapper.sh`
# Install aptitude dependencies
sudo apt-get install libmysqlclient-dev npm libffi-dev libssl-dev memcached rabbitmq-server

# Install pypy
if [[ ! -d "/etc/pypy" ]]
then
    echo "********************"
    echo "Installing pypy"
    echo "********************"
    sudo mkdir -p /etc/pypy
    cd /etc/pypy
    sudo wget https://bitbucket.org/pypy/pypy/downloads/pypy-2.6.0-linux64.tar.bz2
    sudo tar -xjvf pypy-2.6.0-linux64.tar.bz2
    sudo rm pypy-2.6.0-linux64.tar.bz2
    sudo mv pypy-2.6.0-linux64/* .
    sudo rm pypy-2.6.0-linux64 -r
    sudo ln -s /etc/pypy/bin/pypy /usr/local/bin/pypy
else
    echo "********************"
    echo "Pypy already installed"
    echo "********************"
fi

# Create d3stats virtualenv
if [[ ! -d "$HOME/.virtualenvs/d3stats" ]]
then
    echo "********************"
    echo "Creating virtualenv d3stats"
    echo "********************"
    mkvirtualenv $HOME/.virtualenvs/d3stats -p /usr/local/bin/pypy
else
    echo "********************"
    echo "Virtualenv d3stats already exists"
    echo "********************"
fi

# Work inside virtualenv
workon d3stats

# Pull d3stats backend
if [[ ! -d "/srv/www/d3stats/server/d3stats" ]]
then
    echo "********************"
    echo "Pulling backend"
    echo "********************"
    sudo mkdir -p /srv/www/d3stats/server
    cd /srv/www/d3stats/server
    sudo chown snowy:snowy .
    git clone https://snowyleopard@bitbucket.org/snowyleopard/d3stats-backend.git .
    cd d3stats
    pip install --upgrade pip setuptools
    pip install -r requirements.txt
    # Just to be safe
    pip install -r requirements.txt

    # Setup rabbitmq
    sudo rabbitmqctl add_vhost d3stats
    sudo rabbitmqctl add_user d3stats RU2N4mD3pbGgP1fj6b4r
    sudo rabbitmqctl set_permissions -p d3stats d3stats ".*" ".*" ".*"
else
    echo "********************"
    echo "Backend already present"
    echo "********************"
fi

# Pull d3stats frontend
if [[ ! -d "/srv/www/d3stats/client/app" ]]
then
    echo "********************"
    echo "Pulling frontend"
    echo "********************"
    sudo mkdir -p /srv/www/d3stats/client
    cd /srv/www/d3stats/client
    sudo chown snowy:snowy .
    git clone https://snowyleopard@bitbucket.org/snowyleopard/d3stats-frontend.git .
    sudo npm install -g bower
    sudo ln -s /usr/bin/nodejs /usr/bin/node
    bower install
else
    echo "********************"
    echo "Frontend already present"
    echo "********************"
fi
