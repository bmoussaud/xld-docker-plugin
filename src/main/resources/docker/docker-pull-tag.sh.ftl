<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
echo docker pull ${deployed.container.privateRegistryAddress}:${deployed.container.privateRegistryPort}/${deployed.image}
docker pull ${deployed.container.privateRegistryAddress}:${deployed.container.privateRegistryPort}/${deployed.image}

echo docker tag ${deployed.container.privateRegistryAddress}:${deployed.container.privateRegistryPort}/${deployed.image} ${deployed.image}
docker tag ${deployed.container.privateRegistryAddress}:${deployed.container.privateRegistryPort}/${deployed.image} ${deployed.image}
