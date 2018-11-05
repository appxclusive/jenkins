pipeline {
  agent any

  environment {
    // FOO will be available in entire pipeline
    FOO = "PIPELINE_YOYO"
  }

  stages {
    stage("build") {
        steps {
            
        }
    }
    stage("local") {
      environment {
        // BAR will only be available in this stage
        BAR = "STAGE_HUHU"
      }
      steps {
        sh 'echo "FOO is $FOO and BAR is $BAR"'
      }
    }
    stage("global") {
      steps {
        sh 'echo "FOO is $FOO and BAR is $BAR"'
      }
    }
  }
}
