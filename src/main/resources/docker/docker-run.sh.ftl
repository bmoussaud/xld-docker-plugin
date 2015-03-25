<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
echo "Running ${deployed.id}"
#docker run -d --name ${deployed.name} ${deployed.image}
<#assign cmdLine = ["docker", "run","-d"] />
<#if (deployed.publishAllExposedPorts)>
<#assign cmdLine = cmdLine + ["-P"]/>
</#if>
<#list deployed.portMappings?keys as key>
    <#assign cmdLine = cmdLine + ["-p ${key}:${deployed.portMappings[key]}"]/>
</#list>
<#list deployed.links as link>
    <#assign cmdLine = cmdLine + ["--link=${link}"]/>
</#list>
<#assign cmdLine = cmdLine + ["--name ${deployed.name}"]/>
<#assign cmdLine = cmdLine + ["${deployed.image}"]/>

echo <#list cmdLine as item>${item} </#list>
<#list cmdLine as item>${item} </#list>
