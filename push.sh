#!/bin/bash
git init
git remote add origin "https://oauth2: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@github.com/pxlxingliang/pxl.github.io.git"

# Configure git user
git config user.name "pxlxingliang"
git config user.email "pxlppq007@163.com"

# configure git debug mode
set GIT_TRACE=true
set GIT_CURL_VERBOSE=true
set GIT_SSH_COMMAND=ssh -vvv

# Checkout the repository
# try 10 times
fetch=0
for i in {1..10}
do
    echo "try to fetch repo $i"
    git fetch --depth 1 origin main
    if [ $? -eq 0 ]; then
        fetch=1
        break
    fi
    sleep 10
done
if [ $fetch -eq 0 ]; then
    echo "Error: can not fetch the branch main!"
    exit 1
fi
git checkout main

# copy the files
cp -r /root/test/testgithub/remote/* .

# commit and push
git add .
git commit -m "a test"

# try 10 times
push=0
for i in {1..10}
do
    echo "try to push commit $i"
    git push origin main
    if [ $? -eq 0 ]; then
        push=1
        break
    fi  
    sleep 10
done
if [ $push -eq 0 ]; then
    echo "Error: can not push the branch main!"
    exit 1
fi
