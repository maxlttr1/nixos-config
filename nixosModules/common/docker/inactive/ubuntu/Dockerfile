FROM debian:bookworm

ARG UID
ARG USERNAME

RUN apt-get update && \
	apt-get install -y sudo iproute2 python3 python3-pip python3-venv npm gcc && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	useradd -m -u ${UID} ${USERNAME} && \
	echo "${USERNAME}:passwd" | chpasswd && \
	usermod -aG sudo ${USERNAME}

CMD ["sleep", "infinity"]