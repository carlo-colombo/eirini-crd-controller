FROM flant/shell-operator:latest AS shell-operator

FROM elixir:alpine AS base

RUN apk add --no-cache curl  \
   && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
   && chmod +x kubectl \
   && mv kubectl /bin/kubectl \
   && mix local.rebar --force \
   && mix local.hex --force

ADD . /eirini_crd_controller

WORKDIR /eirini_crd_controller
RUN mix deps.get && mix deps.compile && mix compile

ENV SHELL_OPERATOR_WORKING_DIR /eirini_crd_controller/hooks

COPY --from=shell-operator /shell-operator /
ENTRYPOINT ["/shell-operator"]
CMD ["start"]

