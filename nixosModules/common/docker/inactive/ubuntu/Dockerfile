FROM ubuntu:26.04

ARG UID
ARG USERNAME

RUN apt-get update && \
	apt-get install -y python3 python3-pip npm gcc && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	useradd -m -u ${UID} ${USERNAME}

CMD ["sleep", "infinity"]