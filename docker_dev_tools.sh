#!/bin/bash

# Option names declared 
SHORT=M:,i:,t:,m:,c:,C:,r:,a:
LONG=mode:,imagename:,imagetag:,memory:,cpu:,containername:,registry:,applicationname:
OPTS=$(getopt --options $SHORT --longoptions $LONG -- "$@") 

eval set -- "$OPTS"

containername="None"
registry="None"
memory=0
cpu=0

# In this section options is collected from user .
# Because options are long format "shift" command was used. 
# You can review this website for long format option definiton : https://stackabuse.com/how-to-parse-command-line-arguments-in-bash/ 
while :
do
  case "$1" in
    -M | --mode )
      mode="$2"
      shift 2
      ;;
    -i | --imagename )
      imagename="$2"
      shift 2
      ;;    
    -t | --imagetag )
      imagetag="$2"
      shift 2
      ;;
    -m | --memory )
      memory="$2"
      shift 2
      ;;
    -c | --cpu )
      cpu="$2"
      shift 2
      ;;
    -C | --containername )
      containername="$2"
      shift 2
      ;;
    -r | --registry )
      registry="$2"
      shift 2
      ;;  
    -a | --applicationname )
      applicationname="$2"
      shift 2
      ;;
    -h | --help )
      "This is a docker script"    
      exit 2
      ;;
    --)
      shift;
      break
      ;;
    *)
      echo "Unexpected option: $1"
      ;;
  esac
done

# this section is used for mode selection
## Build Mode 
if [ $mode = "build" ]
then
  
  if [ $registry = "None" ]
  then
    #this command only builds docker image
    docker build -t $imagename:$imagetag .

  elif [ $registry = "Dockerhub" ]
  then
    # these commands builds docker image and pushes to dockerhub
    docker build -t $imagename:$imagetag .
    docker image tag $imagename:$imagetag yallic/$imagename:$imagetag
    docker image push yallic/$imagename:$imagetag

  elif [ $registry = "Gitlab" ]
  then

    # these commands builds docker image and pushes to gitlab registry
    docker build -t registry.gitlab.com/yallic/patika-devops/$imagename:$imagetag .
    docker push registry.gitlab.com/yallic/patika-devops/$imagename:$imagetag 
  else 
    # Wrong usage warning
    echo "################################################################################"
    echo "[ERROR] Please check the mandatory options"
    echo "################################################################################"
    break

  
  fi

## Deploy Mode 
elif [ $mode = "deploy" ]
then

  # Only the name variable is checked in this section because the memory and cpu variables' default value is 0.
  # When the default value is 0, docker ignores to -m and --cpus parameters thus we don't need to extra if else statement
  if [ $containername = "None" ]
  then
    docker run -it  -m $memory --cpus=$cpu $imagename:$imagetag

  else
    docker run -it   -m $memory --cpus=$cpu --name $containername  $imagename:$imagetag
  fi

## Deploy Mode
elif [ $mode = "template" ] 
then
  

  if [ $applicationname = "mysql" ]
  then
    # The mysql app is gonna run through mysql docker-compose file
    docker-compose -f docker-compose-mysql.yml up -d 

  elif [ $applicationname = "mongodb" ]
  then 
    # The mongo app is gonna run through mongo docker-compose file
    docker-compose  -f docker-compose-mongo.yml up -d

  else
    # Wrong usage warning
    echo "################################################################################"
    echo "[ERROR] Please check the mandatory options"
    echo "################################################################################"
    break
  fi
    
fi
