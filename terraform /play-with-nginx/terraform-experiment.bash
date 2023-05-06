#!/usr/bin/env bash

# source from https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/infrastructure-as-code
: ${HOST=localhost}
: ${PORT=8000}

function testUrl() {
    url=$@
    if $url -ks -f -o /dev/null
    then 
        return 0 
    else 
        return 1
    fi;
}

function waitForService() {
    url=$@
    echo -n "Wait for: $url..."
    n=0 
    until testUrl $url 
    do 
        n=$((n+1))
        if [[ $n == 100 ]]
        then 
            echo " Give up"
            exit 1
        else 
            sleep 3 
            echo -n ", retry #$n"
        fi 
    done
    echo "\nService is up and running!"
}


terraform init 
echo 

terraform fmt 
echo 

# auto approve on terraform
# https://stackoverflow.com/questions/59958294/how-do-i-execute-terraform-actions-without-the-interactive-prompt
terraform apply -auto-approve
echo 

waitForService curl -k http://$HOST:$PORT

sleep 5

terraform destroy --auto-approve
echo

echo "Starting to clean up for space saving purpose since this is a experiment learning script."
echo 'Executing "docker rmi -f $(docker images -aq)"'
echo 


docker rmi -f $(docker images -aq)
echo "All done!"
echo 