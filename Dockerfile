FROM progrium/buildstep
MAINTAINER Fernando Mayo <fernando@tutum.co>

ADD run.sh /run.sh
RUN chmod +x /run.sh

ONBUILD RUN mkdir -p /app
ONBUILD ADD . /app
ONBUILD RUN /build/builder

ENTRYPOINT ["/run.sh"]
