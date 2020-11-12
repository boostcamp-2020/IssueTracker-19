#!/bin/bash

git checkout web
git fetch

head=`git rev-parse HEAD`
origin=`git rev-parse origin/web`

if [ $head != $origin ]; then
        git pull
        pm2 reload app
        cd /root/IssueTracker-19/frontend
        npm run build
fi
echo 'finish!'