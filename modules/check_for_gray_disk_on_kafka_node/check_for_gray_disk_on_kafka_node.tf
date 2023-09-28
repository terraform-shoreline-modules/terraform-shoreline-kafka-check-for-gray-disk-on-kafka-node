resource "shoreline_notebook" "check_for_gray_disk_on_kafka_node" {
  name       = "check_for_gray_disk_on_kafka_node"
  data       = file("${path.module}/data/check_for_gray_disk_on_kafka_node.json")
  depends_on = [shoreline_action.invoke_disk_health_check]
}

resource "shoreline_file" "disk_health_check" {
  name             = "disk_health_check"
  input_file       = "${path.module}/data/disk_health_check.sh"
  md5              = filemd5("${path.module}/data/disk_health_check.sh")
  description      = "Identify the affected Kafka node(s) and disk(s) causing the sporadic IOPs drops."
  destination_path = "/agent/scripts/disk_health_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_disk_health_check" {
  name        = "invoke_disk_health_check"
  description = "Identify the affected Kafka node(s) and disk(s) causing the sporadic IOPs drops."
  command     = "`chmod +x /agent/scripts/disk_health_check.sh && /agent/scripts/disk_health_check.sh`"
  params      = ["DISK_NAME","NODE_NAME"]
  file_deps   = ["disk_health_check"]
  enabled     = true
  depends_on  = [shoreline_file.disk_health_check]
}

