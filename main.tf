
resource helm_release helloiksfrtfcb {
  name       = "helloiksapp"
  namespace = "default"
  chart = "https://prathjan.github.io/helm-chart/helloiks-0.1.1.tgz"
  timeout = 600

  set {
    name  = "MESSAGE"
    value = "Hello IKS from TFCB!!"
  }
}

provider "helm" {
  kubernetes {
    host = local.kube_config.clusters[0].cluster.server
    client_certificate = base64decode(local.kube_config.users[0].user.client-certificate-data)
    client_key = base64decode(local.kube_config.users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(local.kube_config.clusters[0].cluster.certificate-authority-data)
  }
}

variable "kube_harbor_config" {
  type = string
}

locals {
  kube_config = yamldecode(var.kube_harbor_config)
}

