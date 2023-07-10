# Use the following command to build the image locally:
# versions: 5.13

$tag='5.13'
docker build -t sonar-scanner-net:${tag} --build-arg VERSION=${tag} -f Dockerfile .
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
docker run -it --rm --name test-sq -v /var/run/docker.sock:/var/run/docker.sock -v /c/s/calculator:/app/calculator $img sh
# inside the container
./script.sh http://20.213.170.182 ZZ-SECaaS-Test-001 *** /app/calculator/api/Calculator.Web.Api.sln
