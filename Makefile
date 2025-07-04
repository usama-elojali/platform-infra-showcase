.PHONY: plan apply destroy deploy

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply

destroy:
	cd terraform && terraform destroy

deploy:
	git add .
	git commit -m "Deploy via Makefile"
	git push
