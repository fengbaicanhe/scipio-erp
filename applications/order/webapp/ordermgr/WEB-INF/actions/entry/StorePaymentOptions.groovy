/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.product.store.*;

productStore = ProductStoreWorker.getProductStore(request);

productStorePaymentMethodTypeIdMap = new HashMap();
productStorePaymentSettingList = productStore.getRelated("ProductStorePaymentSetting", null, null, true);
productStorePaymentSettingIter = productStorePaymentSettingList.iterator();
while (productStorePaymentSettingIter.hasNext()) {
    productStorePaymentSetting = productStorePaymentSettingIter.next();
    productStorePaymentMethodTypeIdMap.put(productStorePaymentSetting.get("paymentMethodTypeId"), true);
}
context.put("productStorePaymentMethodTypeIdMap", productStorePaymentMethodTypeIdMap);

context.productStorePaymentSettingList = productStorePaymentSettingList; // SCIPIO: make available

// SCIPIO: we can put more info than just booleans...
productStorePaymentMethodSettingByTypeMap = new HashMap();
for (productStorePaymentSetting in productStorePaymentSettingList) {
    productStorePaymentMethodSettingByTypeMap.put(productStorePaymentSetting.get("paymentMethodTypeId"), productStorePaymentSetting);
}
context.productStorePaymentMethodSettingByTypeMap = productStorePaymentMethodSettingByTypeMap;

