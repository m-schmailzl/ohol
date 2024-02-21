FROM debian:12 AS build
ARG GAME_VERSION

RUN apt-get update && apt-get install -y git g++ make

COPY fetch.sh /
RUN chmod +x /fetch.sh && /fetch.sh

COPY build.sh /
RUN chmod +x /build.sh && /build.sh



FROM debian:12
LABEL maintainer="maximilian@schmailzl.net"

COPY --from=build /opt/OneLife/server /opt/OneLife/server
COPY --from=build /opt/OneLifeData7 /opt/OneLifeData7
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME "/opt/OneLife/server/data"

EXPOSE 8005

ENTRYPOINT [ "/entrypoint.sh" ]
