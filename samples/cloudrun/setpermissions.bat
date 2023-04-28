# Script to create a service account identity to be used by Terraform script 
# for provisioning CloudRun with web hook
# Parameter 1 is the service account name
# Parameter 2 is GCP project name
SVCNAME=$2@$1.iam.gserviceaccount.com
SVCACCNAME=serviceAccount:$SVCNAME
echo $SVCNAME
echo $SVCACCNAME
gcloud iam service-accounts create $2 \
            --display-name="Terraform Service Account"
gcloud projects add-iam-policy-binding $1 \
            --member=$SVCACCNAME --role='roles/editor'
gcloud projects add-iam-policy-binding $1 \
            --member=$SVCACCNAME --role='roles/iam.serviceAccountAdmin'
gcloud projects add-iam-policy-binding $1 \
            --member=$SVCACCNAME --role='roles/resourcemanager.projectIamAdmin'
gcloud projects add-iam-policy-binding $1 \
            --member=$SVCACCNAME --role='roles/run.admin'
gcloud projects list | \
  awk '{print $1}' | \
  xargs -I % sh -c "echo ""; echo project:% && \
  gcloud projects get-iam-policy % \
  --flatten='bindings[].members' \
  --format='table(bindings.role)' \
  --filter=$SVCNAME \
  ;" 
 
