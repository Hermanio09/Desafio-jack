*Desafio JackExperts: Aplicação Simples com Página HTML Customizável*

*Pré-requisitos*

*Clonar respositorio*

    git clone https://github.com/Hermanio09/Desafio-jack.git

*1 - Para que o proejto funcione de forma correta e necessario ter essas ferramentas instaladas:*

    Docker
    kubectl
    Minikube
    VirtualBox
    Helm
    Git

*2 - Instalação das Ferramentas no ambiente:*

*Docker*

        Instalar as dependências necessarias do Docker:

        sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

        Adicionar a chave GPG oficial do Docker:

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

        Adicionar o repositório do Docker:

        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        Instalar a ferramenta Docker:

        sudo apt install docker-ce docker-ce-cli containerd.io -y

        Verificar se o Docker foi instalado

        docker --version

        Verificar se a instalação está funcionando de forma correta:

        sudo docker run hello-world
    

*Kubernetes*

        Desabilitar o swap:
        Kubernetes exige que o swap esteja desabilitado para funcionar corretamente.

        sudo swapoff -a
        
        Instalar dependências necessárias do Kubernetes:

        sudo apt install apt-transport-https ca-certificates curl -y

        Adicionar a chave GPG do Kubernetes:

        sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

        Adicionar o repositório do Kubernetes:

        echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

        Atualizar a lista dos pacotes e instalar o Kubernetes:

        sudo apt update
        sudo apt install -y kubelet kubeadm kubectl

        Verificar se as dependências do Kubernetes estão instalados corretamente:

        kubeadm version
        kubectl version --client
        kubelet --version

        Configurar o cluster (master node):

        sudo kubeadm init --pod-network-cidr=192.168.0.0/16
        
        É necessario configurar o usuário para acessar o cluster:

        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config

        Instalar a rede de pods por exemplo o  Flannel, por se tratar de uma ferramenta mais simples e para setups um pouco mais fracos:

        kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/k8s-flannel-net.yaml

        Verificar se o Flannel foi instalado de forma correta e verificar se os pods do Flannel estão em execução:

        kubectl get pods --all-namespaces

        Verifique o status dos nós:

        kubectl get nodes


*Minikube*

        Instalar o curl, conntrack e outras dependências:

        sudo apt install curl apt-transport-https conntrack -y

        É necessario baixar o binário do Minikube:

        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

        Instalar o Minikube:

        sudo install minikube-linux-amd64 /usr/local/bin/minikube

        Verifique se o Minikube foi instalado corretamente:

        minikube version

        Inicie o Minikube:

        minikube start --driver=docker

        Verifique o status do cluster Kubernetes:

        kubectl get nodes


*VirtualBox*

        adicionar o repositório do VirtualBox à lista de fontes do APT:

        echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

        Importar a chave do repositório para garantir a autenticidade dos pacotes:

        wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

        Atualizar a lista de pacotes:

        sudo apt update

        Instalar o VirtualBox:

        sudo apt install virtualbox-6.1

        Verificar a instalação:

        virtualbox --version

        Instale o driver de virtualização:

        sudo apt install virtualbox-ext-pack

        Adicionar o usuário ao grupo do VirtualBox:

        sudo usermod -aG vboxusers $(whoami)

        É necessario reinicar o computador para que todas as alterações sejam aplicadas:

        sudo reboot

*Helm*

        Script de instalação do Helm:

        curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 |

        Verificar a instalação:

        helm version

        Configurar o Helm com o cluster Kubernetes:

        helm repo add stable https://charts.helm.sh/stable

        Atualizar os repositórios:

        helm repo update

*Git*

        Instalar o Git:

        sudo apt install git

        Verificar a instalação do Git:

        git --version
        
        Configuração de usuario:

        git config --global user.name "Seu Nome"
        git config --global user.email "seuemail@example.com"


*3 - Buildando a imagem, testando e subindo para o Docker hub*

        Construir a imagem Docker:
        
        docker build -t nome-usuario-dockerhub/nome-imagem:tag .

        Rodar o Rodar o contêiner:

        docker run -d -p porta-local:porta-container nome-usuario-dockerhub/nome-imagem:tag

        Efetuar o Login no Docker Hub:

        sudo docker login

        Enviar a imagem para o Docker Hub:

        docker push nome-usuario-dockerhub/nome-imagem:tag

*4 - Configuração de ambiente*

        Iniciar o Minikube:

        minikube start

        Configuração do Docker no ambiente do Minikube:

        eval $(minikube docker-env)

        Verificar o status do cluster Minikube:

        kubectl get nodes


