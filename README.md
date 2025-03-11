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
