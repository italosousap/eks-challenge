#resource "aws_eks_addon" "aws-ebs-csi" {
#  cluster_name                  = aws_eks_cluster.cluster.name
#  addon_name                    = "aws-ebs-csi-driver"
#  addon_version                 = "v1.10.1-eksbuild.1"
#  resolve_conflicts_on_update   = "OVERWRITE"
#
#  service_account_role_arn      = aws_iam_role.ebs_csi.arn
#
#  configuration_values = jsonencode({
#    controller ={
#        sdkDebuglog = true
#    }
#  })
#}