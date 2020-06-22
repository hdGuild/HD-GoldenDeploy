# terraform main file for ubuntu server deployment

# data "digitalocean_floating_ip" "hdGuild_ip" {
#   region = var.region
#   ip_address = var.floating_ip
#   provider = "digitalocean"
# }


resource "digitalocean_droplet" "hdGuild_WebSite" {
    # generic data
    #tags = local.common_tags
    # vm to deploy
    image = var.server_image
    name = var.server_name
    region = var.region
    size = var.server_size
    ipv6 = true
    private_networking = true
    #ssh key Id from DigitalOcean ssh public key to create new droplet
    # the public ssh key corresponding to the id will be added to the droplet !
    ssh_keys = [var.ssh_key_id]


    # connection to use for provisionning
    connection {
        user = var.server_root_name
        type = var.connectionType
        # no need of private key as the agent as loaded the ssh private key
        #private_key = file(var.fullpath_priv_key_file)
        agent = true
        timeout = "2m"
        host = self.ipv4_address
    }
    # initial setup for server install
    # Do not forgot to add the key to ssh agent before this step !!
    provisioner "remote-exec" {
        scripts = [var.initial_server_setup_script,
                   var.initial_lemp_setup_script
                   # ,var.initial_letsencrypt_setup_script
                   ]
    }
    
}

## no more use of floating ip as costing 
##
# resource "digitalocean_floating_ip_assignment" "hdGuild_floatingip_assign" {
#   ip_address = var.floating_ip
#   droplet_id = digitalocean_droplet.hdGuild_WebSite.id
# }

# install letsencrypt on above lemp server
resource "null_resource" "hdGuild_WebSite_postinstall" {

    # connection to use for provisionning
    connection {
        user = var.server_root_name
        type = var.connectionType
        # no need of private key as the agent as loaded the ssh private key
        #private_key = file(var.fullpath_priv_key_file)
        agent = true
        timeout = "2m"
        host = digitalocean_droplet.hdGuild_WebSite.ipv4_address
    }
    # initial setup for server install
    # Do not forgot to add the key to ssh agent before this step !!
    provisioner "remote-exec" {
        scripts = [var.initial_letsencrypt_setup_script
                   ]
    }
}

## no more use of domain in digitalocean as 
## no more use of floating ip.
##
# resource "digitalocean_domain" "hdguild_domain" {
#   name       = var.domain_name
#   ip_address = var.flvoating_ip
# }
