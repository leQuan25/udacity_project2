terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "ASIA6N7JOYUGLIIIW6SL"
  secret_key = "WzwEkBfSN5QrrXcHDUAzOzJHILmXJ2DzjnI+F0Rh"
  token = "FwoGZXIvYXdzEOH//////////wEaDAl96PNDiSK7DHsVOiLVAYonQZD72w4scjfmOoi6V08435eukOC5RBJQTRgYUKsmeiU6440JREFGjBq0+E9ZYCTh0/vISvNpbNcBTD9ICCoK7f0F1kX5JaMraQL6jPkJOjm9Q05KnAbq909/p0VU+q0nApo6jzTAH2wCfbTn+rrUe4RX1YxTa9B5r4OQBgoUbrVuQJDgGNm9uI/3SkK7mtNjoEOnCWkuHEwyFrL40koRs46uRbIyK+Id/EC2cbn2MEDUsoniSyveyV8BfDAvU9L0OWHQwCce672UBa2FlJIJ+qmiIijJmYKjBjItPdPtevW60DmHdmDUy2ycnpMoar+WvE4FcjlOCrbME/+4oCCyhU58I3WuVJTz"
  region  = "us-west-2"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
# resource "aws_instance" "Udacity_T2" {
#   count = "4"
#   ami = "ami-04e914639d0cca79a"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "Udacity T2"
#   }
# }

## TODO: provision 2 m4.large EC2 instances named Udacity M4
# resource "aws_instance" "Udacity_M4" {
#   count = "2"
#   ami = "ami-04e914639d0cca79a"
#   instance_type = "m4.large"
#   tags = {
#    Name = "Udacity M4"
#  }
# }

