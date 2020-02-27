FROM ubuntu:18.04
MAINTAINER Subhrodip Mohanta <hire at subho dot xyz>

ENV USER csgoserver
ENV HOME /home/$USER
ENV SERVER $HOME/csgoserver

RUN apt-get -y update \
    && apt-get -y upgrade

RUN dpkg --add-architecture i386 \
	&& apt-get -y update \
    && apt-get -y upgrade

RUN apt-get -y install mailutils postfix curl wget file \
	&& apt-get -y install tar bzip2 gzip unzip \
	&& apt-get -y install bsdmainutils python util-linux ca-certificates \
	&& apt-get -y install binutils bc jq tmux lib32gcc1 libstdc++6 libstdc++6:i386 \
	&& apt-get -y install vim ping telnet

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

# ADD ./csgo_ds.txt $SERVER/csgo_ds.txt
# ADD ./update.sh $SERVER/update.sh
# ADD ./autoexec.cfg $SERVER/csgo/csgo/cfg/autoexec.cfg
# ADD ./server.cfg $SERVER/csgo/csgo/cfg/server.cfg
# ADD ./csgo.sh $SERVER/csgo.sh

RUN chown -R $USER:$USER $SERVER

USER $USER

RUN cd $SERVER

RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh csgoserver

RUN ["./csgoserver.sh" "install"]

EXPOSE 27015

WORKDIR /home/$USER/csgoserver

ENTRYPOINT ["./csgoserver.sh" "start"]

# CMD ["-console" "-usercon" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_cache"]
