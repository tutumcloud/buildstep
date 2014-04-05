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

	FROM tutum/buildstep
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