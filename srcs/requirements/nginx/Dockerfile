FROM debian:latest

RUN apt update && apt install -y nginx \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY tools/rkanmado.42.fr.crt /etc/nginx/ssl/rkanmado.42.fr.crt
COPY tools/rkanmado.42.fr.key /etc/nginx/ssl/rkanmado.42.fr.key

COPY conf/nginx /etc/nginx/sites-available/rkanmado.42.fr

RUN ln -s /etc/nginx/sites-available/rkanmado.42.fr /etc/nginx/sites-enabled/rkanmado.42.fr

RUN chmod 777 /etc/nginx/ssl/rkanmado.42.fr.crt && \
    chmod 777 /etc/nginx/ssl/rkanmado.42.fr.key

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]