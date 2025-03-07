terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }

    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "2.35.1"
    }

    helm = {
        source = "hashicorp/helm"
        version = "~>2.17.0"
    }

    tls = {
        source = "hashicorp/tls"
        version = "4.0.6"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

provider "kubernetes" {
  host                   = aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
  }
}
