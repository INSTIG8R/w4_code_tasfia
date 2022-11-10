FROM python:3.7-slim
COPY . /app
WORKDIR /app

RUN pip3 install --no-cache-dir --upgrade \
    pip \
    virtualenv
ENV VIRTUAL_ENV=/app/venv
RUN virtualenv ${VIRTUAL_ENV}
RUN . ${VIRTUAL_ENV}/bin/activate 
RUN pip install --upgrade pip && pip install -r requirements.txt
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