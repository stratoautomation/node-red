ARG NODERED_VERSION

# Use the official Node-RED image as the base
FROM nodered/node-red:${NODERED_VERSION}

# Switch to root to install packages
USER root

# Update and install Python, Pip, and your desired Python packages
RUN apk add --no-cache py3-pip
RUN pip3 install --no-cache-dir --break-system-packages python-kasa

# Switch back to the non-root Node-RED user
USER node-red

# Env variables
ENV NODE_RED_VERSION=$NODE_RED_VERSION \
    NODE_PATH=/usr/src/node-red/node_modules:/data/node_modules \
    PATH=/usr/src/node-red/node_modules/.bin:${PATH} \
    FLOWS=flows.json

# ENV NODE_RED_ENABLE_SAFE_MODE=true    # Uncomment to enable safe start mode (flows not running)
# ENV NODE_RED_ENABLE_PROJECTS=true     # Uncomment to enable projects option

# Expose the listening port of node-red
EXPOSE 1880

# Add a healthcheck (default every 30 secs)
# HEALTHCHECK CMD curl http://localhost:1880/ || exit 1

# ENTRYPOINT ["npm", "start", "--cache", "/data/.npm", "--", "--userDir", "/data"]
ENTRYPOINT ["./entrypoint.sh"]
