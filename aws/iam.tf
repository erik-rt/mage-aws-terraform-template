# iam.tf | IAM Role Policies

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.app_name}-execution-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = {
    Name        = "${var.app_name}-iam-role"
    Environment = var.app_environment
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# EMR Config

# resource "aws_iam_role" "emr_service_role" {
#   name = "${var.app_name}-emr-service-role"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Action = "sts:AssumeRole",
#       Principal = {
#         Service = "elasticmapreduce.amazonaws.com",
#       },
#       Effect = "Allow",
#     }],
#   })
#
#   tags = {
#     Name        = "${var.app_name}-emr-service-role",
#     Environment = var.app_environment
#   }
# }
#
# resource "aws_iam_policy_attachment" "emr_default_role_policy" {
#   role       = aws_iam_role.emr_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
# }
#
# resource "aws_iam_instance_profile" "emr_instance_profile" {
#   name = "${var.app_name}-emr-instance-profile"
#   role = aws_iam_role.emr_service_role.name
# }
#
# resource "aws_iam_role" "emr_autoscaling_role" {
#   name = "${var.app_name}-emr-autoscaling-role"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Action = "sts:AssumeRole",
#       Principal = {
#         Service = "application-autoscaling.amazonaws.com",
#       },
#       Effect = "Allow",
#     }],
#   })
#
#   tags = {
#     Name        = "${var.app_name}-emr-autoscaling-role",
#     Environment = var.app_environment
#   }
# }
#
# resource "aws_iam_policy_attachment" "emr_autoscaling_policy" {
#   role = aws_iam_role.emr_autoscaling
# }
