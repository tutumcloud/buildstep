FROM progrium/buildstep
MAINTAINER Diogo Lucas <diogo.lucas@agcocorp.com>

ADD run.sh /run.sh
RUN chmod +x /run.sh

ONBUILD RUN mkdir -p /app
ONBUILD ADD . /app
ONBUILD ADD /env /tmp/env
ONBUILD RUN /build/builder

ENTRYPOINT ["/run.sh"]
