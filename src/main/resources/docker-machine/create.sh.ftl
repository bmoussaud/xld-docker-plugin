<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
echo "Creating docker '${deployed.name}' machine using ${deployed.driver} provider"
<#assign cmdLine = ["docker-machine", "create","--driver","${deployed.driver}"] />

<#list deployed.insecureRegistries as registry>
    <#assign cmdLine = cmdLine + ["--engine-insecure-registry",registry]/>
</#list>

<#list deployed.engineOptions?keys as k>
    <#assign opt="${k}=${deployed.engineOptions[k]}"/>
    <#assign cmdLine = cmdLine + ["--engine-opt","${opt}"]/>
</#list>

<#list deployed.engineLabels?keys as k>
    <#assign opt="${k}=${deployed.engineLabels[k]}"/>
    <#assign cmdLine = cmdLine + ["--engine-label","${opt}"]/>
</#list>

<#assign cmdLine = cmdLine + ["${deployed.machineName}"]/>
echo Executing <#list cmdLine as item>${item} </#list>
<#list cmdLine as item>${item} </#list>
