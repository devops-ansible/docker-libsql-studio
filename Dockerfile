FROM node:latest

ARG APP_VERSION
ENV VERSION ${APP_VERSION}

ENV EDITOR "vim"

ENV APP_USER "libsqlstudio"
ENV APP_ROOT "/application"

COPY installfiles /do_install
RUN chmod a+x /do_install/*.sh \
    && /do_install/install.sh

USER ${APP_USER}
WORKDIR ${APP_ROOT}
EXPOSE 3000

ENTRYPOINT ["entrypoint"]
CMD ["pnpm", "start", "--hostname=0.0.0.0"]
