FROM python:3.7.3-slim

ENV PROJECT_HOME=/opt/project
ENV ORACLE_HOME=/opt/oracle

# Update all components
RUN apt-get update
#RUN apt-get install -y --no-install-recommends libatlas-base-dev gfortran nginx supervisor

# ODPI-C Installation
RUN mkdir -p ${ORACLE_HOME}
COPY instantclient-basic-linux.x64-19.3.0.0.0dbru.zip ${ORACLE_HOME}
WORKDIR ${ORACLE_HOME}
RUN apt-get install unzip
RUN unzip instantclient-basic-linux.x64-19.3.0.0.0dbru.zip
RUN apt-get install libaio1

RUN sh -c "echo /opt/oracle/instantclient_19_3 > /etc/ld.so.conf.d/oracle-instantclient.conf"
RUN ldconfig



RUN mkdir -p ${PROJECT_HOME}
COPY main.py ${PROJECT_HOME}/
COPY requirements.txt ${PROJECT_HOME}
WORKDIR ${PROJECT_HOME}

# Upgrading pip
RUN pip install --upgrade pip

# Install deplendencies
RUN pip install -r requirements.txt

CMD [ "python", "./main.py" ]
