# here using the random resource we are creating a suffix , which will give us 6 bytes of random values and that value we can use inside another provider
resource "random_id" "bucket_suffix" {
  byte_length = 6
}

# here while creating this bucket the name of the bucket has a random value in the suffix and we are using that value using the 
# random provider . the value is fetch via ${<resource.resource_name.type}
resource "aws_s3_bucket" "exampleBucket" {

  bucket = "example-bucket-${random_id.bucket_suffix.hex}"

}

output "bucket_name" {
  value = aws_s3_bucket.exampleBucket.bucket
}