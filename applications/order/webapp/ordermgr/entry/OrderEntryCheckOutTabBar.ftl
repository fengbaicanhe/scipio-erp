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

<#if stepTitleId??>
    <#assign stepTitle = uiLabelMap.get(stepTitleId)>
</#if>

<#assign title>
    <#if shoppingCart.getOrderType() == "PURCHASE_ORDER">
        ${uiLabelMap.OrderPurchaseOrder}
    <#else>
        ${uiLabelMap.OrderSalesOrder}
    </#if>
    :&nbsp;${stepTitle!}
</#assign>

<@section title=title>
      <ul class="button-group">
      <#list checkoutSteps?reverse as checkoutStep>
        <#assign stepUiLabel = uiLabelMap.get(checkoutStep.label)>
        <#if checkoutStep.enabled == "N">
            <li><a href="#" class="button tiny disabled">${stepUiLabel}</a></li>
        <#else>
            <li><a href="<@ofbizUrl>${checkoutStep.uri}</@ofbizUrl>" class="button tiny">${stepUiLabel}</a></li>
        </#if>
      </#list>
      <#if isLastStep == "N">
        <li><a href="javascript:document.checkoutsetupform.submit();" class="button tiny success">${uiLabelMap.CommonContinue}</a></li>
      <#else>
        <li><a href="<@ofbizUrl>processorder</@ofbizUrl>" class="button tiny alert">${uiLabelMap.OrderCreateOrder}</a></li>
      </#if>
    </ul>
</@section>
