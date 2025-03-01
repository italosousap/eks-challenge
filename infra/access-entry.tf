resource "aws_eks_access_entry" "estudo_admin" {
  cluster_name = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::421960624240:user/estudo"
  type = "STANDARD"

  depends_on =[ aws_eks_cluster.cluster]
}

resource "aws_eks_access_policy_association" "estudo_admin" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::421960624240:user/estudo"

  access_scope {
    type       = "cluster"
  }

  depends_on =[ aws_eks_cluster.cluster]
}

#resource "aws_eks_access_entry" "node" {
#  cluster_name = aws_eks_cluster.cluster.name
#  principal_arn = "arn:aws:iam::421960624240:user/estudo"
#  type = "STANDARD"
#
#  depends_on =[ aws_eks_cluster.cluster]
#}
#
#resource "aws_eks_access_policy_association" "node" {
#  cluster_name  = aws_eks_cluster.cluster.name
#  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
#  principal_arn = "arn:aws:iam::421960624240:user/estudo"
#
#  access_scope {
#    type       = "cluster"
#  }
#
#  depends_on =[ aws_eks_cluster.cluster]
#}