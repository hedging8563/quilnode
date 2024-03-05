#!/bin/bash

# 停止 ceremonyclient 服务
service ceremonyclient stop

# 切换到 ~/ceremonyclient 目录
cd ~/ceremonyclient

# 从远程仓库拉取更新
git fetch origin
git merge origin

# 切换到 ~/ceremonyclient/node 目录
cd ~/ceremonyclient/node

# 清理并重新安装 node
GOEXPERIMENT=arenas go clean -v -n -a ./...
rm /root/go/bin/node
GOEXPERIMENT=arenas go install ./...

# 启动 ceremonyclient 服务
service ceremonyclient start