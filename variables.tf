variable "allow_everything" {
    type = string
    default = "sg-09c7c70bd56f0d58b"
}
variable "zone_id" {
    default ="Z07608533HHBQHW47XU3F"
}
variable "domain_name" {
  default = "lingaiah.online"
}
variable "k8s_instance" {
   default = {
        instance_type  = "t3.micro"
   }
}
variable "public_subnet_id" {
    type = string
    default = "subnet-0a3b249c1f344ef36" #update it right one.
}

