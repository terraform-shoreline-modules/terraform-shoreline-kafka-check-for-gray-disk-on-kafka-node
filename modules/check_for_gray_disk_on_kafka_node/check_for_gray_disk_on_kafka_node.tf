resource "shoreline_notebook" "check_for_gray_disk_on_kafka_node" {
  name       = "check_for_gray_disk_on_kafka_node"
  data       = file("${path.module}/data/check_for_gray_disk_on_kafka_node.json")
  depends_on = [shoreline_action.invoke_kafka_disk_health_check]
}

resource "shoreline_file" "kafka_disk_health_check" {
  name             = "kafka_disk_health_check"
  input_file       = "${path.module}/data/kafka_disk_health_check.sh"
  md5              = filemd5("${path.module}/data/kafka_disk_health_check.sh")
  description      = "Identify the affected Kafka node(s) and disk(s) causing the sporadic IOPs drops."
  destination_path = "/agent/scripts/kafka_disk_health_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_kafka_disk_health_check" {
  name        = "invoke_kafka_disk_health_check"
  description = "Identify the affected Kafka node(s) and disk(s) causing the sporadic IOPs drops."
  command     = "`chmod +x /agent/scripts/kafka_disk_health_check.sh && /agent/scripts/kafka_disk_health_check.sh`"
  params      = ["NODE_NAME","DISK_NAME"]
  file_deps   = ["kafka_disk_health_check"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_disk_health_check]
}

