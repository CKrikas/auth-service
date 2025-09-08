FROM quay.io/keycloak/keycloak:24.0

ENV KEYCLOAK_ADMIN=admin \
    KEYCLOAK_ADMIN_PASSWORD=admin

# Use your existing export filename
COPY realm-export.json /opt/keycloak/data/import/stratologia.json

# Keep the /auth path and enable startup import
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start-dev","--http-relative-path=/auth","--import-realm"]