*5 - Deploy da Aplicação via Helm*

        Basicamente Todos os objetos da aplicação, como pods, serviços e outros recursos, serão gerenciados pelo Helm. A página HTML será totalmente customizada via ConfigMap.


        Deploy via Helm:

        helm install nome-da-aplicacao ./helm-chart \
        --set image.repository=seu-usuario-dockerhub/nome-da-imagem \
        --set image.tag=v1

        Gerar o arquivo YAML a partir do Helm Chart:

        helm template meu-desafio ./charts -f ./charts/values.yaml > desafio-jack.yaml

        É necessario aplicar a configuração gerada ao cluster:

        kubectl apply -f desafio-jack.yaml

        Lista os pods no namespace desafio-jack para verificar se eles foram criados corretamente e estão em execução.

        kubectl get pods -n desafio-jack

        Esse comando do Helm faz a instalação de uma aplicação no Kubernetes utilizando um Helm Chart, enquanto permite configurar parâmetros específicos, como o repositório e a tag da imagem Docker. Ele instala a aplicação usando o Helm Chart que foi especificado, define qual imagem Docker será usada (o repositório e a tag), e sobrescreve as configurações do chart diretamente no comando, sem a necessidade de alterar os arquivos do Helm.

        Verificar se todos os recursos foram criados e estão rodando com a label exigida:

        kubectl get all -l desafio=jackexperts

        Para obter informações dos pods ajudando a encontrar qualquer problema que pode ter acontecido na criação dos pods.

        kubectl -n desafio-jack describe pod

        Descrever todos os deployments no namespace, podendo verificar se o número de réplicas e outras configurações estão corretas:

        kubectl -n desafio-jack describe deployments

        Expor o deployment como um serviço, permitindo acesso externo à aplicação.

        kubectl expose deployment meu-app-desafio-jack-deployment --type=NodePort --port=8080 -n desafio-jack

        Este comando fornece detalhes sobre a configuração do Ingress:

        kubectl -n desafio-jack describe ingress

        Para editar o arquivo hosts para mapear um nome de domínio ao IP que a aplicação esta usando:

        sudo nano /etc/hosts

        Verificar se estão em funcionamento após a exposição do serviço:

        kubectl -n desafio-jack get deployments


*6 - Exposição da Aplicação via Domínio*

        Agora que a aplicação está rodando no Minikube, é preciso expô-la via um domínio personalizado. Aqui estão os passos detalhados:
        
        Obter o IP do Minikube
        Para conseguir acessar sua aplicação localmente, é necessario obter o IP do Minikube, que é onde o cluster Kubernetes está rodando:

        minikube ip

        
        Mapear o domínio no arquivo /etc/hosts

        Para o domínio funcionar direitinho na sua máquina, você precisa adicionar uma entrada no arquivo `/etc/hosts`. Isso vai fazer com que, sempre que você acessar o domínio no navegador, ele aponte pro IP do Minikube.


        Abra o arquivo /etc/hosts no editor de texto com permissões de administrador:

        sudo nano /etc/hosts

        Adicione a seguinte linha no final do arquivo (substitua <IP do Minikube> pelo IP que você obteve no comando anterior):


        <IP do Minikube> desafio-jackexperts.com

        Exemplo:

            192.168.49.2 desafio-jackexperts.com

            Salve o arquivo e saia do editor (Ctrl + O para salvar e Ctrl + X para sair do nano).

        Agora, quando você acessar `http://desafio-jackexperts.com` no seu navegador, ele vai te levar pro IP do Minikube e, assim, você vai conseguir acessar a aplicação rodando no cluster Kubernetes.


        Testar a Aplicação

        Agora que o domínio está configurado, é possivel testar aplicação direto no navegador:

            Abra um navegador de sua preferência.

            Na barra de endereço, digite:

            desafiojack.com

            A aplicação vai carregar e você vai conseguir ver a página HTML personalizada.

            O domínio vai apontar pro IP do Minikube e você vai ver sua aplicação rodando localmente, com o conteúdo que você ajustou pelo ConfigMap.


*7 - Para validação de Logs*
        
        Logs dos Nós.
        Para ver os logs de um nó específico, você pode usar o seguinte comando:

        kubectl logs --all-namespaces

        Logs dos Pods.
        Para ver os logs de um pod específico, você pode usar:

        kubectl logs nome-do-pod

        Se o pod tiver mais de um container, você pode especificar qual container você quer ver os logs:

        kubectl logs nome-do-pod -c nome-do-container

        Ver Logs de Todos os Pods em um Namespace
        Se você quiser ver os logs de todos os pods em um namespace específico, use:

        kubectl logs -n nome-do-namespace --all-containers=true

        Ver Logs em Tempo Real
        Para acompanhar os logs em tempo real, você pode usar o parâmetro -f (follow):

        Kubectl logs -f nome-do-pod