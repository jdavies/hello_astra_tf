terraform {
 required_version = ">= 1.0.0"
 required_providers {
   astra = {
     source = "datastax/astra"
     version = ">=1.0.0"
   }
 }
}


# Output the security information
output "organization_id" {
  value = var.organization_id
  description = "The organization ID"
}

output "database_id" {
  value = astra_database.hello_astra_db.id
  description = "Test Description"
}

output "token" {
  value = astra_token.api_token.token
  description = "Token information - DO NOT LOSE"
}

output "client_secret" {
  value = astra_token.api_token.secret
  description = "Token information - DO NOT LOSE"
}

output "client_id" {
  value = astra_token.api_token.client_id
  description = "Token information - DO NOT LOSE"
}

output "cqlsh_url" {
  value = astra_database.hello_astra_db.cqlsh_url
  description = "CQL Shell URL"
}

output "graphql_url" {
  value = astra_database.hello_astra_db.graphql_url
  description = "GraphQL URL"
}

output "data_endpoint_url" {
  value = astra_database.hello_astra_db.data_endpoint_url
  description = "Data Endpoint URL (REST API)"
}

output "grafana_url" {
  value = astra_database.hello_astra_db.grafana_url
  description = "Grafana URL"
}

### These commands are not displayed after the "apply"
output "replication_factor" {
  value = astra_database.hello_astra_db.replication_factor
  description = "Replicaion Factor"
}

output "node_count" {
  value = astra_database.hello_astra_db.node_count
  description = "Node Count"
}

output "total_storage" {
  value = astra_database.hello_astra_db.total_storage
  description = "Total Storage (GB?)"
}