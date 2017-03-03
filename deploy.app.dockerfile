FROM alpine:3.5

ARG GIT_COMMIT=unkown
LABEL syros.revision=$GIT_COMMIT
ARG GIT_BRANCH=unkown
LABEL syros.branch=GIT_BRANCH
ARG APP_VERSION=unkown
LABEL syros.version=$APP_VERSION
ARG BUILD_DATE=unkown
LABEL syros.build=BUILD_DATE
LABEL syros.maintainer "Stefan Prodan"

EXPOSE 8888

COPY /dist/ui /syros/dist
COPY /dist/api /syros/api
RUN chmod 777 /syros/api

WORKDIR /syros
ENTRYPOINT ["/syros/api"]
