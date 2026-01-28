# koha-eib
SIGB Koha para laboratorios EIB

Configuración desde https://github.com/Kedu-SCCL/docker-koha-community

docker-compose up --build

Para obtener la contraseña temporal de administrador
docker exec -ti koha koha-passwd biblioteca

Usuario: admin_[NOMBRE DE LA INSTANCIA].
En este caso:
Usuario: admin_biblioteca

Luego se crean las tablas y usuario superusuario


Pasos para crear la iamgen luego del despliegue
Construir la imagen (carpeta inicial con docker-compose; Dockerfile; entrypoint.sh; build.sh; templates/) (docker build . --no-cahe)
Desplegar el contenedor (docker compose up -d)
Hacer respaldo de la base de datos en un archivo init.sql (docker exec koha-db mysqldump -u root -psecret --databases koha_biblioteca > biblioteca.sql)
Bajar el contenedor (docker compose down -v)
Copiar el archivo en la carpeta backupdb (mv biblioteca.sql backupdb/init.sql  --- a la que hace referencia Dockerbuild)
Re construir la imagen con el tag correspondiente (docker build -t fabianbaena/koha-eib:1.4 .    )
Actualizar el docker hub con docker push (docker push fabianbaena/koha-eib:1.4)
Descargar (con docker pull) la imagen en la máquina a instalar (docker pull fabianbaena/koha-eib:1.4)
Subir el contenedor con docker compose (docker compose up -d)

Tagear para subier a dockerhub
docker tag fabianbaena/koha-eib:1.4 fabianbaena/koha-eib:1.0
