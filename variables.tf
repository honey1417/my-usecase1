variable "PROJECT_ID" {
    description = "gcp project ID"
    type = string
    default = "harshini-project-452710"
}

variable "region"{
    description = "default region where resources will be created"
    type = string
    default = "us-central1"
}

variable "cluster_name"{
    description = "name of GKE cluster"
    type = string
    default = "harness-cluster"
}

variable "MACHINE_TYPE" {
    description = "machine type for nodes of cluster"
    type = string
    default = "e2-medium"
}

variable "NODE_COUNT"{
    description = "number of nodes"
    type = number
    default = 2
}
