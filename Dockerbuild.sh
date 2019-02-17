#!/bin/sh

tag="yogeshkad786/devop_gcp_challenge"
version="master.2"
kubecluster="devops-assignment"
kubezone="us-west1-c"
applabel="nexus3"
releasename="devops-gcp"

docker build -t $tag:$version .
docker login
docker push $tag:$version


checkcluster=$(gcloud container clusters describe $kubecluster)
#echo $checkcluster

if [[ $checkcluster ]]; then
    echo "Cluster exists"
else
    gcloud container clusters create $kubecluster --zone $kubezone
fi

helm init

checksvcacc=$(kubectl get serviceaccount --namespace kube-system tiller)

if [[ $checksvcacc ]]; then
    echo "service account exists"
else

kubectl create serviceaccount --namespace kube-system tiller

kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

helm init --service-account tiller --upgrade

helm init --client-only

fi



checkdeployment=$(helm list -a)

cd helmCharts/app/   
if [[ $checkdeployment ]]; then
    echo "helm upgrade"
    helm upgrade --install $releasename .
else
    echo "helm install"
    helm install --name $releasename .
fi


