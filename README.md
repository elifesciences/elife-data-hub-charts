# eLife Data-Hub Charts
This reposistory consists of the different helm charts that are used for creating diferent eLife-Data-Hub  Kubernetes Objects.
Below is the list of the Helm charts present in this repo.

### Data-Hub
This is the main data hub helm chart. The implementation simplifies and combines the following helm charts
- https://github.com/helm/charts/tree/master/stable/airflow
- https://github.com/dask/helm-chart/tree/master/dask

It also extends them with data-hub specific functionalities.
Below are the main components present
- Airflow webserver
  - Provides Admin Web UI
- Airflow scheduler
  - Manages when to execute a pipeline or task
- Dask scheduler
  - Determines on which pod or worker node to execute a task
- Dask worker node
  - Runs airflow task
- Postgres
  - A dependency of the helm chart for persisting information about task execution schedules and other relevant airflow information
 
 Note that airflow implementation is configured to use DaskExecutor. DaskExecutor was selected over CeleryExecutor because of  the following:
 -  The initial plan to use the use the distributed dask framework for **distributed execution** of
    - Some single list/array processing task
    - Graph based analytics e.g. influential persons within elife's twitter network using tools like networks 
    - Stream processing using streamz
 -  DaskExecutor has one less moving parts than CeleryExecutor
 
####  Values
Detailed documentation of the meanings, and expected values of the entities of the values.yaml file are present in the [values.yaml](https://github.com/elifesciences/elife-data-hub-charts/blob/develop/helm/data-hub/values.yaml) file

## CI/CD
This lints the helm chart. 
The creation of  release packages the chart, and pushes it into the eLife's S3 based Helm Chart Repo