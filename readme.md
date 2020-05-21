# HD-WebSiteDeploy project

## about project

this project is to deploy Hell Dorado WebSite on a LEMP server.
The project will have the necessary structure and sources to be used by a CI-CD 
jenkins pipeline.

The jenkins server is deployed by "JenkinsServerOnDO" github project.

## folders description

The build folder will contains all source-code to deploy infrastructure and applications to help website deployment.

the build/golden folder contains prerequisites deployment before automated pipelines to be used.

the deploy folder will contains the jenkins pipelines and the scripts that will helps the deployment itself.

## prerequisites

the jenkins pipelines have to be used by the jenkinsserveronDO jenkins server.
Knowing that, the link have to be made between these servers.

## Storyline

    0. Terraform code to deploy an Ubuntu server on DigitalOcean
    1. use jenkins to deploy terraform ubuntu server on DO
    2. add Ansible to server deployed
    3. ansible deploy of LEMP server on ubuntu server
    4. use jenkins to do setps from 2 to 3 above.
    
