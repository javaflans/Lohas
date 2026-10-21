<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<jsp:include page="components/header.jsp" />
<!-- 表頭資料區 -->
<input type="hidden" id="breadCrumbLabel" value="${breadCrumb}"/>
<input type="hidden" id="pageLabel" value="${pageLabel}"/>

<table>
	<tr>
		<td width="39%">
			<div id="eventContent">
				<form id="eventForm">
					<fieldset id="event">
						<legend>活動資料</legend>
						<table>
							<tr>
								<td colspan="3">
									<div class="labelSpace">
										<label for="eventType" class="required">活動名稱</label>
									</div> 
									<input type="text" id="eventType" name="eventType" class="k-textbox"
									placeholder="活動名稱" required /><br/>
									<span class="k-invalid-msg" data-for="eventType"></span>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="labelSpace">
										<label for="eventDesc">活動內容</label>
									</div> 
									<textarea id="eventDesc" name="eventDesc"></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="labelSpace">
										<label for="eventDesc">活動日期</label>
									</div> 
									<input id="eventDate" name="eventDate" style="width: 100%;" />
									<script>jQuery(function(){jQuery("#eventDate").kendoDatePicker({
										format: "yyyy/MM/dd", value: new Date(${today.time}), min: new Date(${minDay.time}), max: new Date(${maxDay.time})
									});});</script><br/>
									<div style="height: 15px">
										<span class="k-invalid-msg" data-for="eventDate"></span>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="labelSpace">
										<label for="eventStartDate">活動起始時間</label>
									</div> 
									<input id="eventStartTime" name="eventStartTime" style="width: 100%;" />
									<script>jQuery(function(){jQuery("#eventStartTime").kendoTimePicker({
										format: "hh:mm tt", value: new Date(${startValue.time}), min: new Date(${startMin.time}), max: new Date(${startMax.time})
									});});</script><br/>
									<div style="height: 15px">
										<span class="k-invalid-msg" data-for="eventStartTime"></span>
									</div>
								</td>
								<td><div>　</div></td>
								<td>
									<div class="labelSpace">
										<label for="eventDesc">活動截止時間</label>
									</div> 
									<input id="eventEndTime" name="eventEndTime" style="width: 100%;" />
									<script>jQuery(function(){jQuery("#eventEndTime").kendoTimePicker({
										format: "hh:mm tt", value: new Date(${endValue.time}), min: new Date(${endMin.time}), max: new Date(${endMax.time})
									});});</script><br/>
									<div style="height: 15px">
										<span class="k-invalid-msg" data-for="eventEndTime"></span>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="labelSpace">
										<label for="eventDesc">活動地點</label>
									</div> 
									<input id="beaconID" name="beaconID" />
									<script>jQuery(function(){jQuery("#beaconID").kendoDropDownList({
										dataTextField: "locatLV1", dataValueField: "beaconID",
										dataSource: { data: ${beaconListJson} }
									});});</script>
							    </td>
							</tr>
						</table>
					</fieldset>
					<span class="eventStatus"></span>
					<br/><br/>
					<a id="eventSubmit" class="eventSubmit">新增活動</a>
					<script>jQuery(function(){jQuery("#eventSubmit").kendoButton({});});</script>
				</form>
			</div>
		</td>
		<td>
			<div id="grid" style="height:480px;min-height:550px;"></div>
			<script>
			jQuery(function(){jQuery("#grid").kendoGrid({
				sortable: true,
				filterable: true,
				columnMenu: true,
				selectable: "multiple row",
				columns: [
					{ title: "活動名稱", width: 105, field: "eventType" },
					{ title: "起始時間", field: "eventStartDate", format: "{0:MM/dd/yyyy HH:mm:ss}" },
					{ title: "截止時間", field: "eventEndDate", format: "{0:MM/dd/yyyy HH:mm:ss}" },
					{ title: "活動地點", field: "locatLV1", template: "<div>#:data.locatLV0 #-#:data.locatLV1 #</div>" },
					{ title: "動作", width: 90, command: [ { name: "viewDetails", text: "刪除", click:
		                            function showDetails(e) {
		                            	var jsonDataArray = new Array();
		                                var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
		                                var jsonData = {};
		                    			jsonData["id"] = dataItem.id;
		                                jsonDataArray.push(jsonData);
                                    	
                                       	$.ajax({
                            	            type: 'POST',
                            	            contentType : "application/json",
                            	            url: "api/deleteEventView",
                            	            data: JSON.stringify(jsonDataArray), 
                            	            dataType: 'json',
                            	            timeout : 100000,
                            	            success: function(data, result) {
                            	            	if(data.code == 200){
                            	            		$("#grid").data("kendoGrid").dataSource.read();
                            	            	}
                            	            },
                            	            error: function(e) {
                            	            	alert(e.tostring());
                            	            }
                            	        });
		                            }
					} ] }
				],
				pageable: { refresh: true, pageSizes: true, buttonCount: 5 },
				dataSource: {
					pageSize: 10,
					schema: { model: { fields: {
						eventType: { type: "string" },
						eventStartDate: { type: "string" },
						eventEndDate: { type: "string" },
						locatLV1: { type: "string" }
					} } },
					transport: {
						read: { type: "POST", url: "api/getEventList" },
						parameterMap:
			             		function parameterMap(options) { 
			            			return JSON.stringify(options);
			             		}
					}
				}
			});});
			</script>
			<div style="margin-left: 20px; font-size: 18px; color:#ff8040; font-weight: bolder;">請注意! 顯示結果不為當日過去的資料</div>
		</td>
	</tr>
</table>

	

<!-- 引入 本程式的 JS, CSS -->
<script src="<c:url value='/resources/js/${menuName}.js'/>" type="text/javascript" ></script>
<link   href="<c:url value='/resources/css/${menuName}.css' />" type='text/css' rel="stylesheet" />

<jsp:include page="components/footer.jsp" />

