FROM odoo:18.0

ARG LOCALE=en_US.UTF-8
ENV LANGUAGE=${LOCALE}
ENV LC_ALL=${LOCALE}
ENV LANG=${LOCALE}

USER root

# Install needed packages
RUN apt-get -y update && apt-get install -y --no-install-recommends locales netcat-openbsd \
    && locale-gen ${LOCALE} \
    && mkdir -p /mnt/extra-addons \
    && chown -R odoo:odoo /mnt/extra-addons

# Copy custom module (OCA or personal) into extra-addons
# Remplace ce chemin par l'endroit où tu as le module sur ta machine
COPY ./website_slides_access_duration /mnt/extra-addons/website_slides_access_duration

# Copy entrypoint script
WORKDIR /app
COPY --chmod=755 entrypoint.sh ./

USER odoo

ENTRYPOINT ["/bin/sh"]
CMD ["entrypoint.sh"]
