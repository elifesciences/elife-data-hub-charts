elifePipeline {
    node('containers-jenkins-plugin') {
        def commit

        stage 'Checkout', {
            checkout scm
            commit = elifeGitRevision()
        }

        stage 'Helm lint chart', {
            sh "make helm-lint-charts"
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
