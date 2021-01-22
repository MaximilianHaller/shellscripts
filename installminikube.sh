i=$(lscpu | grep -m 1 "CPU(s):")
x=$(echo $i | grep -o -E '[0-9]+')
if [$i -ge 2]
then
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \ && chmod +x minikube
	sudo cp minikube /usr/local/bin %% rm minikube
	sudo apt install -y conntrack
	sudo minikube start
else
	echo "you need more cores"
fi

