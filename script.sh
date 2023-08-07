#!/bin/bash
hostUrl=$1
projectKey=$2
token=$3
targetPath=$4
feed=$5
gitPat=$6
# parameters="${@:7}"
echo "hostUrl:" $hostUrl # {sonarqube url}
echo "projectKey:" $projectKey # {project key}
echo "targetPath:" $targetPath # {project or solution directory name}
echo "feed:" $feed # {nuget feed url}
# echo "parameters: " $parameters

if [ -n "$feed" ] && [ -n "$gitPat" ]; then
    export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"$feed\", \"password\":\"$gitPat\"}]}"
fi

echo "Running sonnarscanner commands against $targetPath" # with parameters $parameters"
dotnet sonarscanner begin /key:"$projectKey" /d:sonar.host.url="$hostUrl" /d:sonar.login="$token"
if [ -n "$feed" ] && [ -n "$gitPat" ]; then
    dotnet restore $targetPath -s "$feed" -s "https://api.nuget.org/v3/index.json"
else
    dotnet restore $targetPath
fi
dotnet build $targetPath --no-restore
dotnet sonarscanner end /d:sonar.login="$token"
