# Please accept the terms of the Snowplow Limited Use License Agreement to proceed. (https://docs.snowplow.io/limited-use-license-1.0/)
accept_limited_use_license = true

# Will be prefixed to all resource names
# Use this to easily identify the resources created and provide entropy for subsequent environments
prefix = "sp"

# WARNING: You MUST change this as each bucket must be globally unique
s3_bucket_name = "snowplow-terraform-playground-bumblebee"

# To use an existing bucket set this to false and update the name above
s3_bucket_deploy = true

# To save objects in a particular sub-directory you can pass in an optional prefix (e.g. 'foo/')
s3_bucket_object_prefix = ""

# Update to the VPC you would like to deploy into
# Find your default: https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html#view-default-vpc
vpc_id            = "vpc-0dd624210f65061b4"
public_subnet_ids = ["subnet-01945ac0fca472812", "subnet-073fbe598e6af0ed5", "subnet-09b647a9a92df320b"]

# Update this to your IP Address
ssh_ip_allowlist = ["147.161.173.0/24"]
# Generate a new SSH key locally with `ssh-keygen`
# ssh-keygen -t rsa -b 4096
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5+Uctxp2Q8xeUTztKpIW3XqMWnmTyHjFZkbmeoQcCTLKtZJ+CLROlutqZWEy19Z1Map2tfXbo3cIghVKDrr7rXV6zM9dgmCQBPvNZivu7H3BpN8qR4h/BSSi4YsSE04+QOApp+OT+D9ToNwtUUPdzisbdgSaeYtZTj8UISsoOCUyNSxrzaJB8ye6+DLkEP5GMsl+VnMxe3VXzMHPioqPl0HDSibRzok8hm0Y8jQOB6r5tkmM4Gs8Zr1hfSIZZFvCA2kP2iS+pyzBslneGNszEepsfIseT+Kybq4RvXBpPg/tZZ/dJhtYcFx+wqQWzP8RHVGmSrwRrcxzgmHaIBbr5Qeh7azhDkPEcRYERVC1b13TPSK77vc19VN+QFAfPG+7PoJ0IsWWQ3ez7CtFKA+sO0SHq9mz89gAq1G7WIm+lPSwDzsValv2osgDn1ehnX5SY4X1B7pjult0qDfpeHMOFfKPeMH6CqNS1awALheWV0qsN7Tn8+5uCmNpLGDIg15jdfV5dpZ0IGhH/lhn9De1sWI4wQcTNCaMmWzb+y7Z8b6tsyz8ZB0wB/2FJCHIyvUpMwFmGyoc4ziPWopb1JNchLem4GogbmFehHyLguc17P8dKKTFxLrIe4X5MYe+j2VjA7gZK6teVFWPqxjWT8xWUp3UkhvEmNV+rwkLp2rQY6w== angelo.rampersad@RGD4594QPT"

# Iglu Server DNS output from the Iglu Server stack
iglu_server_dns_name = "http://sp-iglu-lb-1687441717.eu-west-1.elb.amazonaws.com"
# Used for API actions on the Iglu Server
# Change this to the same UUID from when you created the Iglu Server
iglu_super_api_key = "00000000-0000-0000-0000-000000000000"

# Collector SSL Configuration (optional)
ssl_information = {
  certificate_arn = ""
  enabled         = false
}

# --- TARGETS CONFIGURATION ZONE --- #

# --- Target: Amazon S3
s3_raw_enabled      = false
s3_bad_enabled      = true
s3_enriched_enabled = true

# --- Target: PostgreSQL
postgres_db_enabled = false

postgres_db_name     = "snowplow"
postgres_db_username = "snowplow"
# Change and keep this secret!
postgres_db_password = "Hell0W0rld!2"
# IP ranges that you want to query the Pipeline Postgres RDS from
# Note: this exposes your data to the internet - take care to ensure your allowlist is strict enough
#       or provide a way to access the database through the VPC instead
postgres_db_publicly_accessible = true
postgres_db_ip_allowlist        = ["147.161.173.0/24"]

# --- Target: Snowflake
# Follow the guide to get input values for the loader:
# https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/quick-start-aws
snowflake_enabled = false

snowflake_account         = "<ACCOUNT>"
snowflake_region          = "<REGION>"
snowflake_loader_user     = "<USER>"
snowflake_loader_password = "<PASSWORD>"
snowflake_database        = "<DATABASE>"
snowflake_schema          = "<SCHEMA>"
snowflake_warehouse       = "<WAREHOUSE>"
# This controls how often data will be loading into Snowflake
snowflake_transformer_window_period_min = 1

# --- Target: Databricks
# Follow the guide to get input values for the loader:
# https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/quick-start-aws
databricks_enabled = false

databricks_catalog    = "hive_metastore"
databricks_schema     = "<SCHEMA>"
databricks_host       = "<HOST>"
databricks_port       = 443
databricks_http_path  = "<HTTP_PATH>"
databricks_auth_token = "<AUTH_TOKEN>"
# This controls how often data will be loading into Databricks
databricks_transformer_window_period_min = 1

# --- Target: Redshift
# Follow the guide to get input values for the loader:
# https://docs.snowplow.io/docs/getting-started-on-snowplow-open-source/quick-start-aws
redshift_enabled = false

redshift_host            = "<HOST>"
redshift_database        = "<DATABASE>"
redshift_port            = 5439
redshift_schema          = "<SCHEMA>"
redshift_loader_user     = "<LOADER_USER>"
redshift_loader_password = "<PASSWORD>"
# This controls how often data will be loading into Redshift
redshift_transformer_window_period_min = 1

# --- ADVANCED CONFIGURATION ZONE --- #

# Controls the write throughput of the KCL tables maintained by the various consumers deployed
pipeline_kcl_write_max_capacity = 50
# A boundary policy ARN (e.g. "arn:aws:iam::0000000000:policy/MyAccountBoundary")
iam_permissions_boundary = ""

# See for more information: https://registry.terraform.io/modules/snowplow-devops/collector-kinesis-ec2/aws/latest#telemetry
# Telemetry principles: https://docs.snowplowanalytics.com/docs/open-source-quick-start/what-is-the-quick-start-for-open-source/telemetry-principles/
user_provided_id  = ""
telemetry_enabled = false

# CloudWatch logging to ensure logs are saved outside of the server
cloudwatch_logs_enabled        = false
cloudwatch_logs_retention_days = 1

# Extra Tags to append to created resources (optional)
tags = {
  "owners"           = "analytics"
  "metadata:owners"  = "analytics"
  "metadata:feature" = "iglupipeline"
}
