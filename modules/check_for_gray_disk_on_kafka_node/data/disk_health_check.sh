

#!/bin/bash



# Set the Kafka node(s) and disk(s) to check

KAFKA_NODE=${NODE_NAME}

DISK=${DISK_NAME}



# Check the disk health status

HEALTH_STATUS=$(sudo smartctl -H /dev/$DISK | grep "SMART overall-health self-assessment test result")



# Check if the disk has any errors

if [[ $HEALTH_STATUS != *"PASSED"* ]]; then

    echo "Gray disk detected on node $KAFKA_NODE, disk $DISK"

else

    echo "No gray disk detected on node $KAFKA_NODE, disk $DISK"

fi



exit 0