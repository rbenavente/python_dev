FROM harbor-master-test.rbenavente.demo.twistlock.com/library/hellopython:latest

USER root

#Secret exposed
COPY id_rsa ~/.ssh/id_rsa
COPY evil /evil

#Virus included
COPY eicar ~/eicar.txt
#CMD sed 's/999STANDARD/STANDARD' eicar.txt
#CMD sed -i 's/999STANDARD/STANDARD' ~/eicar.txt

#Install vulnerable os level packages
#Hashing out as it didn't install it originally....:  CMD apt-get install nmap nc
RUN apt-get update \
        && apt-get install -y nmap \
        && apt-get install -y netcat

#Expose vulnerable ports
EXPOSE 22
EXPOSE 80


CMD ["/bin/sh" "-c" "python ./index.py"]
