elifePipeline {
    node('containers-jenkins-plugin') {
        stage 'Checkout', {
            checkout scm
        }

        stage 'Helm lint chart', {
            sh "make helm-lint-charts"
        }

        elifeTagOnly { tag ->
            stage 'Publish helm chart', {
                sh "make push-charts-to-s3-repo"
            }
        }
    }
}
