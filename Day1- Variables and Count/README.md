# 🚀 Terraform AWS EC2 Instances with Variables & Count

This project is a **Terraform beginner-friendly example** that provisions multiple EC2 instances on AWS using **variables** and the **count parameter**.  
It demonstrates how to:  
- Use **lists** as variable inputs.  
- Dynamically create multiple resources with `count`.  
- Assign unique attributes (like instance type and tags) using `count.index`.  

---

## 📌 Why This Project?
Terraform is an **Infrastructure as Code (IaC)** tool that allows us to manage infrastructure in a safe, repeatable, and automated way.  
This project helps you learn:
- Defining **variables** in `variables.tf`.  
- Passing values from lists using `count.index`.  
- Creating multiple resources without copy-paste.  

Example: Instead of writing 2 `aws_instance` resources, we write **just one block** and let Terraform loop over it.

---

## 📂 Project Structure
├── main.tf # Main Terraform configuration (provider + EC2 resource)
├── variables.tf # Variable definitions


---

## ⚙️ Variables Explained

```hcl
variable "instance_type" {
  type    = list(string)
  default = ["t2.micro","t2.small"]
}

variable "image_id" {
  default = "ami-01b6d88af12965bb6"
}

variable "tag" {
  type    = list(string)
  default = ["test","dev"]
}
