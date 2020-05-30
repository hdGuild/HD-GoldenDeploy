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

    00. DONE - Terraform code to deploy an Ubuntu server on DigitalOcean
    05. Shell script to init Ubuntu server
    10. use jenkins to deploy terraform ubuntu server on DO
    20. add Ansible to server deployed
    30. ansible deploy of LEMP server on ubuntu server
    40. use jenkins to do the above 2 to 3 steps.
