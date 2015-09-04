FROM ${deployed.image}

RUN mkdir -p ${deployed.targetPath}
COPY ${deployed.file.name} ${deployed.targetPath}/${deployed.file.name}
VOLUME ${deployed.targetPath}

CMD ["/bin/sh"]



