AGCO/buildstep
==============

A fork of [tutum/buildstep](https://github.com/tutumcloud/buildstep) with helpers for local/CI builds.


Base docker image to create containers from app code using Heroku's buildpacks.


Supported languages
-------------------

Check https://github.com/progrium/buildstep#supported-buildpacks for a list of buildpacks
supported.


Usage
-----

### Pulling from a local repo

This fork allows pushing the code from the current folder straight into a container, no build needed.

	# Without a Procfile
	docker run -d -p 80 -e USE_LOCAL_REPO=true agco/buildstep python manage.py runserver 80

	# With a Procfile (or relying on the default Procfile provided by the buildpack)
	docker run -d -p 80 -e USE_LOCAL_REPO=true agco/buildstep /start web

That allows easy integration with fig and CI tools, as it reduces the risk of image naming clashes. Sample fig file:
  db:
    image: dockerfile/mongodb
    expose:
      - "27017"
  web:
    image: agco/buildstep
    command: /start web
    volumes:
      - .:/localrepo/
    environment:
      NPM_CONFIG_PRODUCTION: false
      USE_LOCAL_REPO: true
    ports:
      - "9000"
    links:
      - db

Points worth mentioning are:
* The "volumes" instruction in fig.xml is required so the container can use the local folder. This makes this approach not suitable for production deployments;
* USE_LOCAL_REPO is used to instruct the container script to use the local volume;
* This approach allows the setting up of environment variables prior to a buildstep execution, meaning that setting up variables such as NPM_CONFIG_PRODUCTION (that causes the buildpack to run as a development build).

### Pulling from a remote repo

You can also make it run your application on the fly (without having to create or build a `Dockerfile`)
by passing an environment variable `GIT_REPO` with your application's git repository URL.

If your repository has a `Procfile` (or the buildpack you are using has a default `Procfile`), 
you can specify the process type name as the run command.
Otherwise, you can specify the actual command used to launch your application as the run command. For example:

	# Without a Procfile
	docker run -d -p 80 -e GIT_REPO=https://github.com/fermayo/hello-world-django.git agco/buildstep python manage.py runserver 80

	# With a Procfile (or relying on the default Procfile provided by the buildpack)
	docker run -d -p 80 -e GIT_REPO=https://github.com/fermayo/hello-world-php.git agco/buildstep /start web

No `docker build` required!


### Dockerfile + Procfile

If you have already defined a `Procfile` (https://devcenter.heroku.com/articles/procfile)
like the following:

	web: python manage.py runserver 80

you can use it by defining the following `Dockerfile`:

	FROM agco/buildstep
	EXPOSE 80
	CMD ["/start", "web"]

Modify the `EXPOSE` and `CMD` directives with the port to be exposed and the process
type defined in the `Procfile` used to launch your application respectively.

It also works if you don't have a Procfile

Then, execute the following to build the image:

	docker build -t myuser/myapp .
	docker run -d -p 80 myuser/myapp

Done!

### Dockerfile only

Create a `Dockerfile` similar to the following in your application code folder 
(this example is for a typical Django app):

	FROM agco/buildstep
	EXPOSE 80
	CMD ["python", "manage.py", "runserver", "80"]

Modify the `EXPOSE` and `CMD` directives with the port to be exposed and the command
used to launch your application respectively.

Then, execute the following to build the image:

	docker build -t myuser/myapp .

This will create an image named `myuser/myapp` with your application ready to go.
To launch it, just type:

	docker run -d -p 80 myuser/myapp

Easy!
