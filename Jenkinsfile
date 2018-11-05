pipeline {
  agent any

  environment {
    product_flavour = "qa"
    version_code = "4"
    version_name = "4.0"
    build_type = "release"
  }

  stages {
    stage("build") {
        steps {
          sh 'echo "##############################"'
            sh 'echo "Build started..."'
            sh 'echo "Build params- $product_flavour, $version_code, $version_name, $build_type"'
            sh 'chmod +x jenkins_build.sh'
            sh './jenkins_build.sh "$product_flavour" "$version_code" "$version_name" "$build_type"'
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
        hockeyApp applications: [[apiToken: 'd56b35a261c04c3982a17ed9086822c8', downloadAllowed: true, filePath: 'artifacts/', mandatory: true, notifyTeam: true, releaseNotesMethod: none(), uploadMethod: appCreation(false)]], debugMode: false, failGracefully: false
        sh 'echo "!!!!!!!!Pipeline process done!!!!!!!!"'
      }
    }
  }
}
