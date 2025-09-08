FROM quay.io/keycloak/keycloak:24.0
ENV KEYCLOAK_ADMIN=admin \
    KEYCLOAK_ADMIN_PASSWORD=admin
# Put your exported file here
COPY realms /opt/keycloak/data/import/
# Keep /auth if your portals are configured that way
CMD ["start-dev","--import-realm","--http-relative-path=/auth"]
