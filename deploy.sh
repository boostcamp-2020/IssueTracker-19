#!/bin/bash

git checkout master
git fetch

head=`git rev-parse HEAD`
origin=`git rev-parse origin/master`

if [ $head != $origin ]; then
        git pull
        cd /root/IssueTracker-19/backend
        npm i
        cd /root/IssueTracker-19/frontend
        npm i
        npm run build
        pm2 reload app
fi
echo 'finish!'
