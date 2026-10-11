resource "local_file" "greeting" {
  filename = "${var.output_dir}/greeting-${var.name}.txt"
  content  = "Hello, ${var.name}!\n"
}
