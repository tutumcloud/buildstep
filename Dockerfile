FROM progrium/buildstep
MAINTAINER Fernando Mayo <fernando@tutum.co>

ONBUILD RUN mkdir -p /app
ONBUILD ADD . /app
ONBUILD RUN /build/builder

ENTRYPOINT ["/exec"]