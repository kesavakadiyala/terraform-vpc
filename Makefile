help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

vpc: ## Run against Dev Env
	@terraform init -backend-config=states/env.tfvars -no-color
	@terraform apply -auto-approve -var-file=env/env.tfvars -no-color
