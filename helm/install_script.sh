helm repo update

cd libero-datahub/
helm dependency update
 helm install .


helm upgrade --install datahub-pipeline . --namespace datahub --values ../Values.yaml