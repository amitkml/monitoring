build:
	cd functions/mail && bundle
	terraform init

clean:
	rm -rf .terraform*

plan:
	terraform plan

apply:
	terraform apply

.PHONY: build clean plan apply
