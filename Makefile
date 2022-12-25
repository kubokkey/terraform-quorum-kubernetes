.PHONY: *.apply fmt run-tflint

tf_dir := "./terraform-azure"

fmt:
	cd $(tf_dir) && terraform fmt -recursive .

run-tflint:
	cd $(tf_dir) && reflex -r '\.tf$$' ../tools/tflint-check.sh

dev.apply:
	cd $(tf_dir) \
	&& terraform init \
	&& terraform workspace new dev || terraform workspace select dev \
	&& terraform apply -var-file ./terraform.dev.tfvars -auto-approve -target module.quorum_aks_setup \
	&& terraform apply -var-file ./terraform.dev.tfvars -auto-approve -target module.argocd_install \
	&& terraform apply -var-file ./terraform.dev.tfvars -auto-approve

prod.apply:
	cd $(tf_dir) \
	&& terraform init \
	&& terraform workspace new prod || terraform workspace select prod \
	&& terraform apply -var-file ./terraform.prod.tfvars -auto-approve -target module.quorum_aks_setup \
	&& terraform apply -var-file ./terraform.prod.tfvars -auto-approve -target module.argocd_install \
	&& terraform apply -var-file ./terraform.prod.tfvars -auto-approve
