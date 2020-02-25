docker build -t web:1.0 .
docker run -it -p 80:4000 -w='/root' -v /etc/localtime:/etc/localtime:ro --name web web:1.0 zsh
