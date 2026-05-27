set shell := ["bash", "-euo", "pipefail", "-c"]

tf_dir := env_var_or_default("TF_DIR", ".")
plan_file := env_var_or_default("TF_PLAN_FILE", "tfplan")
plan_text := env_var_or_default("TF_PLAN_TEXT", "tfplan.txt")

default:
    @just --list

fmt:
    terraform -chdir={{tf_dir}} fmt -check -recursive

fmt-fix:
    terraform -chdir={{tf_dir}} fmt -recursive

init:
    terraform -chdir={{tf_dir}} init -input=false

validate:
    terraform -chdir={{tf_dir}} validate

plan:
    terraform -chdir={{tf_dir}} plan -input=false -out={{plan_file}}
    terraform -chdir={{tf_dir}} show -no-color {{plan_file}} > {{plan_text}}

apply:
    terraform -chdir={{tf_dir}} apply -input=false -auto-approve {{plan_file}}

check: fmt init validate plan

clean-plan:
    rm -f {{tf_dir}}/{{plan_file}} {{tf_dir}}/{{plan_text}}