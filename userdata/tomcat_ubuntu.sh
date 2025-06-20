#!/bin/bash

# Update & upgrade the OS
sudo apt update && sudo apt upgrade -y

# Install OpenJDK 11
sudo apt install openjdk-11-jdk -y

# Install Tomcat 10 and related tools
sudo apt install tomcat10 tomcat10-admin tomcat10-common tomcat10-user git -y

# Optional: Enable and start Tomcat
sudo systemctl enable tomcat10
sudo systemctl start tomcat10

# Confirm versions
java -version
systemctl status tomcat10

#Tomcat9 version set up in Ubuntu
#!/bin/bash
# Variables
TOMCAT_VERSION=9.0.85
TOMCAT_USER=tomcat
INSTALL_DIR=/opt/tomcat

# Update & install dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-11-jdk curl wget unzip git -y

# Create Tomcat user (no login)
sudo useradd -m -U -d $INSTALL_DIR -s /bin/false $TOMCAT_USER

# Download and extract Tomcat
cd /tmp
wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
sudo mkdir -p $INSTALL_DIR
sudo tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C $INSTALL_DIR --strip-components=1

# Set permissions
sudo chown -R $TOMCAT_USER:$TOMCAT_USER $INSTALL_DIR
sudo chmod +x $INSTALL_DIR/bin/*.sh

# Create a systemd service file
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=$TOMCAT_USER
Group=$TOMCAT_USER

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=$INSTALL_DIR/temp/tomcat.pid"
Environment="CATALINA_HOME=$INSTALL_DIR"
Environment="CATALINA_BASE=$INSTALL_DIR"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=$INSTALL_DIR/bin/startup.sh
ExecStop=$INSTALL_DIR/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start Tomcat
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

# Firewall (optional, if enabled)
# sudo ufw allow 8080/tcp

# Output status
sudo systemctl status tomcat
