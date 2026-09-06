resource local_file "my_file" {
  filename = "automate.txt"
  content = "Automatically Created File On Start"
  file_permission = 0744
  directory_permission = 0744
}