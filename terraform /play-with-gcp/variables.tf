// required variable
variable "project" {}

variable "credentials_file" {}

# if default value is given, it's optional.
variable "region" {
    default = "us-central1"
}

variable "zone" {
    default = "us-central1-c"
}