#!/bin/bash

ENV_NAME=datahub-test

CROSSREF_CONFIG_S3_BUCKET="airflow.customEnvironmentVariables.CROSSREF_CONFIG_S3_BUCKET=ci-elife-data-pipeline"
CROSS_REF_IMPORT_SCHEDULE_INTERVAL='airflow.customEnvironmentVariables.CROSS_REF_IMPORT_SCHEDULE_INTERVAL=@daily'
CORE_DAG_GIT_REPO_URL='dags.git.git_urls[0].url=git@github.com:elifesciences/datahub-core-airflow-dags.git'
CORE_DAG_REPO_URL_NAME='dags.git.git_urls[0].name=core_dag'
CORE_DAG_REPO_URL_REF='dags.git.git_urls[0].ref=6dce408'
CORE_DAG_REPO_INSTALL_PRIORITY='dags.git.git_urls[0].installPriority=1'

helm upgrade --install libero-datahub--$ENV_NAME . --set $CROSSREF_CONFIG_S3_BUCKET,$CROSS_REF_IMPORT_SCHEDULE_INTERVAL,$CORE_DAG_GIT_REPO_URL,$CORE_DAG_REPO_URL_NAME,$CORE_DAG_REPO_INSTALL_PRIORITY,$CORE_DAG_REPO_URL_REF

