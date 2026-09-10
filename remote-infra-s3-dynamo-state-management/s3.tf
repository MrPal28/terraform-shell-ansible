resource "aws_s3_bucket" "terraform_state_bucket_ap"{
    bucket = "terraform-state-bucket-ap"

    tags = {
        Name = "terraform-state-bucket-ap"
        Environment = "Dev"
    }
}
