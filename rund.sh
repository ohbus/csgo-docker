docker run -d \
	--name=csgo-dedicated2 \
	-e SRCDS_RCONPW="$ubho@123#" \
	-e SRCDS_PW="12345" \
	-e SRCDS_PORT=27015 \
	-e SRCDS_TV_PORT=27020 \
	-e SRCDS_TOKEN=D094D15B0E91B0FBA299F7D8F4494E37 \
	-e SRCDS_FPSMAX=0 \
	-e SRCDS_TICKRATE=128 \
	-e SRCDS_MAXPLAYERS=16 \
	-e SRCDS_STARTMAP="de_inferno" \
	-e SRCDS_MAPGROUP="mg_active" \
	-p 27015:27015 \
	-p 27020:27020 \
	cm2network/csgo



SRCDS_RCONPW="changeme" (value can be overwritten by csgo/cfg/server.cfg) 
SRCDS_PW="changeme" (value can be overwritten by csgo/cfg/server.cfg) 
SRCDS_PORT=27015
SRCDS_TV_PORT=27020
SRCDS_FPSMAX=300
SRCDS_TICKRATE=128
SRCDS_MAXPLAYERS=14
SRCDS_STARTMAP="de_dust2"
SRCDS_REGION=3
SRCDS_MAPGROUP="mg_active"