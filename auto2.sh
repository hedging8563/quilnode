#!/bin/bash

# Update the configuration file
sed -i "s@listenGrpcMultiaddr: \"\"@listenGrpcMultiaddr: /ip4/127.0.0.1/tcp/8337@" ceremonyclient/node/.config/config.yml

# Install grpcurl
go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest

# Build and install the Go application
cd ceremonyclient/node
GOEXPERIMENT=arenas /usr/local/go/bin/go install ./...

# Create and start the systemd service
sudo echo -e "[Unit]\nDescription=Ceremony Client Go App Service\n\n[Service]\nType=simple\nRestart=always\nRestartSec=5s\nWorkingDirectory=/root/ceremonyclient/node\nEnvironment=GOEXPERIMENT=arenas\nExecStart=/root/go/bin/node ./...\n\n[Install]\nWantedBy=multi-user.target" | sudo tee /lib/systemd/system/ceremonyclient.service

systemctl daemon-reload
service ceremonyclient start
