resource "google_sql_database_instance" "mysql-from-tf" {
  name                = "mysql-from-tf"
  deletion_protection = false
  database_version    = "MYSQL_8_0"
  region              = "us-central1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "mastengkorak"
  instance = google_sql_database_instance.mysql-from-tf.name
  # host     = "me.com"
  password = "Pow3ranger"

}
# Cloud SQL
# source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

# Sloud SQL User
# source: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user