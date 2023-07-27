#
# Build stage
#
FROM python:3.9.17-slim-bullseye as build

WORKDIR /usr/src/app

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install git -y

RUN pip install --upgrade pip
RUN pip install \
      toml

COPY . .

RUN python3 /usr/src/app/list_builder.py

#
# Final image
#
FROM nginx

LABEL org.opencontainers.image.authors="pbrisacier@mncc.fr"

COPY --from=build /usr/src/app/builds /usr/share/nginx/html
