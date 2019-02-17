# **Devops Challenge for GCP cloud**
## Pre-requisite - 
   1. Google Cloud Platform account
   2. Google service account with Storage Admin & Cloud Datastore Owner and download the key file
   3. Docker hub account
   4. gcloud cli
   5. helm

## Steps to follow, before executing script 
   1. Clone this git repo
   2. Modify Dockerbuild.sh file, with your specific settings - 
      * Docker login
      * Docker parameters
      * Modify docker file - 
      * Copy key file
      * Configure and set GOOGLE_APPLICATION_CREDENTIALS env variable 

## Script example
   1. Execute chmod 755 Dockerfile
   2. "./Dockerbuild.sh"
   3. kubectl get svc <applabel>   
