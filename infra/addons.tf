resource "aws_eks_addon" "eks_pod_identity" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.3.4-eksbuild.1" 
  resolve_conflicts_on_update = "OVERWRITE"

}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                  = aws_eks_cluster.cluster.name
  addon_name                    = "vpc-cni"
  addon_version                 = "v1.19.2-eksbuild.5"
  resolve_conflicts_on_update   = "OVERWRITE"

  pod_identity_association {
    role_arn                    = aws_iam_role.cni.arn
    service_account             = "aws-node"
  }
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "coredns"
  addon_version               = "v1.11.3-eksbuild.1" 
  resolve_conflicts_on_update = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = 3
  })

  depends_on =[ aws_eks_addon.vpc_cni]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.31.2-eksbuild.3" 
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "aws-ebs-csi" {
  cluster_name                  = aws_eks_cluster.cluster.name
  addon_name                    = "aws-ebs-csi-driver"
  addon_version                 = "v1.40.0-eksbuild.1"
  resolve_conflicts_on_update   = "OVERWRITE"

  pod_identity_association {
    role_arn                    = aws_iam_role.ebs_csi.arn
    service_account             = "ebs-csi-controller-sa"
  }
}