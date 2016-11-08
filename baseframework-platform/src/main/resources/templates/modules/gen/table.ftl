<#macro tablelist>
<table id="treeTable" class="table table-striped table-bordered table-condensed tree_table">
    <thead>
    <tr>
        <#list table.columnList as c>
            <#if c.isList?? && c.isList == "1">
                <th>${c.comments}</th>
            </#if>
        </#list>
        <shiro:hasPermission name="sys:role:edit">
            <th><spring:message code="operation" /></th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${r"${page.list}"}" var="${className}">
        <tr>
            <#assign firstListField = true>
            <#list table.columnList as c>
                <#if c.isList?? && c.isList == "1">
                    <td>
                        <#--<#if firstListField>-->
                            <#--<a href="${r"${ctx}"}/${urlPrefix}/form?id=${"${"+className+".id}"}">-->
                        <#--</#if>-->
                        <#if c.simpleJavaType == "Date">
                            <fmt:formatDate value="${"$"}{${className}.${c.javaFieldId}}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        <#elseif c.showType == "select" || c.showType == "checkbox" || c.showType == "radiobox">
                             ${"$"}{fns:getDictLabel(${className}.${c.javaFieldId}, '${c.dictType}', '')}
                        <#elseif c.showType == "userselect" || c.showType == "officeselect" || c.showType == "areaselect">
                            ${"$"}{${className}.${c.javaFieldName}}
                        <#else>
                            ${"$"}{${className}.${c.javaFieldId}}
                        </#if>
                        <#--<#if firstListField></a></#if>-->
                    </td>
                    <#assign firstListField = false>
                </#if>
            </#list>

            <shiro:hasPermission name="${permissionPrefix}:edit">
                <td nowrap>
                    <a href="#" onclick="modi('${"${"+className+".id}"}');"><spring:message code="edit" /></a>
                    <a href="#" onclick="return confirmx('是否要删除该信息', '<c:url value="${"$"}{fns:getAdminPath()}/${moduleName}/${className}/delete.do"/>?id=${"${"+className+".id}"}')"><spring:message code="delete" /></a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach></tbody>
</table>
</#macro>