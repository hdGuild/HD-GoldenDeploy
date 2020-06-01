# variables values for terraform deployment

# generic variables
region = "FRA1"

# security variables
# fullpath for pat and security files that stay on workstation 
fullpath_do_token_file = "C:\\users\\Philippe\\.pat\\hdguild2do.token"  # PAT replace passwords -> used for provider.tf connection

# server variables
server_image = "ubuntu-18-04-x64"
server_name = "hdguild-website"
server_size = "s-1vcpu-1gb" # minimal configuration - enought for tests
ssh_key_id = "27305903" #PC_Eurynome_id_rsa on Digital Ocean

# connection to server variables 
server_root_name = "root"
connectionType = "ssh" # winrm on windows \\ ssh on linux

# init server variables
initial_server_setup_script = "../scripts/initial_ubuntu_server_setup.sh"
initial_lemp_setup_script = "../scripts/initial_lemp_setup.sh"