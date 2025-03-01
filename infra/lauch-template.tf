resource "aws_launch_template" "lt_app" {
  name = "lt-app"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size   = 30
      volume_type   = "gp3"
      throughput    = 150
    }
  }

  ebs_optimized = true

  iam_instance_profile {
    name = "eks-cluster-node-role"
  }

  image_id = "ami-023924ecc2c7293f8"

  instance_type = "t3.medium"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = ["sg-2350f46a"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "lb-app"
    }
  }

  #user_data = filebase64("${path.module}/example.sh")
  depends_on = [
    aws_eks_cluster.cluster,
    aws_iam_role.node
  ]
}