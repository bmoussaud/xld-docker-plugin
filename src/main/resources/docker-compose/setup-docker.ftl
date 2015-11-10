<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
export DOCKER_TLS_VERIFY="${target.container.tls_verify?string('1', '0')}"
export DOCKER_HOST="tcp://${target.container.host.address}:${target.container.port}"
export DOCKER_CERT_PATH="${target.container.host.privateKeyFile?remove_ending("/id_rsa")}"

