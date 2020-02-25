FROM ubuntu:16.04

# Set korean locale
RUN apt-get update && apt-get install -y locales
RUN locale-gen ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8
ENV TERM xterm-256color

# link localhost timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
ENV TZ Asia/Seoul

# vim
RUN apt-get install -y vim
COPY file/vimrc /root/.vimrc

# oh-my-zsh
RUN apt-get install -y zsh git curl
WORKDIR /root
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git .powerlevel10k
RUN echo 'source .powerlevel10k/powerlevel10k.zsh-theme' >> .zshrc
RUN chsh -s `which zsh`

# rbenv
RUN apt-get install -y build-essential
RUN apt-get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN git clone git://github.com/sstephenson/rbenv.git .rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .zshrc
RUN rbenv install -v 2.5.0
RUN rbenv rehash
RUN mkdir ruby_2.5.0
WORKDIR /root/ruby_2.5.0
RUN rbenv local 2.5.0
RUN /bin/bash -l -c "gem install bundler -v 1.17.3"
RUN /bin/bash -l -c "gem install jekyll"
RUN rbenv rehash
