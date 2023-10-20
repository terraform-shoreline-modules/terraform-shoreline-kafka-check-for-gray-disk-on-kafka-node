resource "shoreline_notebook" "gray_disk_on_kafka_node" {
  name       = "gray_disk_on_kafka_node"
  data       = file("${path.module}/data/gray_disk_on_kafka_node.json")
  depends_on = [shoreline_action.invoke_copy_gray_disk_data]
}

resource "shoreline_file" "copy_gray_disk_data" {
  name             = "copy_gray_disk_data"
  input_file       = "${path.module}/data/copy_gray_disk_data.sh"
  md5              = filemd5("${path.module}/data/copy_gray_disk_data.sh")
  description      = "Replace the gray disk with a new one."
  destination_path = "/tmp/copy_gray_disk_data.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_copy_gray_disk_data" {
  name        = "invoke_copy_gray_disk_data"
  description = "Replace the gray disk with a new one."
  command     = "`chmod +x /tmp/copy_gray_disk_data.sh && /tmp/copy_gray_disk_data.sh`"
  params      = ["PATH_TO_GRAY_DISK","PATH_TO_NEW_DISK"]
  file_deps   = ["copy_gray_disk_data"]
  enabled     = true
  depends_on  = [shoreline_file.copy_gray_disk_data]
}

