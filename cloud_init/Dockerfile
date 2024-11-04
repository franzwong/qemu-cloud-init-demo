FROM ubuntu:jammy-20240911.1

RUN apt update && apt install -y cloud-init genisoimage

WORKDIR /app

COPY entrypoint.sh ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
