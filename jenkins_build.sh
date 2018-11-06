#!/bin/bash

# input params
productFlavour=$1
versionCode=$2
versionName=$3
buildType=$4
#storePass=$6
#keyAlias=$7
#keyPass=$8

# -----------------------------------------------------------------
# ------------------------------ BUILD ----------------------------
# -----------------------------------------------------------------
propertiesFile='gradle.properties'
chmod +x ${propertiesFile}

# helper method
setProperty() {
	sed -i -e "s/\($1 *= *\).*/$1=$2/g" ${propertiesFile}
}

# update key properties based on build type
(setProperty "versionCode" $versionCode)
(setProperty "versionName" $versionName)

#if [ $buildType = 'debug' ]; then
#	(setProperty "KEYSTORE" "debug.keystore")
#	(setProperty "STORE_PASSWORD" "android")
#	(setProperty "KEY_ALIAS" "androiddebugkey")
#	(setProperty "KEY_PASSWORD" "android")
#elif [ $buildType = 'release' ]; then
#	(setProperty "KEYSTORE" "smb-apps.jks")
#	(setProperty "STORE_PASSWORD" "$storePass")
#	(setProperty "KEY_ALIAS" "$keyAlias")
#	(setProperty "KEY_PASSWORD" "$keyPass")
#fi

# clean project
chmod +x gradlew
./gradlew clean --stacktrace


# build
capitalize()
{
	value=$1
	value=${value,,}
	value=${value^}
	echo $value
}

#if [ $productFlavour = 'null' ]; then
#./gradlew "assemble"`capitalize $buildType` --stacktrace
#else
./gradlew "assemble"`capitalize $productFlavour``capitalize $buildType` --stacktrace

#if [ $buildType = 'debug' ]; then
#	./gradlew assembleDebug --stacktrace
#elif [ $buildType = 'release' ]; then
#	./gradlew assembleRelease --stacktrace
#fi


# -----------------------------------------------------------------
# -------------------------- POST BUILD ---------------------------
# -----------------------------------------------------------------
apkFileName="jenkins-v$versionName-$productFlavour-$buildType.apk"
rm -r artifacts/
mkdir artifacts

# copy apk to artifacts
if [ ! -e "app/build/outputs/apk/$productFlavour/$buildType/$apkFileName" ]; then
    echo "ERROR: File not exists: (app/build/outputs/apk/$productFlavour/$buildType/$apkFileName)"
    exit 1
fi
cp app/build/outputs/apk/$productFlavour/$buildType/$apkFileName artifacts/