elifePipeline {
    node('containers-jenkins-plugin') {
        def commit

        stage 'Checkout', {
            checkout scm
            commit = elifeGitRevision()
        }

        stage 'Helm lint and dry run chart', { 
            sh "helm version"
            sh "helm repo add bitnami https://charts.bitnami.com/bitnami"
            sh "make helm-dependency-update"
            sh "make helm-lint-charts"
            sh "make helm-dry-run-charts"
        }

        elifeMainlineOnly {
            stage 'Merge to master', {
                elifeGitMoveToBranch commit, 'master'
            }
        }

        elifeTagOnly { tag ->
            stage 'Publish helm chart', {
                sh "make S3_REPO_PREFIX=alfred push-charts-to-s3-repo"
            }
        }
    }
}
