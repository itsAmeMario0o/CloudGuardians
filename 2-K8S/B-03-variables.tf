variable "estore_mani" {
    description = "The URL to manifest file"
    type        = string
    default     = "https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/refs/heads/main/release/kubernetes-manifests.yaml"
}

variable "game_mani" {
    description = "The URL to manifest file"
    type        = string
    default     = "https://raw.githubusercontent.com/SwapnilM24/k8s-mario/refs/heads/main/deployment.yaml"
}

variable "game_service" {
    description = "The URL to service file"
    type        = string
    default     = "https://raw.githubusercontent.com/SwapnilM24/k8s-mario/refs/heads/main/service.yaml"
}