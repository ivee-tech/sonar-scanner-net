# Use the following command to build the image locally:
# versions: 5.13

$tag='5.13'
docker build -t sonar-scanner-net:${tag} --build-arg VERSION=${tag} -f Dockerfile .
docker build -t sonar-scanner-net-cmd:${tag} --build-arg VERSION=${tag} -f Dockerfile .
# docker rmi sonar-scanner-net:${tag}

# Tag the image and push to docker hub:

$tag='5.13'
$image='sonar-scanner-net'
$registry='docker.io'
$img="${image}:${tag}"
$ns='daradu' # namespace
docker tag ${img} ${registry}/${ns}/${img}
# requires docker login
docker push ${registry}/${ns}/${img}


# Run the image locally (build with CMD, not ENTRYPOINT):
$tag='5.13'
$image='sonar-scanner-net'
$img = "$($image):$($tag)"
docker run -it --rm --name test-sq -v /var/run/docker.sock:/var/run/docker.sock -v /c/s/calculator:/app/calculator $img bash

docker run -it --rm --name test-sq -v /var/run/docker.sock:/var/run/docker.sock -v /c/s/calculator:/app/calculator $img `
    http://<IP>/ ZZ-SECaaS-Test-001 *** /app/calculator/api/

docker run -it --rm --name test-sq -v /var/run/docker.sock:/var/run/docker.sock -v /c/s/_zipzapp/zz-mortgage-api:/app/zz-mortgage-api $img `
    http://<IP>/ zz-mortgage-api *** /app/zz-mortgage-api/ZipZapp.Mortgage.Api.sln https://pkgs.dev.azure.com/ZipZappAus/_packaging/ZipZappAusFeed/nuget/v3/index.json ***

# non-.NET Core projects:
$tag='4.8'
$image='sonar-scanner-cli'
$registry='docker.io'
$img="${image}:${tag}"
$srcImg = "sonarsource/${image}:${tag}"
docker pull $srcImg
$ns='daradu' # namespace
docker tag ${srcImg} ${registry}/${ns}/${img}
# requires docker login
docker push ${registry}/${ns}/${img}

docker run --rm -e SONAR_HOST_URL="http://<IP>" -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=calculator-ui" `
    -e SONAR_LOGIN="***" -v "/c/s/calculator/ui:/usr/src" `
   daradu/sonar-scanner-cli:4.8

docker run --rm -e SONAR_HOST_URL="http://<IP>" -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=zz-mortgage-ui" `
    -e SONAR_LOGIN="***" -v "/c/s/_zipzapp/zz-mortgage-ui:/usr/src" `
   daradu/sonar-scanner-cli:4.8


# create SQ projects
$project = 'ZZ-SECaaS-Test-004'
$token = '***'
$headers = @{
    # Authorization = "Bearer $token"
    Authorization = "Basic admin:SonarQube2018!"
}
$contentType = 'application/x-www-form-urlencoded'
# $data = @{
#     name = $project
#     project = $project
# } | ConvertTo-Json
$data = "name=$project&project=$project&mainBranch=main"
$url = "http://<IP>/api/projects/create"
# NOT WORKING, ALWAYS 401 :( (even with token)
$response = Invoke-WebRequest -Uri $url -Headers $headers -Method POST -Body $data -ContentType $contentType
$response

# USE GIT bash or WSL terminal in VS Code
project='ZZ-SECaaS-Test-003'
url="http://<IP>/api/projects/create?project=${project}&name=${project}&mainBranch=main"
curl -X POST -u <u>:<p> $url
