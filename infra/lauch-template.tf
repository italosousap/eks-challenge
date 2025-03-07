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

  image_id = "ami-0bfe24baa71c55ffc"

  instance_type = "t4g.medium"

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "lb-app"
    }
  }
  key_name = "bastion"

  user_data = filebase64("${path.module}/userdata.sh")

  depends_on = [
    aws_eks_cluster.cluster,
    aws_iam_role.node
  ]
}