<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<#if tobrowser?? && tobrowser>
<h1>${uiLabelMap.WebtoolsExportFromDataSource}</h1>
<br />
<p>This page can be used to export data from the database. The exported documents will have a root tag of "&lt;entity-engine-xml&gt;".</p>
<hr />
<#if security.hasPermission("ENTITY_MAINT", session)>
    <a href="<@ofbizUrl>xmldsrawdump</@ofbizUrl>" class="button tiny" target="_blank">Click Here to Get Data (or save to file)</a>
<#else>
    <div>You do not have permission to use this page (ENTITY_MAINT needed)</div>
</#if>
<#else>
<#macro displayButtonBar>
  <ul class="button-group">
    <li><input type="submit" value="${uiLabelMap.WebtoolsExport}"/></li>
    <li><a href="<@ofbizUrl>xmldsdump?checkAll=true</@ofbizUrl>" class="button tiny">${uiLabelMap.WebtoolsCheckAll}</a></li>
    <li><a href="<@ofbizUrl>xmldsdump</@ofbizUrl>" class="button tiny">${uiLabelMap.WebtoolsUnCheckAll}</a></li>
  </ul>
</#macro>

<h2>${uiLabelMap.PageTitleEntityExport}</h2>
<p>${uiLabelMap.WebtoolsXMLExportInfo}</p>
<hr />

<#if security.hasPermission("ENTITY_MAINT", session)>
  <h2>${uiLabelMap.WebtoolsResults}:</h2>
  <#if parameters.filename?has_content && (numberOfEntities?number > 0)>
    <p>${uiLabelMap.WebtoolsWroteXMLForAllDataIn}</p>
    <p>${uiLabelMap.WebtoolsWroteNRecordsToXMLFile}</p>
  <#elseif parameters.outpath?has_content && (numberOfEntities?number > 0)>
    <#list results as result>
      <p>${result}</p>
    </#list>
  <#else>
    <p>${uiLabelMap.WebtoolsNoFilenameSpecified}</p>
  </#if>

  <hr />


  
  <h2>${uiLabelMap.WebtoolsExport}:</h2>
  <form method="post" action="<@ofbizUrl>xmldsdump</@ofbizUrl>" name="entityExport">
   <@row>
    <@cell class="large-6 columns">
  
    <@field type="input" label="${uiLabelMap.WebtoolsOutputDirectory}" size="60" name="outpath" value="${parameters.outpath!}"/>
    <@field type="input" label="${uiLabelMap.WebtoolsMaxRecordsPerFile}" size="10" name="maxrecords"/></td>
    <@field type="input" label="${uiLabelMap.WebtoolsSingleFilename}" size="60" name="filename" value="${parameters.filename!}"/></td>
    <@field type="datetime" dateType="datetime" label="${uiLabelMap.WebtoolsRecordsUpdatedSince}" name="entityFrom"  value="" size="25" maxlength="30" id="entityFrom1" dateType="date" />
    <@field type="datetime" dateType="datetime" label="${uiLabelMap.WebtoolsRecordsUpdatedBefore}" name="entityThru" value="" size="25" maxlength="30" id="entityThru1" dateType="date" />
    <@row>
        <@cell class="large-12">
            <@renderCheckBox name="tobrowser" checked=tobrowser?default("N")/> ${StringUtil.wrapString(uiLabelMap.WebtoolsOutToBrowser)}
        </@cell>
    </@row>
     </@cell>
    </@row>
    <hr>
    <h3>${uiLabelMap.WebtoolsEntityNames}:</h3>
    <@displayButtonBar/>
      <div>${uiLabelMap.WebtoolsEntitySyncDump}:
        <input name="entitySyncId" size="30" value="${entitySyncId!}"/>
      </div>
      ${uiLabelMap.WebtoolsPreConfiguredSet}:
      <select name="preConfiguredSetName">
        <option value="">${uiLabelMap.CommonNone}</option>
        <option value="CatalogExport">${uiLabelMap.WebtoolsPreConfiguredSet1}</option>
        <option value="Product1">${uiLabelMap.WebtoolsPreConfiguredSet2}</option>
        <option value="Product2">${uiLabelMap.WebtoolsPreConfiguredSet3}</option>
        <option value="Product3">${uiLabelMap.WebtoolsPreConfiguredSet4}</option>
        <option value="Product4">${uiLabelMap.WebtoolsPreConfiguredSet5}</option>
      </select>
      <br />

      <table>
        <tr>
          <#assign entCount = 0>
          <#assign checkAll = parameters.checkAll?default("false")>
          <#list modelEntities as modelEntity>
            <#if entCount % 3 == 0 && entCount != 0>
              </tr><tr>
            </#if>
            <#assign entCount = entCount + 1>
            <#assign check = checkAll/>
            <#if checkAll == "true" && modelEntity.getClass().getName() == "org.ofbiz.entity.model.ModelViewEntity">
                <#assign check = "false"/>
            </#if>
            <#assign curEntityName = modelEntity.getEntityName()/>
            <td><input type="checkbox" name="entityName" value="${curEntityName}"<#if check="true"> checked="checked"</#if>/>${curEntityName}</td>
          </#list>
        </tr>
      </table>

      <@displayButtonBar/>
    </form>

<#else>
    <div>${uiLabelMap.WebtoolsPermissionMaint}</div>
</#if>
</#if>