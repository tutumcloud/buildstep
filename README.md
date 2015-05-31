tutum/buildstep
===============

Base docker image to create containers from app code using Heroku's buildpacks.


Supported languages
-------------------

Check https://github.com/progrium/buildstep#supported-buildpacks for a list of buildpacks
supported.


Usage
-----

Create a `Dockerfile` similar to the following in your application code folder 
(this example is for a typical Django app):

```Dockerfile
FROM tutum/buildstep
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "8000"]
```

Modify the `EXPOSE` and `CMD` directives with the port to be exposed and the command
used to launch your application respectively.

Then, execute the following to build the image:

	docker build -t myuser/myapp .

This will create an image named `myuser/myapp` with your application ready to go.
To launch it, just type:

	docker run -d -p 8000 myuser/myapp

Easy!


Usage with Procfile
-------------------

If you have already defined a `Procfile` (https://devcenter.heroku.com/articles/procfile)
like the following:

	web: python manage.py runserver 8000

you can use it by defining the following `Dockerfile` instead:

```Dockerfile
FROM tutum/buildstep
EXPOSE 8000
CMD ["/start", "web"]
```

Modify the `EXPOSE` and `CMD` directives with the port to be exposed and the process
type defined in the `Procfile` used to launch your application respectively.

It also works if you don't have a Procfile

Then, execute the following to build the image:

	docker build -t myuser/myapp .
	docker run -d -p 8000 myuser/myapp

Done!


On-the-fly usage
----------------

You can also make it run your application on the fly (without having to create or build a `Dockerfile`)
by passing an environment variable `GIT_REPO` with your application's git repository URL.

If your repository has a `Procfile` (or the buildpack you are using has a default `Procfile`), 
you can specify the process type name as the run command.
Otherwise, you can specify the actual command used to launch your application as the run command. For example:

	# Without a Procfile
	docker run -d -p 8000 -e GIT_REPO=https://github.com/fermayo/hello-world-django.git tutum/buildstep python manage.py runserver 8000

	# With a Procfile (or relying on the default Procfile provided by the buildpack)
	docker run -d -p 8000 -e GIT_REPO=https://github.com/fermayo/hello-world-php.git tutum/buildstep /start web

No `docker build` required!
