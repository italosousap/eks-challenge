resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

################################################################# PROMETHEUS #################################################################
resource "helm_release" "prometheus" {
  name          = "prometheus"
  repository    = "https://prometheus-community.github.io/helm-charts"
  chart         = "prometheus"
  namespace     = kubernetes_namespace.monitoring.metadata[0].name
  timeout       = 900

  values = [
    file("${path.module}/helm-values/prometheus.yml")
  ]
}

################################################################# GRAFANA LOKI #################################################################
resource "helm_release" "loki" {
  name          = "loki"
  repository    = "https://grafana.github.io/helm-charts"
  chart         = "loki"
  namespace     = kubernetes_namespace.monitoring.metadata[0].name
  version       = "6.24.0"
  timeout       = 600

  values = [
    file("${path.module}/helm-values/loki.yml")
  ]
}

################################################################# GRAFANA TEMPO #################################################################
resource "helm_release" "tempo" {
  name          = "tempo"
  repository    = "https://grafana.github.io/helm-charts"
  chart         = "tempo"
  namespace     = kubernetes_namespace.monitoring.metadata[0].name
}

################################################################# KUBE STATE METRICS #################################################################
resource "helm_release" "kube_state_metrics" {
  name          = "kube-state-metrics"
  repository    = "https://prometheus-community.github.io/helm-charts"
  chart         = "kube-state-metrics"
  namespace     = kubernetes_namespace.monitoring.metadata[0].name
}

################################################################# GRAFANA #################################################################
resource "helm_release" "grafana" {
  name          = "grafana"
  repository    = "https://grafana.github.io/helm-charts"
  chart         = "grafana"
  namespace     = kubernetes_namespace.monitoring.metadata[0].name
  timeout       = 400
  version       = "8.8.3"
  values = [
    file("${path.module}/helm-values/grafana.yml")
  ]
}

################################################################# METRIC SERVER #################################################################
resource "helm_release" "metrics_server" {
  name          = "metrics-server"
  repository    = "https://kubernetes-sigs.github.io/metrics-server/"
  chart         = "metrics-server"
  namespace     = "kube-system"

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }
}

################################################################# CLUSTER AUTOSCALER #################################################################
resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"

  set {
    name  = "autoDiscovery.clusterName"
    value = "sre-challenge"
  }

  set {
    name  = "awsRegion"
    value = "us-east-1"
  }

  set {
    name  = "extraArgs.balance-similar-node-groups"
    value = "true"
  }

  set {
    name  = "extraArgs.expander"
    value = "least-waste"
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cluster_autoscaler_role.arn
  }
}

################################################################# LOAD BALANCER CONTROLLER #################################################################
resource "helm_release" "lbc" {
  name          = "aws-load-balancer-controller"
  repository    = "https://aws.github.io/eks-charts"
  chart         = "aws-load-balancer-controller"
  namespace     = "kube-system"

  set {
    name  = "clusterName"
    value = "sre-challenge"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

}
