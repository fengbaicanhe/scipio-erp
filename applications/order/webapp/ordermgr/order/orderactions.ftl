<#if security.hasEntityPermission("ORDERMGR", "_UPDATE", session) && (!orderHeader.salesChannelEnumId?? || orderHeader.salesChannelEnumId != "POS_SALES_CHANNEL")>
  <@section> <#-- title="${uiLabelMap.OrderActions}" -->
      <@menu type="button">
        <#if security.hasEntityPermission("FACILITY", "_CREATE", session) && ((orderHeader.statusId == "ORDER_APPROVED") || (orderHeader.statusId == "ORDER_SENT"))>
          <#-- Special shipment options -->
          <#if orderHeader.orderTypeId == "SALES_ORDER">
          <#else> <#-- PURCHASE_ORDER -->
            <#--<#if orderHeader.orderTypeId == "PURCHASE_ORDER">${uiLabelMap.ProductDestinationFacility}</#if>-->
            <#if ownedFacilities?has_content>
              
              <#-- FIXME
              <#if !allShipments?has_content>
                  <@menuitem type="generic">
                     <form action="/facility/control/quickShipPurchaseOrder?externalLoginKey=${externalLoginKey}" method="post">
                       <input type="hidden" name="initialSelected" value="Y"/>
                       <input type="hidden" name="orderId" value="${orderId}"/>
                       <input type="hidden" name="purchaseOrderId" value="${orderId}"/>
                      <select name="facilityId">
                        <#list ownedFacilities as facility>
                          <option value="${facility.facilityId}">${facility.facilityName}</option>
                        </#list>
                      </select>
                      <input type="submit" class="${styles.link_run_sys!} ${styles.action_add!}" value="${uiLabelMap.OrderQuickReceivePurchaseOrder}"/>
                     </form>
                  </@menuitem>
                  <@menuitem type="generic">
                    <form name="receivePurchaseOrderForm" action="/facility/control/quickShipPurchaseOrder?externalLoginKey=${externalLoginKey}" method="post">
                      <input type="hidden" name="initialSelected" value="Y"/>
                      <input type="hidden" name="orderId" value="${orderId}"/>
                      <input type="hidden" name="purchaseOrderId" value="${orderId}"/>
                      <input type="hidden" name="partialReceive" value="Y"/>
                      <select name="facilityId">
                        <#list ownedFacilities as facility>
                          <option value="${facility.facilityId}">${facility.facilityName}</option>
                        </#list>
                      </select>
                      </form>
                      <a href="javascript:document.receivePurchaseOrderForm.submit()" class="${styles.link_run_sys!} ${styles.action_receive!}">${uiLabelMap.CommonReceive}</a>
                  </@menuitem>
              <#else>
                  <@menuitem type="generic">
                    <form name="receiveInventoryForm" action="/facility/control/ReceiveInventory" method="post">
                      <input type="hidden" name="initialSelected" value="Y"/>
                      <input type="hidden" name="purchaseOrderId" value="${orderId!}"/>
                      <select name="facilityId">
                        <#list ownedFacilities as facility>
                          <option value="${facility.facilityId}">${facility.facilityName}</option>
                        </#list>
                      </select>
                    </form>
                    <a href="javascript:document.receiveInventoryForm.submit()" class="${styles.link_run_sys!} ${styles.action_receive!}">${uiLabelMap.OrderQuickReceivePurchaseOrder}</a>
                  </@menuitem>
                  <@menuitem type="generic">
                    <form name="partialReceiveInventoryForm" action="/facility/control/ReceiveInventory" method="post">
                      <input type="hidden" name="initialSelected" value="Y"/>
                      <input type="hidden" name="purchaseOrderId" value="${orderId!}"/>
                      <input type="hidden" name="partialReceive" value="Y"/>
                      <select name="facilityId">
                        <#list ownedFacilities as facility>
                           <option value="${facility.facilityId}">${facility.facilityName}</option>
                         </#list>
                       </select>
                    </form>
                    <a href="javascript:document.partialReceiveInventoryForm.submit()" class="${styles.link_run_sys!} ${styles.action_receive!}">${uiLabelMap.CommonReceive}</a>
                  </@menuitem>
              </#if>
              
              <#if orderHeader.statusId != "ORDER_COMPLETED">
                  <@menuitem type="generic">
                    <form action="<@ofbizUrl>completePurchaseOrder?externalLoginKey=${externalLoginKey}</@ofbizUrl>" method="post">
                     <input type="hidden" name="orderId" value="${orderId}"/>
                    <select name="facilityId">
                      <#list ownedFacilities as facility>
                        <option value="${facility.facilityId}">${facility.facilityName}</option>
                      </#list>
                    </select>
                    <input type="submit" class="${styles.link_run_sys!} ${styles.action_complete!}" value="${uiLabelMap.OrderForceCompletePurchaseOrder}"/>
                    </form>
                  </@menuitem>
              </#if>
              -->
            </#if>
          </#if>
        </#if>
      </@menu>
      
      <@menu type="button">
        <#if currentStatus.statusId == "ORDER_CREATED" || currentStatus.statusId == "ORDER_PROCESSING">
          <@menuitem type="link" href="javascript:document.OrderApproveOrder.submit()" text="${uiLabelMap.OrderApproveOrder}" class="+${styles.action_run_sys!} ${styles.action_updatestatus!}"><form name="OrderApproveOrder" method="post" action="<@ofbizUrl>changeOrderStatus/orderview</@ofbizUrl>">
            <input type="hidden" name="statusId" value="ORDER_APPROVED"/>
            <input type="hidden" name="newStatusId" value="ORDER_APPROVED"/>
            <input type="hidden" name="setItemStatus" value="Y"/>
            <input type="hidden" name="workEffortId" value="${workEffortId!}"/>
            <input type="hidden" name="orderId" value="${orderId!}"/>
            <input type="hidden" name="partyId" value="${assignPartyId!}"/>
            <input type="hidden" name="roleTypeId" value="${assignRoleTypeId!}"/>
            <input type="hidden" name="fromDate" value="${fromDate!}"/>
          </form></@menuitem>
        <#elseif currentStatus.statusId == "ORDER_APPROVED">
          <@menuitem type="link" href="javascript:document.OrderHold.submit()" text="${uiLabelMap.OrderHold}" class="+${styles.action_run_sys!} ${styles.action_updatestatus!}"><form name="OrderHold" method="post" action="<@ofbizUrl>changeOrderStatus/orderview</@ofbizUrl>">
            <input type="hidden" name="statusId" value="ORDER_HOLD"/>
            <input type="hidden" name="workEffortId" value="${workEffortId!}"/>
            <input type="hidden" name="orderId" value="${orderId!}"/>
            <input type="hidden" name="partyId" value="${assignPartyId!}"/>
            <input type="hidden" name="roleTypeId" value="${assignRoleTypeId!}"/>
            <input type="hidden" name="fromDate" value="${fromDate!}"/>
          </form></@menuitem>
        <#elseif currentStatus.statusId == "ORDER_HOLD">
          <@menuitem type="link" href="javascript:document.OrderApproveOrder.submit()" text="${uiLabelMap.OrderApproveOrder}" class="+${styles.action_run_sys!} ${styles.action_updatestatus!}"><form name="OrderApproveOrder" method="post" action="<@ofbizUrl>changeOrderStatus/orderview</@ofbizUrl>">
            <input type="hidden" name="statusId" value="ORDER_APPROVED"/>
            <input type="hidden" name="setItemStatus" value="Y"/>
            <input type="hidden" name="workEffortId" value="${workEffortId!}"/>
            <input type="hidden" name="orderId" value="${orderId!}"/>
            <input type="hidden" name="partyId" value="${assignPartyId!}"/>
            <input type="hidden" name="roleTypeId" value="${assignRoleTypeId!}"/>
            <input type="hidden" name="fromDate" value="${fromDate!}"/>
          </form></@menuitem>
        </#if>
        <#if currentStatus.statusId != "ORDER_COMPLETED" && currentStatus.statusId != "ORDER_CANCELLED">
          <@menuitem type="link" href="javascript:document.OrderCancel.submit()" text="${uiLabelMap.OrderCancelOrder}" class="+${styles.action_run_sys!} ${styles.action_terminate!}"><form name="OrderCancel" method="post" action="<@ofbizUrl>changeOrderStatus/orderview</@ofbizUrl>">
            <input type="hidden" name="statusId" value="ORDER_CANCELLED"/>
            <input type="hidden" name="setItemStatus" value="Y"/>
            <input type="hidden" name="workEffortId" value="${workEffortId!}"/>
            <input type="hidden" name="orderId" value="${orderId!}"/>
            <input type="hidden" name="partyId" value="${assignPartyId!}"/>
            <input type="hidden" name="roleTypeId" value="${assignRoleTypeId!}"/>
            <input type="hidden" name="fromDate" value="${fromDate!}"/>
          </form></@menuitem>
        </#if>
        <#if setOrderCompleteOption>
          <@menuitem type="link" href="javascript:document.OrderCompleteOrder.submit()" text="${uiLabelMap.OrderCompleteOrder}" class="+${styles.action_run_sys!} ${styles.action_complete!} ${styles.action_importance_high!}"><form name="OrderCompleteOrder" method="post" action="<@ofbizUrl>changeOrderStatus</@ofbizUrl>">
            <input type="hidden" name="statusId" value="ORDER_COMPLETED"/>
            <input type="hidden" name="orderId" value="${orderId!}"/>
          </form></@menuitem>
        </#if>
        <#-- Migrated to OrderShippingSubTabBar
        <#if currentStatus.statusId == "ORDER_APPROVED" && orderHeader.orderTypeId == "SALES_ORDER">
          <@menuitem type="link" href="javascript:document.PrintOrderPickSheet.submit()" text="${uiLabelMap.FormFieldTitle_printPickSheet}" class="+${styles.action_run_sys!} ${styles.action_export!}"><form name="PrintOrderPickSheet" method="post" action="<@ofbizUrl>orderPickSheet.pdf</@ofbizUrl>" target="_BLANK">
            <input type="hidden" name="facilityId" value="${storeFacilityId!}"/>
            <input type="hidden" name="orderId" value="${orderHeader.orderId!}"/>
            <input type="hidden" name="maxNumberOfOrdersToPrint" value="1"/>
          </form></@menuitem>
        </#if>
        -->

        <#-- migrated from OrderSubTabBar -->
        <#-- Order Modification -->
        <#-- Disabled for now, until usefulness is evaluated
        <#if currentStatus.statusId != "ORDER_CANCELLED">
          <@menuitem type="link" href=makeOfbizUrl("loadCartFromOrder?orderId=${orderId}&finalizeMode=init") text="${uiLabelMap.OrderCreateAsNewOrder}" class="+${styles.action_run_session!} ${styles.action_add!}"/>
        </#if>
        --> 
        <#if currentStatus.statusId != "ORDER_COMPLETED" && currentStatus.statusId != "ORDER_CANCELLED">
          <@menuitem type="link" href=makeOfbizUrl("loadCartFromOrder?orderId=${orderId}&finalizeMode=init") text="${uiLabelMap.OrderCreateReplacementOrder}" class="+${styles.action_run_sys!} ${styles.action_add!}"/>
        </#if>
        <#if currentStatus.statusId != "ORDER_COMPLETED" && currentStatus.statusId != "ORDER_CANCELLED">
          <@menuitem type="link" href=makeOfbizUrl("editOrderItems?orderId=${orderId}") text="${uiLabelMap.OrderEditItems}" class="+${styles.action_nav!}"/>
        </#if>

        <#-- Shipping -->
        <#if !shipGroups?has_content>
            <#if currentStatus.statusId != "ORDER_COMPLETED" && currentStatus.statusId != "ORDER_CANCELLED">
              <@menuitem type="link" href=makeOfbizUrl("createOrderItemShipGroup?orderId=${orderId}") text="${uiLabelMap.OrderCreateShipGroup}" class="+${styles.action_run_sys!} ${styles.action_add!}"/>
            </#if>
            <#if security.hasPermission("FACILITY_CREATE", session) && orderHeader.orderTypeId == "SALES_ORDER">
                <#if currentStatus.statusId == "ORDER_APPROVED" || currentStatus.statusId != "ORDER_SENT">
                  <@menuitem type="link" href=makeOfbizUrl("quickShipOrder?orderId=${orderId}") text="${uiLabelMap.OrderQuickShipEntireOrder}" class="+${styles.action_run_sys!} ${styles.action_complete!}"/>
                </#if>
            </#if>
        </#if>
        <#-- Return / Refund -->
        <#if security.hasPermission("ORDERMGR_RETURN", session) && returnableItems?has_content>
            <#if currentStatus.statusId == "ORDER_COMPLETED">
              <@menuitem type="link" href=makeOfbizUrl("quickreturn?orderId=${orderId}&partyId=${partyId}&returnHeaderTypeId=${returnHeaderTypeId}&needsInventoryReceive=${needsInventoryReceive}") text="${uiLabelMap.OrderCreateReturn}" class="+${styles.action_nav!}"/>
            </#if>
        </#if>
        <#if security.hasPermission("ORDERMGR_RETURN", session)>
            <#if currentStatus.statusId == "ORDER_COMPLETED">
              <@menuitem type="link" href=makeOfbizUrl("quickreturn?orderId=${orderId}&partyId=${partyId}&returnHeaderTypeId=${returnHeaderTypeId}&needsInventoryReceive=${needsInventoryReceive}") text="${uiLabelMap.OrderQuickRefundEntireOrder}" class="+${styles.action_nav!} ${styles.action_terminate!}"/>
            </#if>
        </#if>
        <#-- Export >> moved to OrderSideBar
            <@menuitem type="link" href=makeOfbizUrl("order.pdf?orderId=${orderId}") text="PDF" class="+${styles.action_run_sys!} ${styles.action_export!}"/>
        -->
      </@menu>
       
  </@section>
</#if>