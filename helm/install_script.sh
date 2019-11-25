#!/bin/bash


ENV_NAME=datahub-test
kubectl create namespace  $ENV_NAME

kubectl create secret generic airflow-postgres --from-literal=postgres-password=$(openssl rand -base64 13) --namespace $ENV_NAME  --dry-run -o yaml | kubectl apply -f -
kubectl create secret generic git-secret --from-file=id_ed25519=ssh_files/id_ed25519 --from-file=known_hosts=ssh_files/known_hosts --from-file=id_ed25519.pub=ssh_files/id_ed25519.pub --namespace $ENV_NAME --dry-run -o yaml | kubectl apply -f -
kubectl create secret generic credentials --from-file=credentials=aws_credentials --namespace $ENV_NAME --dry-run -o yaml |   kubectl apply -f -
kubectl create secret generic gcp-credentials --from-file=gcp_credentials.json --namespace $ENV_NAME --dry-run -o yaml |   kubectl apply -f -
kubectl create secret generic google-auth --from-literal=AIRFLOW__GOOGLE__CLIENT_ID=695016906402-mecqelms5qrafv3j3mrf3k2o1btrm17j.apps.googleusercontent.com --from-literal=AIRFLOW__GOOGLE__CLIENT_SECRET=G-wmIA-bFS2jySrPYafMAj1H --namespace $ENV_NAME --dry-run -o yaml  |   kubectl apply -f -


helm repo update
helm dependency update

helm upgrade --install datahub-pipeline-test . --namespace datahub-test


var1=airflow.customEnvironmentVariables.CROSSREF_CONFIG_S3_BUCKET
var1_val=ci-elife-data-pipeline
var2=airflow.customEnvironmentVariables.CROSS_REF_IMPORT_SCHEDULE_INTERVAL
var2_val="@daily"
helm upgrade --install datahub-pipeline . --namespace datahub  --set $var2=$var2_val,$var1=$var1_val
helm status datahub-pipeline
kubectl get svc --namespace datahub
	https://libero-datahub-pipeline--test.elifesciences.org/oauth2callback