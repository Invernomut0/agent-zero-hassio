ARG BUILD_FROM
FROM $BUILD_FROM

# Copy and set up our custom run script
COPY run.sh /usr/local/bin/run.sh
RUN chmod a+x /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]
