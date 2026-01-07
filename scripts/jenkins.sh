#!/bin/bash
set -e
echo "🔹 Updating system..."
sudo apt update -y
sudo apt upgrade -y
echo "🔹 Installing Java 17..."
sudo apt install -y openjdk-17-jdk
echo "🔹 Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key 
  | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "🔹 Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] 
  https://pkg.jenkins.io/debian-stable binary/ 
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
echo "🔹 Installing Jenkins..."
sudo apt update -y
sudo apt install -y jenkins
echo "🔹 Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "🔹 Allowing Jenkins through firewall (if enabled)..."
if sudo ufw status | grep -q active; then
  sudo ufw allow 8080
fi
echo "✅ Jenkins installation completed!"
echo "🔑 Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
