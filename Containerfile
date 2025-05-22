FROM nodered/node-red:3.1.11

# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED
WORKDIR /data
# copy adapted package.json which includes startup script
COPY package.json /data
# copy csv file
COPY node-red-data/train_data.csv /data/train_data.csv
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production
WORKDIR /usr/src/node-red

# Copy _your_ Node-RED project files into place
# NOTE: This will only work if you DO NOT later mount /data as an external volume.
#       If you need to use an external volume for persistence then
#       copy your settings and flows files to that volume instead.
COPY node-red-data/settings.js /data/settings.js
# not needed for this example
#COPY node-red-data/flows_cred.json /data/flows_cred.json

COPY flows-autostart.json /data/flows.json
# Flow with autoshutdown
#COPY flows-autostart-shutdown.json /data/flows.json

# expose OPCUA Server port
EXPOSE 1880 4840