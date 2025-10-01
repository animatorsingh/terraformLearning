variable "instance_type" {
    type = list
  default = ["t2.micro","t2.small"]
}

variable "image_id" {
  default = "ami-01b6d88af12965bb6"
  
}

variable "tag" {
    type = list
    default = ["test", "dev"]     
}