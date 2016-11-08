<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="content" type="java.lang.String" required="true" description="消息内容"%>
<%@ attribute name="type" type="java.lang.String" description="消息类型：info、success、warning、error、loading"%>
	<c:if test="${not empty type}"><c:set var="ctype" value="${type}"/></c:if><c:if test="${empty type}"><c:set var="ctype" value="${fn:indexOf(content,'失败') eq -1?'success':'error'}"/></c:if>
	<div id="messagediv"  name="messagediv" class="alert alert-${type} fade in" style="display:none;text-align: center;font-size:14px; font-family:"微软雅黑"">
	<button type="button" class="close close-sm" data-dismiss="alert">
		<i class="fa fa-times"></i>
	</button>
	<span  id="rmessage" name="rmessage">${content}</span>
	</div>
