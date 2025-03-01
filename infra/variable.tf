variable "iam_access_entries" {
  type = list(object({
    policy_arn     = string
    principal_arn  = string
  }))

  default = [
    {
      policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      principal_arn = "arn:aws:iam::421960624240:user/estudo"
    },
    {
      policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      principal_arn = "arn:aws:iam::<YOUR_ACCOUNT_ID>:role/<ROLE_NAME>"
    },

  ]
}