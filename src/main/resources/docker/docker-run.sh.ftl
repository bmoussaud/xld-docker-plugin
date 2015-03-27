<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
echo "Running ${deployed.id}"
<#assign cmdLine = ["docker", "run","-d"] />
<#if (deployed.publishAllExposedPorts)>
    <#assign cmdLine = cmdLine + ["-P"]/>
</#if>
<#if (deployed.memory??)>
    <#assign cmdLine = cmdLine + ["--memory ${deployed.memory}" ]/>
</#if>
<#list deployed.ports as port>
    <#assign cmdLine = cmdLine + ["-p ${port.hostPort}:${port.containerPort}"]/>
</#list>
<#list deployed.links as link>
    <#assign cmdLine = cmdLine + ["--link=${link.name}:${link.alias}"]/>
</#list>
<#list deployed.volumes as volume>
    <#assign cmdLine = cmdLine + ["-v ${volume.hostPath}:${volume.containerPath}"]/>
</#list>
<#list deployed.volumesFrom as volume>
    <#assign cmdLine = cmdLine + ["--volumes-from=${volume}"]/>
</#list>

<#assign cmdLine = cmdLine + ["--name ${deployed.name}"]/>
<#assign cmdLine = cmdLine + ["${deployed.image}"]/>

echo <#list cmdLine as item>${item} </#list>
<#list cmdLine as item>${item} </#list>
