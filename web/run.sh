# Check if docker image exists.
if [ -z "$(docker images -q jekyll)" ]; then
    # Build docker image from Dockerfile.
    docker build -t jekyll:latest .
fi
# Check if docker container exists.
if [ -z "$(docker ps -a -q -f name=jekyll)" ]; then
    # Run docker container.
    docker run -it -p 80:4000 -w='/root' -v /etc/localtime:/etc/localtime:ro --name jekyll jekyll:latest zsh
fi
