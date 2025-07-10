module "k8s-workstation" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "k8s-Workstation"

  ami           = data.aws_ami.rhel_info.id
  instance_type = var.k8s_instance.instance_type
  vpc_security_group_ids = [var.allow_everything]
  # convert StringList to list and get first element
  subnet_id = var.public_subnet_id
  
  user_data = file("workstation.sh")
  iam_instance_profile = "k8s-iam-role-authentication" #administrator access role name.
  root_block_device = {
    encrypted  = false           # Not encrypted
    type       = "gp3"           # gp3 volume type
    size       = 100              # 10 GiB
    iops       = 3000            # 3000 IOPS
    throughput = 125             # Optional: default for gp3 is 125 MiB/s
  }
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
  depends_on = [module.k8s-workstation]
}