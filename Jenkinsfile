pipeline {
  agent any

  environment {
    product_flavour = "qa"
    version_code = "1"
    version_name = "1.0"
    build_type = "release"
  }

  stages {
    stage("build") {
        steps {
          sh 'echo "##############################"'
            sh 'echo "Build started..."'
            sh 'echo "Build params- $product_flavour, $version_code, $version_name, $build_type"'
            sh chmod +x jenkins_build.sh
            sh jenkins_build.sh "$product_flavour" "$version_code" "$version_name" "$build_type"
        }
    }
    
    stage("test") {
      environment {
        artifacts = "app/artifacts"
      }
      steps {
        sh 'echo "##############################"'
        sh 'echo "App build created and this stage will test build existed in $artifacts"'
      }
    }
    
    stage("deploy") {
      steps {
        sh 'echo "##############################"'
        sh 'echo "Now its time to deploy build over Hockey app."'
        sh 'echo "!!!!!!!!Pipeline process done!!!!!!!!"'
      }
    }
  }
}
