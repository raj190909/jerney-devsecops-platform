#!/bin/bash

set -e

echo ""
echo "======================================"
echo "       Setting up Argo CD"
echo "======================================"
echo ""

echo "[1/6] Creating Argo CD namespace..."

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "[2/6] Installing Argo CD..."

kubectl apply --server-side \
  -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "[3/6] Waiting for Argo CD components..."

kubectl wait \
  --for=condition=available \
  deployment/argocd-server \
  -n argocd \
  --timeout=300s

kubectl wait \
  --for=condition=available \
  deployment/argocd-repo-server \
  -n argocd \
  --timeout=300s

kubectl wait \
  --for=condition=available \
  deployment/argocd-redis \
  -n argocd \
  --timeout=300s

echo "[4/6] Configuring Argo CD service..."

kubectl patch svc argocd-server \
  -n argocd \
  --type='json' \
  -p='[
    {"op":"replace","path":"/spec/type","value":"NodePort"},
    {"op":"replace","path":"/spec/ports/0/port","value":8081},
    {"op":"replace","path":"/spec/ports/0/nodePort","value":30801}
  ]'

echo "[5/6] Getting Argo CD admin password..."

ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d)

echo ""
echo "======================================"
echo "       Argo CD Setup Completed"
echo "======================================"
echo ""

echo "Username : admin"
echo "Password : $ARGOCD_PASSWORD"
echo ""

echo "Argo CD Dashboard:"
echo "https://<EC2-PUBLIC-IP>:30801"
echo ""

echo "======================================"
echo "IMPORTANT"
echo "======================================"
echo "Make sure AWS Security Group allows TCP port 30801."
echo ""
echo "Argo CD components will automatically"
echo "restart/recover after Kubernetes/EC2 restart."
echo "======================================"
echo ""

echo "[6/6] Argo CD pods:"

kubectl get pods -n argocd

echo ""
echo "Argo CD service:"
kubectl get svc argocd-server -n argocd
