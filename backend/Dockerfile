# pull official base image
FROM python:3.8.1-slim-buster

# set work directory
WORKDIR /app

# set environment variables
ENV FLASK_ENV  development
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt


# copy project
COPY . /app/


EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "main:app"]