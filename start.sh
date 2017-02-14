#!/bin/bash

# Disable Strict Host checking for non interactive git clones

mkdir -p -m 0700 /root/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

git config --global --unset https.proxy

# Setup git variables
if [ ! -z "$GIT_EMAIL" ]; then
  git config --global user.email "$GIT_EMAIL"
fi
if [ ! -z "$GIT_NAME" ]; then
  git config --global user.name "$GIT_NAME"
  git config --global push.default simple
fi

# Dont pull code down if the .git folder exists
if [ ! -d "/root/docs_source/.git" ]; then
  # Pull down code from git for our site!
  if [ ! -z "$GIT_REPO" ]; then
    # Remove the test index file
    rm -Rf /root/docs_source/*
    if [ ! -z "$GIT_BRANCH" ]; then
      if [ -z "$GIT_USERNAME" ] && [ -z "$GIT_PERSONAL_TOKEN" ]; then
        git clone -b $GIT_BRANCH https://github.com/$GIT_REPO /root/docs_source/ || exit 1
      else
        git clone -b ${GIT_BRANCH} https://github.com/${GIT_USERNAME}:${GIT_PERSONAL_TOKEN}@${GIT_REPO} /root/docs_source || exit 1
      fi
    else
      if [ -z "$GIT_USERNAME" ] && [ -z "$GIT_PERSONAL_TOKEN" ]; then
        git clone https://github.com/$GIT_REPO /root/docs_source/  || exit 1
      else
        git clone https://github.com/${GIT_USERNAME}:${GIT_PERSONAL_TOKEN}@${GIT_REPO} /root/docs_source || exit 1
      fi
    fi
  fi
fi

if [ -f /root/docs_source/config/nginx.conf ]; then
  cp -f /root/docs_source/config/nginx.conf /etc/nginx/sites-enabled/webapp.conf
fi

if [ -f /root/docs_source/config/rails_env.conf ]; then
  cp -f /root/docs_source/config/rails_env.conf /etc/nginx/main.d/rails_env.conf
fi

cd /root/docs_source

service nginx restart

tail -f /var/log/nginx/access.log
