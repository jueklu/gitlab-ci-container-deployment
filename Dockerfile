# Alpine-based NGINX image with unprivileged (non-root) default user
FROM nginxinc/nginx-unprivileged:stable-alpine

# Temporarily switch to "root" user to perform permission adjustments
USER root

# Set variable for the document root
ARG DOCROOT=/usr/share/nginx/html

# Copy website files into the document root and set ownership to the "nobody" user
COPY --chown=nobody:nobody website/ ${DOCROOT}

# Adjust permissions
RUN find ${DOCROOT} -type d -print0 | xargs -0 chmod 755 && \
    find ${DOCROOT} -type f -print0 | xargs -0 chmod 644 && \
    chmod 755 ${DOCROOT}

# Switch back to the "nginx" user for running the container
USER nginx

# Expose port 8080 for the container
EXPOSE 8080