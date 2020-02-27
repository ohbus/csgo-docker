FROM ubuntu:18.04
MAINTAINER Subhrodip Mohanta <subhrodipmohanta at gmail dot com>

ENV USER csgo
ENV HOME /home/$USER
ENV SERVER $HOME/hlserver

RUN apt -y update \
    && apt -y upgrade

RUN dpkg --add-architecture i386 \
	&& apt -y update \
    && apt -y upgrade

RUN apt -y install mailutils postfix curl wget file \
	&& apt -y install tar bzip2 gzip unzip \
	&& apt -y install bsdmainutils python util-linux ca-certificates \
	&& apt -y install binutils bc jq tmux lib32gcc1 libstdc++6 libstdc++6:i386 \
	&& apt -y install vim ping telnet \

RUN apt -y update \
    && apt -y upgrade \
    && apt -y autoclean \

RUN locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd $USER \
    && mkdir $HOME \
    && chown $USER:$USER $HOME \
    && mkdir $SERVER

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ADD ./csgo_ds.txt $SERVER/csgo_ds.txt
ADD ./update.sh $SERVER/update.sh
ADD ./autoexec.cfg $SERVER/csgo/csgo/cfg/autoexec.cfg
ADD ./server.cfg $SERVER/csgo/csgo/cfg/server.cfg
ADD ./csgo.sh $SERVER/csgo.sh

RUN chown -R $USER:$USER $SERVER

USER $USER
RUN curl http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C $SERVER -xvz \
    && $SERVER/update.sh

EXPOSE 27015

WORKDIR /home/$USER/hlserver
ENTRYPOINT ["./csgo.sh"]
CMD ["-console" "-usercon" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_cache"]
