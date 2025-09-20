FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=4499
RUN apt-get update && \
 apt-get install -y --no-install-recommends \
 fortune-mod cowsay netcat procps ca-certificates \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh
EXPOSE 4499
CMD ["/app/wisecow.sh"]
