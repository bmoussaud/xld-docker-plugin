<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#include "/docker/setup-docker.ftl">
echo docker pull ${registryHost}:${registryPort}/${deployed.image}
docker pull ${registryHost}:${registryPort}/${deployed.image}

echo docker tag -f ${registryHost}:${registryPort}/${deployed.image} ${deployed.image}
docker tag -f ${registryHost}:${registryPort}/${deployed.image} ${deployed.image}
