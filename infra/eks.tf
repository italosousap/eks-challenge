resource "aws_eks_cluster" "cluster" {
  name = "sre-challenge"

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = false
  }
  bootstrap_self_managed_addons = true

  role_arn = aws_iam_role.cluster.arn
  version  = "1.32"

  vpc_config {
    subnet_ids = data.aws_subnets.subnets.ids
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}