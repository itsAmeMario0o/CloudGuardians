# Install Cilium with specified values

# Deploys Cilium CNI Chaining, enables Hubble, and Tetragon
# https://docs.cilium.io/en/stable/installation/cni-chaining-aws-cni/

resource "helm_release" "cilium" {
  name       = "cilium"
  chart      = "cilium"
  namespace  = "kube-system"
  repository = "https://helm.cilium.io"
  
  set {
    name  = "cni.chainingMode"
    value = "aws-cni"
  }

  set {
    name  = "cni.exclusive"
    value = "false"
  }

  set {
    name  = "enableIPv4Masquerade"
    value = "false"
  }

  set {
    name  = "routingMode"
    value = "native"
  }

  set {
    name  = "endpointRoutes.enabled"
    value = "true"
  }

  set {
    name  = "hubble.relay.enabled"
    value = "true"
  }

  set {
    name  = "hubble.ui.enabled"
    value = "true"
  }

  set {
    name  = "hubble.metrics.enabled"
    value = "{dns,drop,tcp,flow,icmp,http}"
  }
}

# Install Tetragon with specified values
resource "helm_release" "tetragon" {
  name       = "tetragon"
  repository = "https://helm.cilium.io"
  chart      = "tetragon"
  namespace  = "kube-system"
  
  set {
    name  = "tetragon.enableProcessCred"
    value = "true"
  }

  set {
    name  = "tetragon.enableProcessNs"
    value = "true"
  }

# https://tetragon.io/docs/installation/runtime-hooks/

  # set {
  #   name  = "rthooks.enabled"
  #   value = "true"
  # }

  # set {
  #   name  = "rthooks.interface"
  #   value = "oci-hooks"
  # }

depends_on = [
    helm_release.cilium
  ]
}