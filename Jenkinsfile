elifePipeline {
    def commit
    def DockerImage image
    def DockerImage approved

    node('containers-jenkins-plugin') {
        stage 'Checkout', {
            checkout scm
            commit = elifeGitRevision()
        }
        stage 'Build images', {
            sh 'docker build ./helm -t elifesciences/datahub-airflow'
            image = DockerImage.elifesciences(this, "datahub-airflow", "latest")
        }

        stage 'Push images', {
             latest = image.tag('latest').push()
        }
    }
}
