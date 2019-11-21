kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller   --clusterrole=cluster-admin   --serviceaccount=kube-system:tiller
helm init --service-account tiller

kubectl create secret generic airflow-postgres --from-literal=postgres-password=$(openssl rand -base64 13) --namespace datahub

kubectl create secret generic git-secret --from-file=id_ed25519=ssh_files/id_ed25519 --from-file=known_hosts=ssh_files/known_hosts --from-file=id_ed25519.pub=ssh_files/id_ed25519.pub --namespace datahub

kubectl create secret generic credentials --from-file=credentials=aws_credentials --namespace datahub
kubectl create secret generic gcp-credentials --from-file=gcp_credentials.json --namespace datahub


helm repo update

cd libero-datahub/
helm dependency update

helm install .
helm del --purge datahub-pipeline

helm upgrade --install datahub-pipeline . --namespace datahub --values ../Values.yaml
helm upgrade --install datahub-pipeline . --namespace datahub --values ../Values.yaml

helm status datahub-pipeline
kubectl get svc --namespace datahub
