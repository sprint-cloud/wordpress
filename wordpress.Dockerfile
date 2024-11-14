# In deze DockerFile bouwen we een image voor een PHP app mvb Composer.
# Om de image size zo klein mogelijk te houden maken we gebruik van een meerstapse build.

# Stap 1: Bouwe een container genaamd build op basis van de composer container en installeer de Composer PHP packages in /source
FROM composer AS build
WORKDIR /source

# Kopieer composer.json naar de source dir op de composer build container
COPY  composer.* /source/

# Run composer op de build container om de php source code te installeren
RUN composer install \
  --optimize-autoloader \
  --no-interaction \
  --no-progress

# Stap 2: Bouw de container voor je app op basis van een php-nginx image en kopieer 
FROM trafex/php-nginx:latest
# numerieke user aanduiding nodig voor nonroot K8S
USER root

COPY --chown=root --from=build /source/wordpress /var/www/html
COPY --chown=root --from=build /source/vendor /var/www/html/vendor

# Kopieer zelf gemaakte themes en plugins
COPY custom/* /var/www/html/wp-content/

# Default config file
COPY --chown=root  ./config/wp-config.php /var/www/html

USER 65534