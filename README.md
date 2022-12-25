# terraform-quorum-kubernetes

## 概要

[GoQuorum](https://consensys.net/docs/goquorum/en/latest/deploy/install/kubernetes/)をterraformで構築
terraform workspaceで`dev`,`prod`等の環境種別に対応可能

## 構成コンポーネント

- AKS
- ArgoCD

## 利用コマンド

- `terraform`,`az`,`make`,`kubectl`

## How use

- Set build parameter
設定ファイル`/terraform-azure/terraform.xxx.tfvars`記載の各パラメータをセット

- Build
```sh
make ${dev or prod}.apply
```
