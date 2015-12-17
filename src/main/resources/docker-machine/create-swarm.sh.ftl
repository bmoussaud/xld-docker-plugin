<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
echo "Creating swarm docker '${deployed.name}' machine using ${deployed.driver} provider"
<#assign cmdLine = ["docker-machine", "create","--driver","${deployed.driver}","--swarm","--swarm-discovery","token://${deployed.swarmToken}"] />
<#if deployed.master>
  <#assign cmdLine = cmdLine + ["--swarm-master"]/>
</#if>

<#list deployed.insecureRegistries as registry>
    <#assign cmdLine = cmdLine + ["--engine-insecure-registry",registry]/>
</#list>

<#list deployed.engineOptions?keys as k>
    <#assign opt="${k}=${deployed.engineOptions.get(k)}"/>
    <#assign cmdLine = cmdLine + ["--engine-opt","${opt}"]/>
</#list>

<#assign cmdLine = cmdLine + ["${deployed.machineName}"]/>
echo Executing <#list cmdLine as item>${item} </#list>
<#list cmdLine as item>${item} </#list>
