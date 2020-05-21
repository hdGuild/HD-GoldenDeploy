# variables file for terraform deployment

# generic variables
variable "region" {}

# security variables
variable "fullpath_do_token_file" {}

# server variables
variable "server_image" {}
variable "server_name" {}
variable "server_size" {}
variable "ssh_key_id" {} # id of DigitalOcean user sshkey to add to droplet

# connection to server variables 
variable "server_root_name" {}
variable "connectionType" {}

# init server variables
variable "initial_server_setup_script" {}
