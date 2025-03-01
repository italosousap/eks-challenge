# Obtém a URL do OIDC do cluster
data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.cluster.name
}

data "tls_certificate" "eks_oidc" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

# Cria o IAM OIDC Provider
resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc.certificates[0].sha1_fingerprint]
}