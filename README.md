
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Check for Gray Disk on Kafka Node
---

This incident type refers to the detection of a gray disk on a Kafka node, which can cause sporadic IOPs drops. A gray disk is a type of hard disk failure where the disk starts to fail slowly, causing the disk to become slower and slower over time. As a result, the disk can cause various issues, such as data loss, system crashes, and performance degradation. In the case of a Kafka node, a gray disk can cause sporadic IOPs drops, which can impact the performance of the Kafka cluster and potentially cause data loss. Therefore, it is crucial to detect and fix gray disks as soon as possible to ensure the stability and reliability of the system.

### Parameters
```shell
export DISK_NAME="PLACEHOLDER"

export NODE_NAME="PLACEHOLDER"
```

## Debug

### Check the disk usage of the Kafka node
```shell
df -h
```

### Check the disk performance of the Kafka node
```shell
iostat -d ${DISK_NAME}
```

### Check the SMART status of the Kafka node's disks
```shell
smartctl -a /dev/${DISK_NAME}
```

### Check the disk errors of the Kafka node's disks
```shell
dmesg | grep -i ${DISK_NAME}
```

### Check the disk temperature of the Kafka node's disks
```shell
smartctl -A /dev/${DISK_NAME} | grep -i temperature
```

### Check the disk health of the Kafka node's disks
```shell
smartctl -H /dev/${DISK_NAME}
```

## Repair

### Identify the affected Kafka node(s) and disk(s) causing the sporadic IOPs drops.
```shell


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


```