# If you want to rebuild your own copy, follow below instructions
# Build this on each type of machine so you have the correct CPU extensions.
FROM ubuntu:latest		
		
WORKDIR /root/		
RUN apt-get update -qy && \		
    apt-get install -qy cmake build-essential libboost-all-dev git ca-certificates \		
    --no-install-recommends

RUN git clone -b Linux https://github.com/nicehash/nheqminer.git

#RUN cd nheqminer/cpu_xenoncat/Linux/asm/ && sh assemble.sh && cd ../../../Linux_cmake/nheqminer_cpu && cmake . && make
# If you compile in the container you are bound to the processor on which it is created, which causes errors
# and illegal instructions on some - so I moved compilation to the startup phase and was able to deploy
# on all workers ranging from i5 to i7

COPY start.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
