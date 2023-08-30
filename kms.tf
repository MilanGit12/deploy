resource "aws_kms_key" "logs_key" {
  # key does not have rotation enabled
  description = "${local.resource_prefix.value}-logs bucket key"

  deletion_window_in_days = 7
  tags = {
    git_commit           = "135772ecec3bc61eb3c42013f1c1251a6ec36404"
    git_file             = "kms.tf"
    git_last_modified_at = "2023-05-30 15:31:04"
    git_last_modified_by = "123986661+MilanGit12@users.noreply.github.com"
    git_modifiers        = "123986661+MilanGit12"
    git_org              = "MilanGit12"
    git_repo             = "deploy"
    yor_trace            = "7057517c-fad7-46d2-87dd-1cf1b0a6aaa8"
    Privacy              = ""
  }
}

resource "aws_kms_alias" "logs_key_alias" {
  name          = "alias/${local.resource_prefix.value}-logs-bucket-key"
  target_key_id = "${aws_kms_key.logs_key.key_id}"
}
