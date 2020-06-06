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
variable "floating_ip" {}
variable "domain_name" {}

# init server variables
variable "initial_server_setup_script" {}
variable "initial_lemp_setup_script" {}
variable "initial_letsencrypt_setup_script" {}