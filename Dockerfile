FROM quay.io/keycloak/keycloak:24.0
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
CMD ["start-dev","--http-relative-path=/auth"]
