FROM progrium/buildstep:latest
MAINTAINER Fernando Mayo <fernando@tutum.co>

ADD run.sh /run.sh
RUN rm -fr /app

ONBUILD ADD . /app
ONBUILD RUN /build/builder

ENTRYPOINT ["/run.sh"]
