#!/bin/bash
hostUrl=$1
projectKey=$2
token=$3
targetPath=$4
parameters="${@:5}"
echo "projectKey:" $projectKey # {project key}
echo "targetPath:" $targetPath # {project or solution directory name}
echo "parameters: " $parameters

echo "Running sonnarscanner commands against $targetPath with parameters $parameters"
dotnet sonarscanner begin /key:"$projectKey" /d:sonar.host.url="$hostUrl" /d:sonar.login="$token"
dotnet build $targetPath
dotnet sonarscanner end /d:sonar.login="$token"
