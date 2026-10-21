<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<jsp:include page="components/header.jsp" />
<!-- 表頭資料區 -->
<input type="hidden" id="pageLabel" value="${menus.get(0).getLabel()}"/>

<div id="grid" style="height:450px;"></div>
<script>
jQuery(function(){jQuery("#grid").kendoGrid({
	sortable: true,
	filterable: true,
	columnMenu: true,
	selectable: "multiple row",
	columns: [
		{ title: "姓名", width: 120, field: "linkedName",
			template: "<div class='customer-photo' style='background-image: url(resources/photo/resident/#:data.residentPhotoPath#);'></div><div class='customer-name'>#:data.linkedName #</div>" },
		{ title: "狀態", columns: [
			{ title: "狀態圖示", width: 180, field: "locatLV1",
				template: "#"
					+ " if(data.isLinked){"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/linked.png);'></div>#"
					+ " } else {"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/disLinked.png);'></div>#"
					+ " }"
					+ " if(data.isBeacon && data.beaconID != '00000'){"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/beacon.png);'></div>#"
					+ " }else{"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/no_beacon.png);'></div>#"
					+ " }"
					+ " if(data.isFreezed2){"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/freezed2.png);'></div>#"
					+ " } else if(data.isFreezed1){"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/freezed1.png);'></div>#"
					+ " }"
					+ " if(data.isGPS){"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/gps.png);'></div>#"
					+ " }"
					+ " if(data.isLost){"
					+ " #<div class='customer-photo' style='background-image: url(resources/data/status/lost.png);'></div>#"
					+ " }"
					+ " if(data.isLowBattery){"
					+ " #<div class='customer-photo flash-effect' style='background-image: url(resources/data/status/low_battery.png);'></div>#"
					+ " }"
					+ " if(data.isSOS){"
					+ " #<div class='soscontent'><div class='customer-photo sos' style='background-image: url(resources/data/status/sos.png);'></div></div>#"
					+ " }"
					+ " #" },
			{ title: "活動內容", width: 130, field: "eventType" }
		] },
		{ title: "住民資訊", columns: [
			{ title: "資料時間", width: 165, field: "tagTime" },
			{ title: "性別", width: 65, field: "residentSex" },
			{ title: "生日", width: 100, field: "residentBirthday" }
		] },
		{ title: "定位資訊", columns: [
			{ title: "位置", width: 180, field: "locatLV1",
				template: "#:data.locatLV1##if(data.locatLV2!=''){#/#}##:data.locatLV2#" }
		] },
		{ title: "聯絡人資訊", columns: [
			{ title: "聯絡人", width: 80, field: "contactLocalName" },
			{ title: "Mail", width: 100, field: "contactMail" },
			{ title: "聯絡電話", width: 100, field: "contactPhone" },
			{ title: "聯絡地址", width: 240, field: "contactCity",
				template: "(#:data.contactZipCode#)#:data.contactCity##:data.contactArea##:data.contactAddress#" }
		] }
	],
	pageable: { refresh: true, pageSizes: true, buttonCount: 5 },
	dataSource: {
		pageSize: 20,
		schema: { model: { fields: {
			tagTime: { type: "string" },
			linkedName: { type: "string" },
			residentSex: { type: "string" },
			residentBirthday: { type: "string" },
			contactLocalName: { type: "string" },
			contactMail: { type: "string" },
			contactPhone: { type: "string" },
			contactCity: { type: "string" },
			locatLV1: { type: "string" },
			eventType: { type: "string" }
		} } },
		transport: { read: { type: "POST", url: "api/getTrackHistory" } }
	}
});});
</script>

<!-- 引入 本程式的 JS, CSS -->

<script src="<c:url value='/resources/js/${menuName}.js'/>" type="text/javascript" ></script>
<link   href="<c:url value='/resources/css/${menuName}.css' />" type='text/css' rel="stylesheet" />

<jsp:include page="components/footer.jsp" />

