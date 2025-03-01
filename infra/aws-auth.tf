#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.cluster.endpoint
#  token                  = data.aws_eks_cluster_auth.cluster.token
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#}

#data "aws_eks_cluster" "cluster" {
#  name = "meu-cluster-eks"
#}
#

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.name
}

#
#resource "kubernetes_config_map_v1" "aws_auth" {
#  metadata {
#    name      = "aws-auth"
#    namespace = "kube-system"
#  }
#
#  data = {
#    mapRoles = <<YAML
#- rolearn: arn:aws:iam::421960624240:role/eks-cluster-node-role
#  username: system:node:{{EC2PrivateDNSName}}
#  groups:
#    - system:bootstrappers
#    - system:nodes
#YAML
#
#    mapUsers = <<YAML
#- userarn: arn:aws:iam::421960624240:user/estudo
#  username: estudo
#  groups:
#    - system:masters
#YAML
#  }
#
#  depends_on = [aws_eks_cluster.cluster]
#}
#