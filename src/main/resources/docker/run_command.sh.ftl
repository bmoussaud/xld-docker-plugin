<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#docker run -t  --rm -v `pwd`:/tmp/xebialabs --link ${deployed.link} --entrypoint "/bin/bash" ${deployed.container.image} -c "bash /tmp/xebialabs/smoketest/execute-http-request.sh"

<#assign cmdLine = ["docker", "run","-t","--rm"] />
<#assign cmdLine = cmdLine + ["-v `pwd`:/tmp/xebialabs"]/>
<#assign cmdLine = cmdLine + ["--link ${deployed.link}"]/>
<#if (deployed.entryPoint??)>
<#assign cmdLine = cmdLine + ["--entrypoint '${deployed.entryPoint}'"]/>
</#if>
<#assign cmdLine = cmdLine + ["${deployed.container.image}"]/>
<#assign cmdLine = cmdLine + ["-c"]/>
<#assign cmdLine = cmdLine + ['"bash /tmp/xebialabs/smoketest/execute-http-request.sh"']/>

echo <#list cmdLine as item>${item} </#list>
<#list cmdLine as item>${item} </#list>


