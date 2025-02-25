docker build -t winuthayanon/fastaptamer-2.0:4.3.0 . -f Dockerfile
docker push winuthayanon/fastaptamer-2.0:4.3.0
docker build -t winuthayanon/fastaptamer-2.0:4.3.0-1 . -f Dockerfile
docker push winuthayanon/fastaptamer-2.0:4.3.0-1
docker build -t winuthayanon/fastaptamer-2.0:4.3.1 . -f Dockerfile
docker push winuthayanon/fastaptamer-2.0:4.3.1
docker build -t winuthayanon/fastaptamer-2.0:4.3.1-1 . -f Dockerfile
docker push winuthayanon/fastaptamer-2.0:4.3.1-1

# docker run -v "$(pwd)/nine:/app/user_work" -v /var/run/docker.sock:/var/run/docker.sock \
# -p 4949:4949 \
# -it winuthayanon/fastaptamer-2.0:20230706 \
# R -e "shiny::runApp('/app', host = '0.0.0.0', port = 4949, launch.browser = FALSE)"

docker run \
-p 4949:4949 \
-it winuthayanon/fastaptamer-2.0:4.3.0 \
R -e "shiny::runApp('/srv/shiny-server', host = '0.0.0.0', port = 4949, launch.browser = FALSE)"

docker run \
-p 4949:4949 \
-it winuthayanon/fastaptamer-2.0:4.3.0-1 \
R -e "shiny::runApp('/srv/shiny-server', host = '0.0.0.0', port = 4949, launch.browser = FALSE)"

docker run \
-p 4949:4949 \
-it winuthayanon/fastaptamer-2.0:4.3.1 \
R -e "shiny::runApp('/srv/shiny-server', host = '0.0.0.0', port = 4949, launch.browser = FALSE)"

docker run \
-p 4949:4949 \
-it winuthayanon/fastaptamer-2.0:4.3.1-1 \
R -e "shiny::runApp('/srv/shiny-server', host = '0.0.0.0', port = 4949, launch.browser = FALSE)"

rm -f fastaptamer-2.0_4.3.1-1.sif
singularity pull docker://winuthayanon/fastaptamer-2.0:4.3.1-1
singularity inspect fastaptamer-2.0_4.3.1-1.sif

readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo $PORT
SIF_FILE=fastaptamer-2.0_4.3.1-1.sif
singularity exec \
  --writable-tmpfs \
  --cleanenv ${SIF_FILE} \
  R -e "shiny::runApp('/srv/shiny-server', host = '0.0.0.0', port = ${PORT}, launch.browser = FALSE)"