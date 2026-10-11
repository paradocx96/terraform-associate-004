output "file_path" {
  value       = local_file.greeting.filename
  description = "Path of the generated greeting file"
}
