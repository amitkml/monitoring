ARG RUNTIME=ruby2.5

FROM lambci/lambda:build-${RUNTIME} AS build
COPY . .

FROM build as test
COPY --from=hashicorp/terraform:0.12.2 /bin/terraform /bin/
RUN terraform fmt -check

FROM test AS plan
ARG AWS_ACCESS_KEY_ID
ARG AWS_DEFAULT_REGION=us-east-1
ARG AWS_SECRET_ACCESS_KEY
RUN terraform init
RUN terraform plan -out terraform.zip
CMD ["terraform", "apply", "terraform.zip"]
