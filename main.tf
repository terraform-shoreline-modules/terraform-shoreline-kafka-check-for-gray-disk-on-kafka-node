terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "gray_disk_on_kafka_node" {
  source    = "./modules/gray_disk_on_kafka_node"

  providers = {
    shoreline = shoreline
  }
}