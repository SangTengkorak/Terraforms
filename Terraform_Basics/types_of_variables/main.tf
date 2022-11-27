resource "local_file" "sample_res" {
  filename = var.thefilename
  content  = var.thecontent["name"]
}