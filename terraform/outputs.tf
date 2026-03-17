output "health_check_id" {
  description = "Health check self link"
  value       = google_compute_health_check.mig_demo.self_link
}

output "backend_service_id" {
  description = "Backend service self link"
  value       = google_compute_backend_service.mig_demo.self_link
}

output "backend_service_name" {
  description = "Backend service name for Harness pipeline"
  value       = google_compute_backend_service.mig_demo.name
}

output "http_route_name" {
  description = "HTTPRoute name for Harness pipeline"
  value       = google_network_services_http_route.mig_demo.name
}

output "backend_service_path" {
  description = "Full backend service path for Harness Blue-Green Deploy step"
  value       = "projects/${var.project_id}/locations/global/backendServices/${google_compute_backend_service.mig_demo.name}"
}

output "http_route_path" {
  description = "Full HTTPRoute path for Harness Blue-Green Deploy step"
  value       = "projects/${var.project_id}/locations/global/httpRoutes/${google_network_services_http_route.mig_demo.name}"
}
