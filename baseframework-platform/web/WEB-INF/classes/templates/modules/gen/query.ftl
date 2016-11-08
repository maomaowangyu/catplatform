<#macro query>

<style type="text/css">
    .div-broder {margin: 5px 5px 5px 5px}
</style>
    <#assign x=0 />
<div style="width: 800px">
    <#list table.columnList as c>
        <#if c.isQuery?? && c.isQuery == "1">
            <#assign x=x+1 />
            <#if x%4==0 >
                </br>
                <#assign x=0 />
            </#if>
            <div style="float:left;" class="div-broder">
                <#if c.showType == "input" || c.showType == "textarea">
                    <form:input path="${c.javaFieldId}" placeholder="${c.comments}" htmlEscape="false"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="form-control"/>
                <#elseif c.showType == "select">
                    <form:select path="${c.javaFieldId}" class="selectcss">
                        <form:option value="" label=""/>
                        <form:options items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                <#elseif c.showType == "checkbox">
                    <form:checkboxes path="${c.javaFieldId}" items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                <#elseif c.showType == "radiobox">
                    <form:radiobuttons path="${c.javaFieldId}" items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                <#elseif c.showType == "dateselect" && c.queryType == "between">
                    <input name="begin${c.simpleJavaField?cap_first}" type="text" readonly="readonly" maxlength="20" class="form-control  Wdate"
                           value="<fmt:formatDate value="${"$"}{${className}.begin${c.simpleJavaField?cap_first}}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
                </div>
                <div style="float:left;" class="div-broder">
                    <input name="end${c.simpleJavaField?cap_first}" type="text" readonly="readonly" maxlength="20" class="form-control  Wdate"
                           value="<fmt:formatDate value="${"$"}{${className}.end${c.simpleJavaField?cap_first}}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
                <#elseif c.showType == "dateselect">
                    <input name="${c.javaFieldId}" type="text" readonly="readonly" maxlength="20" class="form-control Wdate"
                           value="<fmt:formatDate value="${"$"}{${className}.${c.javaFieldId}}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
                <#elseif c.showType == "userselect">
                    <sys:treeselect id="${c.simpleJavaField}"  placeholder="${c.comments}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                    title="用户" url="/office/treeData.do?type=3" cssClass="selectcss" allowClear="true" notAllowSelectParent="true"/>
                <#elseif c.showType == "officeselect">
                    <sys:treeselect id="${c.simpleJavaField}"  placeholder="${c.comments}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                    title="部门" url="/office/treeData.do?type=2" cssClass="selectcss" allowClear="true" notAllowSelectParent="true"/>
                <#elseif c.showType == "areaselect">
                    <sys:treeselect id="${c.simpleJavaField}"  placeholder="${c.comments}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                    title="区域" url="/area/treeData.do" cssClass="selectcss" allowClear="true" notAllowSelectParent="true"/>
                </#if>
            </div>

        </#if>
    </#list>
</div>
</#macro>
