echo "Stop the container ${previousDeployed.name}, kill it after 10 seconds"
docker stop --time=10 ${previousDeployed.name}
