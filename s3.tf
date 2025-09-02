resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  force_destroy = true
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "4ef06875-4a2f-4a63-b01d-0eba8470a91b"
    Privacy              = ""
  }
}


resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "7632dd1e-892c-4db6-9954-5691a81a641c"
    Privacy              = ""
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  # checking to see if comments update yor tags in financials bucket
  # Testing changes
  bucket        = "${local.resource_prefix.value}-financials"
  acl           = "private"
  force_destroy = true
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "1d1fb83e-f4d3-4e2b-b442-824c46af108e"
    Privacy              = ""
  }
}


resource "aws_s3_bucket_versioning" "financials" {
  bucket = aws_s3_bucket.financials.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  # testing yor workflow change
  bucket = "${local.resource_prefix.value}-operations"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "fe045a35-8cf2-470d-b4a0-351cd66acc35"
    Privacy              = ""
  }
}


resource "aws_s3_bucket_versioning" "operations" {
  bucket = aws_s3_bucket.operations.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "destination" {
  bucket = aws_s3_bucket.operations.id
  versioning_configuration {
    status = "Enabled"
  }
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "ff73df57-24c0-42c8-816c-2b0465df8cb5"
    Privacy              = ""
  }
}

resource "aws_iam_role" "replication" {
  name               = "aws-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "4db97f86-19da-480f-85f1-f904d7f2e858"
    Privacy              = ""
  }
}

resource "aws_s3_bucket_replication_configuration" "operations" {
  depends_on = [aws_s3_bucket_versioning.operations]
  role       = aws_iam_role.operations.arn
  bucket     = aws_s3_bucket.operations.id
  rule {
    id     = "foobar"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }
  }
}






resource "aws_s3_bucket" "operations_log_bucket" {
  bucket = "operations-log-bucket"
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "02461143-8cd6-4c01-97b7-9c96499c6d2b"
    Privacy              = ""
  }
}

resource "aws_s3_bucket_logging" "operations" {
  bucket = aws_s3_bucket.operations.id

  target_bucket = aws_s3_bucket.operations_log_bucket.id
  target_prefix = "log/"
}






resource "aws_s3_bucket_server_side_encryption_configuration" "operations" {
  bucket = aws_s3_bucket.operations.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}


resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "edb77fef-7d69-43e5-827b-37091bc5ebd5"
    Privacy              = ""
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }

  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "s3.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "dfcc308c-e050-4df7-a4d9-68403b997f37"
    Privacy              = ""
  }
}
