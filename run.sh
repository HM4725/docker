docker build -t web:0.1 .
docker run -it -p 80:4000 -w='/root' -v /etc/localtime:/etc/localtime:ro --name web web:0.1 zsh
