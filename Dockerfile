#Escuela Politécnica Nacional
#Tema: Servicios de Red Basado en Contenedores
#Autor: Andrés Lenin Yazán Endara
#Servicio: DNS
#Archivo: Dockerfile

## Imagen Base
# El servicio dhcpd se implementara sobre una imagen base Alpine Linux
# versión 3.14
FROM alpine:3.14

## Etiqueta
LABEL authors="Yazán Endara Andrés Lenin" 
LABEL build-date="19/01/2023"
LABEL version="1.0"
LABEL description="Servidor DNS(Bind9) sobre Contenedor Docker"

## Instalación de dependencias
#Actualizamos el repositorio de Alpine mediante apk update
#Instalamos el servidor dns mediante apk add bind
#Instalamos herramientas dns mediante apk add bind-tools
#Instalamos bash en Alpine Linux mediante apk add bash
RUN apk update; apk add bind; apk add bind-tools; apk add bash

##Variables de Entorno
ENV TZ UTC 
ENV USER=named
ENV GROUP=named

##Carpetas  bind
# Creación carpeta /var/lib/bind
RUN mkdir /var/lib/bind
#Permisos Carpeta Lib
RUN chown -R ${USER}:${GROUP} /var/lib/bind
RUN chmod 0755 /var/lib/bind

# Creación carpeta /var/log/bind
RUN mkdir /var/log/bind
#Creación de archvio log
RUN touch /var/log/bind/named.log
#Permisos carpeta log
RUN chown -R ${USER}:${GROUP} /var/log/bind
RUN chmod -R 0700 /var/log/bind

# Creación carpeta /var/cache/bindd
RUN mkdir /var/cache/bind
#Permisos carpeta cache
RUN chown -R root:root /var/cache/bind
RUN chmod -R 0700 /var/cache/bind

##Archivos de Configuración
# Copiar archivo named.conf
COPY ./etc/bind/named.conf /etc/bind/
# Copiar archivo Zone
COPY ./etc/bind/db.master.TIC2023.com /etc/bind/
# Copiar archivo Reverse Zone
COPY ./etc/bind/db.master.0.168.192.rev  /etc/bind/
#Permisos archivo named.conf
RUN chown -R ${USER}:${GROUP} /etc/bind/
RUN chmod -R 0700 /etc/bind/


#Permisos archivo named.conf
#RUN chown ${USER}:${GROUP} /etc/bind/db.master.TIC2023.com
#RUN chmod -R 0775 /etc/bind/DNSserver.com.zone
#Permisos archivo named.conf
#RUN chmod -R 0775 ./etc/bind/db.master.0.168.192.rev

## Directorio de Trabajo
#Establecemos el directorio de trabajo en el direcotrio raiz /
WORKDIR ./

## Puertos de Escucha de Contenedor
# Exponemos los puertos requeridos para las respuestas del servidor dns
EXPOSE 53/tcp 53/udp

## Comando de Ejecución
# Configuramos comandos para el despligue del servicio dhcpd en el contenedor
#Ejecutar servicio named
#/usr/sbin/named

# Opciones de Ejcución:
#-4: DNS con direccionamiento IPv4
#-6: DNS con direccionamiento IPv6
#-c: Archivo de configuración DNS alternativo (named.conf)
#-d: Modo Depuración
#-E Uso de Criptografía OpenSSL 
#-f: Ejcutar named como Proceso de Primer plano (Foreground) (Background Default)
#-g: Forzar ejecución en primer plano
#-m: uso de memoria
#-p: Puerto UDP DNS (53/udp Default)
#-s: Estadisticas de uso de memoria en stdout
#-t: enserrar directorio mediante chroot
#-u:  Colocar UID para completar procesos privilegiados

#DNS 
##ENTRYPOINT
ENTRYPOINT ["/usr/sbin/named"]
##CMD
# Configuramos comandos para el despligue del contenedor
CMD ["-4","-c","./etc/bind/named.conf","-f", "-g"]