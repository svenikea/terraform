# S3 Bucket Module

This module will create a list of buckets

## Terraform definition

```terraform
module "<module name>" {
    source = "../modules/s3
}
```

## Variables 

| Variables             | Usage                             |   
|-----------------------|-----------------------------------|
|bucket_name            |A list of S3 Buckets               |
|project                |The name of the project            |
|env                    |Environment                        |