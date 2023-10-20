

#!/bin/bash



# Define variables

GRAY_DISK=${PATH_TO_GRAY_DISK}

NEW_DISK=${PATH_TO_NEW_DISK}



# Stop Kafka service

sudo systemctl stop kafka



# Copy data from gray disk to new disk

sudo rsync -avzh $GRAY_DISK/ $NEW_DISK/



# Update Kafka configuration files to use new disk

sudo sed -i "s|$GRAY_DISK|$NEW_DISK|g" /etc/kafka/server.properties



# Start Kafka service

sudo systemctl start kafka