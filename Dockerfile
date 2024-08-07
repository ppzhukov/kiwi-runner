FROM ubuntu:noble
USER root
# Обновление пакетов и установка необходимых утилит
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt -y install systemd debootstrap qemu-utils mtools xorriso gdisk rsync kpartx dosfstools jing python3-pip
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN . /etc/os-release && export VERSION_CODENAME && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update
RUN apt -y install vault
#setcap -r /usr/bin/vault
RUN apt -y reinstall vault
RUN pip install --break-system-packages kiwi anymarkup
# RUN |
#       bash -c 'cat <<EOF > /etc/kiwi.yml
#       mapper:
#         - part_mapper: kpartx
#       EOF'
RUN apt update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
CMD [ "/bin/bash" ]
