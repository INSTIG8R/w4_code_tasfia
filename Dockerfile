FROM python:3.9-slim

RUN groupadd --gid 1000 appuser \
    && useradd --uid 1000 --gid 1000 -ms /bin/bash appuser
RUN pip3 install --no-cache-dir --upgrade \
    pip \
    virtualenv
RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    git

USER appuser
WORKDIR /home/appuser
COPY . /home/appuser

ENV VIRTUAL_ENV=/home/appuser/venv
RUN virtualenv ${VIRTUAL_ENV}
RUN . ${VIRTUAL_ENV}/bin/activate 
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
#RUN pip install --upgrade pip && pip install -r requirements.txt
EXPOSE 80
RUN mkdir ~/.streamlit
RUN cp config.toml ~/.streamlit/config.toml
RUN cp credentials.toml ~/.streamlit/credentials.toml
WORKDIR /app
COPY run.sh /app
ENTRYPOINT ["./run.sh"]
#ENTRYPOINT ["streamlit", "run"]
#CMD ["streamScript.py"]