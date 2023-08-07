FROM mcr.microsoft.com/dotnet/sdk:6.0

ARG VERSION
ENV VERSION ${VERSION}

RUN wget -qO- https://raw.githubusercontent.com/Microsoft/artifacts-credprovider/master/helpers/installcredprovider.sh | bash
ENV NUGET_CREDENTIALPROVIDER_SESSIONTOKENCACHE_ENABLED true

RUN dotnet tool install --global dotnet-sonarscanner --version ${VERSION}
ENV PATH="$PATH:/root/.dotnet/tools"

RUN apt update
RUN apt install default-jre -y
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
ENV PATH="$PATH:$JAVA_HOME/bin"

WORKDIR /app

COPY ./script.sh .
RUN chmod +x ./script.sh

ENTRYPOINT [ "./script.sh" ]
# CMD [ "./script.sh" ]
