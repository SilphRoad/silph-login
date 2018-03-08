FROM silph/silph-base:latest
LABEL maintainer="Marco Ceppi <marco@thesilphroad.com>"

WORKDIR /app

COPY run.sh requirements.txt /app/
RUN pip install -r requirements.txt

COPY ./login/ /app

EXPOSE 8080

CMD ["/app/run.sh", "python3", "/app/main.py"]
