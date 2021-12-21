locals {
  keyspace = "helloastra"
}

# Create the database on AWS
resource "astra_database" "hello_astra_db" {
  name           = "hello_astra_tf"
  keyspace       = local.keyspace
  cloud_provider = "aws"
  region         = "us-west-2"
}

# Create the database on Google Cloud Platform.
# resource "astra_database" "hello_astra_db" {
#   name           = "hello_astra_tf"
#   keyspace       = local.keyspace
#   cloud_provider = "gcp"
#   region         = "us-west1"
# }


resource "astra_role" "hello_admin" {
  role_name   = "hello_admin"
  description = "Database administrator for the hello_astra database"
  effect      = "allow"
  # Select the resources for which we will create policies
  resources   = [
    # Identify our organization
    "drn:astra:org:${var.organization_id}", 
    # Select the database we want to use
    "drn:astra:org:${var.organization_id}:db:${astra_database.hello_astra_db.id}",
    # Specify the keyspace to which we need access
    "drn:astra:org:${var.organization_id}:db:${astra_database.hello_astra_db.id}:keyspace:${local.keyspace}",
    # Select all of the tables in the database/keyspace
    "drn:astra:org:${var.organization_id}:db:${astra_database.hello_astra_db.id}:keyspace:${local.keyspace}:table:*"
    ]
  policy      = [
    # Organization level policies
    # "org-audits-read", "org-billing-read", "org-billing-write", 
    # "org-external-auth-read", "org-external-auth-write", 
    # "org-notification-write", "org-read", "org-role-delete",
    # "org-role-read", "org-role-write", "org-token-read",
    # "org-token-write", "org-user-read", "org-user-write", 
    # "org-write", "accesslist-read", "accesslist-write",

    # Database level policies
    "db-cql", "db-graphql", "db-rest", 
    # "org-db-addpeering", "db-manage-privateendpoint",
    # "org-db-create", "org-db-expand", "org-db-managemigratorproxy", 
    # "org-db-passwordreset", "org-db-suspend", "org-db-terminate",
    # "org-db-view", "db-manage-region", 

    # Keyspace
    "db-keyspace-alter", "db-keyspace-authorize", "db-keyspace-create", 
    "db-keyspace-describe", "db-keyspace-drop", "db-keyspace-grant", 
    "db-keyspace-modify", "db-all-keyspace-create", 
    "db-all-keyspace-describe",
    
    # Table Access
    "db-table-alter", "db-table-authorize", "db-table-create", 
    "db-table-describe", "db-table-drop", "db-table-grant",
    "db-table-modify", "db-table-select",  
    ]
}

# Create a security token for our hello_admin role
resource "astra_token" "api_token" {
roles = [astra_role.hello_admin.role_id]
}