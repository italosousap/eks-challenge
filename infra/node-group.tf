resource "aws_eks_node_group" "node_gr" {
  cluster_name      = aws_eks_cluster.cluster.name
  node_group_name   = "app-node"
  node_role_arn     = aws_iam_role.node.arn
  subnet_ids        = data.aws_subnets.subnets.ids
  capacity_type     = "SPOT"

  scaling_config {
    desired_size    = 2
    max_size        = 2
    min_size        = 2
  }

  update_config {
    max_unavailable = 1
  }

  launch_template {
    name            = aws_launch_template.lt_app.name
    version         = aws_launch_template.lt_app.latest_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_eks_addon.vpc_cni,
    aws_eks_cluster.cluster
  ]

  tags = {
    "kubernetes.io/cluster/sre-challenge" = "owned"
  }
}