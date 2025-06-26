module "k8s-workstation" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "k8s-Workstation"

  ami           = data.aws_ami.rhel_info.id
  instance_type = var.k8s_instance.instance_type
  vpc_security_group_ids = [var.allow-everything]
  # convert StringList to list and get first element
  subnet_id = var.public_subnet_id
  user_data = file("workstation.sh")
  iam_instance_profile = "k8s-iam-role-authentication"

  tags = {
        Name = "k8s-workstation-ec2"
    }
}
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"
  zone_name = var.domain_name

records = [
      {
        name = "k8s"
        type = "A"
        ttl  = 1
        records = [
          module.k8s-workstation.public_ip
        ]
        allow_overwrite = true
      }
   ]
}

# resource "aws_instance" "expense" {
#     for_each = var.instances
#     ami           = data.aws_ami.rhel_info.id
#     instance_type = each.value
#     vpc_security_group_ids = [var.allow_all]
#     user_data = file("${path.module}/install_${each.key}.sh")

#     tags = {
#         Name = each.key
#     }
# }
# resource "aws_route53_record" "expense_r53" {
#     for_each = aws_instance.expense
#     zone_id = var.zone_id
#     name    = each.key == "frontend"? var.domain_name : "${each.key}.${var.domain_name}" 
#     type    = "A"
#     ttl     = 1
#     records = each.key == "frontend" ? [each.value.public_ip]:[each.value.private_ip]
#     allow_overwrite = true
# }