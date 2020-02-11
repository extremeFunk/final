<! creating project

gcloud auth login
<! the above is browser based auth
gcloud projects create echo-final-project --name echo-final-project
gcloud config set project echo-final-project
gcloud iam service-accounts create rainrobot
gcloud projects add-iam-policy-binding echo-final-project \
--member "serviceAccount:rainrobot@echo-final-project.iam.gserviceaccount.com" \
--role "roles/owner"
gcloud iam service-accounts keys create gcp_crd.json \
 --iam-account rainrobot@echo-final-project.iam.gserviceaccount.com

<! enable billing for project in console
terraform init
terraform apply