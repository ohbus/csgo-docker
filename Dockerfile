FROM ubuntu:18.04
MAINTAINER Subhrodip Mohanta <hire at subho dot xyz>

ENV USER csgoserver
ENV HOME /home/$USER
ENV SERVER $HOME/server

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install apt-utils locales

RUN dpkg --add-architecture i386 \
	&& apt-get -y update \
    && apt-get -y upgrade

RUN dpkg-reconfigure debconf

RUN apt-get -y install mailutils postfix curl wget file \
	&& apt-get -y install tar bzip2 gzip unzip \
	&& apt-get -y install bsdmainutils python util-linux ca-certificates \
	&& apt-get -y install binutils bc jq tmux lib32gcc1 libstdc++6 libstdc++6:i386 \
	&& apt-get -y install vim net-tools telnet

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y autoclean

RUN locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd $USER \
    && mkdir $HOME \
    && chown $USER:$USER $HOME \
    && mkdir $SERVER

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN chown -R $USER:$USER $SERVER

USER $USER

ADD ./linuxgsm.sh $SERVER/linuxgsm.sh

RUN cd $SERVER \
	&& ls -l \
	&& $SERVER/linuxgsm.sh csgoserver \
	&& ls -l \
	&& $SERVER/csgoserver -y install \
	&& ls -l

EXPOSE 27015

WORKDIR /home/$USER/csgoserver

ENTRYPOINT ["./csgoserver.sh" "start"]

# CMD ["-console" "-usercon" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_cache"]
