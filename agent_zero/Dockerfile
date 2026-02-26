ARG BUILD_FROM
FROM $BUILD_FROM

# Install docker CLI to manage Agent Zero container
RUN apk add --no-cache docker-cli

# Copy the run script
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
