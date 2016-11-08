<#macro tablelist flag>
    <#if flag == "1">
        <#list table.columnList as c>
            <#if c.isEdit?? && c.isEdit == "1" && (c.isNotBaseField || c.simpleJavaField == 'remarks')>
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">${c.comments}：</label>
                <div class="col-lg-5">
                    <#if c.showType == "input">
                        <form:input path="${c.javaFieldId}" htmlEscape="false"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="form-control <#if c.isNull != "1">required</#if><#if c.javaType == "Long" || c.javaType == "Integer"> digits</#if><#if c.javaType == "Double"> number</#if>"/>
                    <#elseif c.showType == "textarea">
                        <form:textarea path="${c.javaFieldId}" htmlEscape="false" rows="4"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="form-control <#if c.isNull != "1">required</#if>"/>
                    <#elseif c.showType == "select">
                        <form:select path="${c.javaFieldId}" class="selectcss <#if c.isNull != "1">required</#if>">
                            <form:option value="" label=""/>
                            <form:options items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    <#elseif c.showType == "checkbox">
                        <form:checkboxes path="${c.javaFieldId}" items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false" class="<#if c.isNull != "1">required</#if>"/>
                    <#elseif c.showType == "radiobox">
                        <form:radiobuttons path="${c.javaFieldId}" items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false" class="<#if c.isNull != "1">required</#if>"/>
                    <#elseif c.showType == "dateselect">
                        <input name="${c.javaFieldId}" type="text" readonly="readonly" maxlength="20" class="form-control Wdate <#if c.isNull != "1">required</#if>"
                               value="<fmt:formatDate value="${"$"}{${className}.${c.javaFieldId}}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
                    <#elseif c.showType == "userselect">
                        <sys:treeselect id="${c.simpleJavaField}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                        title="用户" url="/office/treeData.do?type=3" cssClass="selectcss <#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
                    <#elseif c.showType == "officeselect">
                        <sys:treeselect id="${c.simpleJavaField}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                        title="部门" url="/office/treeData.do?type=2" cssClass="selectcss <#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
                    <#elseif c.showType == "areaselect">
                        <sys:treeselect id="${c.simpleJavaField}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                        title="区域" url="/area/treeData.do" cssClass="selectcss <#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
                    <#elseif c.showType == "fileselect">
                        <form:hidden id="${c.simpleJavaField}" path="${c.javaFieldId}" htmlEscape="false"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="form-control"/>
                        <sys:ckfinder input="${c.simpleJavaField}" type="files" uploadPath="/${moduleName}<#if subModuleName != "">/${subModuleName}</#if>/${className}" selectMultiple="true"/>
                    </#if>
                </div>
            </div>
            </#if>
        </#list>
    <#elseif flag == "2">
        <#list table.childList as child>
        <div class="form-group">
            <label class="control-label col-lg-2 ftext">${child.comments}：</label>
            <div class="col-lg-5">
                <table id="contentTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                    <tr>
                        <th class="hide"></th>
                        <#assign childColumnCount = 0 /><#list child.columnList as c>
                        <#if c.isEdit?? && c.isEdit == "1" && (c.isNotBaseField || c.simpleJavaField == 'remarks') && c.name != c.genTable.parentTableFk>
                            <th>${c.comments}</th><#assign childColumnCount = childColumnCount + 1 />
                        </#if>
                    </#list>
                        <shiro:hasPermission name="${permissionPrefix}:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
                    </tr>
                    </thead>
                    <tbody id="${child.className?uncap_first}List">
                    </tbody>
                    <shiro:hasPermission name="${permissionPrefix}:edit"><tfoot>
                    <tr><td colspan="${childColumnCount + 2}"><a href="javascript:" onclick="addRow('#${child.className?uncap_first}List', ${child.className?uncap_first}RowIdx, ${child.className?uncap_first}Tpl);${child.className?uncap_first}RowIdx = ${child.className?uncap_first}RowIdx + 1;" class="btn">新增</a></td></tr>
                    </tfoot></shiro:hasPermission>
                </table>
                <script type="text/template" id="${child.className?uncap_first}Tpl">//<!--
						<tr id="${child.className?uncap_first}List{{idx}}">
							<td class="hide">
								<input id="${child.className?uncap_first}List{{idx}}_id" name="${child.className?uncap_first}List[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="${child.className?uncap_first}List{{idx}}_delFlag" name="${child.className?uncap_first}List[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<#list child.columnList as c>
								<#if c.isEdit?? && c.isEdit == "1" && (c.isNotBaseField || c.simpleJavaField == 'remarks') && c.name != c.genTable.parentTableFk>
							<td>
							<#if c.showType == "input">
								<input id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" type="text" value="{{row.${c.javaFieldId}}}"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="input-small <#if c.isNull != "1">required</#if><#if c.javaType == "Long" || c.javaType == "Integer"> digits</#if><#if c.javaType == "Double"> number</#if>"/>
							<#elseif c.showType == "textarea">
								<textarea id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" rows="4"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="input-small <#if c.isNull != "1">required</#if>">{{row.${c.javaFieldId}}}</textarea>
							<#elseif c.showType == "select">
								<select id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" data-value="{{row.${c.javaFieldId}}}" class="input-small <#if c.isNull != "1">required</#if>">
									<option value=""></option>
									<c:forEach items="${"$"}{fns:getDictList('${c.dictType}')}" var="dict">
										<option value="${"$"}{dict.value}">${"$"}{dict.label}</option>
									</c:forEach>
								</select>
							<#elseif c.showType == "checkbox">
								<c:forEach items="${"$"}{fns:getDictList('${c.dictType}')}" var="dict" varStatus="dictStatus">
									<span><input id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}${"$"}{dictStatus.index}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" type="checkbox" value="${"$"}{dict.value}" data-value="{{row.${c.javaFieldId}}}"><label for="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}${"$"}{dictStatus.index}">${"$"}{dict.label}</label></span>
								</c:forEach>
							<#elseif c.showType == "radiobox">
								<c:forEach items="${"$"}{fns:getDictList('${c.dictType}')}" var="dict" varStatus="dictStatus">
									<span><input id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}${"$"}{dictStatus.index}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" type="radio" value="${"$"}{dict.value}" data-value="{{row.${c.javaFieldId}}}"><label for="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}${"$"}{dictStatus.index}">${"$"}{dict.label}</label></span>
								</c:forEach>
							<#elseif c.showType == "dateselect">
								<input id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate <#if c.isNull != "1">required</#if>"
									value="{{row.${c.javaFieldId}}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<#elseif c.showType == "userselect">
								<sys:treeselect id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" value="{{row.${c.javaFieldId}}}" labelName="${child.className?uncap_first}List{{idx}}.${c.javaFieldName}" labelValue="{{row.${c.javaFieldName}}}"
									title="用户" url="/office/treeData.do?type=3" cssClass="<#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
							<#elseif c.showType == "officeselect">
								<sys:treeselect id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" value="{{row.${c.javaFieldId}}}" labelName="${child.className?uncap_first}List{{idx}}.${c.javaFieldName}" labelValue="{{row.${c.javaFieldName}}}"
									title="部门" url="/office/treeData.do?type=2" cssClass="<#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
							<#elseif c.showType == "areaselect">
								<sys:treeselect id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.javaFieldId}" value="{{row.${c.javaFieldId}}}" labelName="${child.className?uncap_first}List{{idx}}.${c.javaFieldName}" labelValue="{{row.${c.javaFieldName}}}"
									title="区域" url="/area/treeData.do" cssClass="<#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
							<#elseif c.showType == "fileselect">
								<input id="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" name="${child.className?uncap_first}List[{{idx}}].${c.simpleJavaField}" type="hidden" value="{{row.${c.javaFieldId}}}"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if>/>
								<sys:ckfinder input="${child.className?uncap_first}List{{idx}}_${c.simpleJavaField}" type="files" uploadPath="/${moduleName}<#if subModuleName != "">/${subModuleName}</#if>/${className}" selectMultiple="true"/>
							</#if>
							</td>
								</#if>
							</#list>
							<td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#${child.className?uncap_first}List{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td>
						</tr>//-->
                </script>
                <script type="text/javascript">
                    var ${child.className?uncap_first}RowIdx = 0, ${child.className?uncap_first}Tpl = $("#${child.className?uncap_first}Tpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                    $(document).ready(function() {
                        var data = ${"$"}{fns:toJson(${className}.${child.className?uncap_first}List)};
                        for (var i=0; i<data.length; i++){
                            addRow('#${child.className?uncap_first}List', ${child.className?uncap_first}RowIdx, ${child.className?uncap_first}Tpl, data[i]);
                            ${child.className?uncap_first}RowIdx = ${child.className?uncap_first}RowIdx + 1;
                        }
                    });
                </script>
            </div>
        </div>
        </#list>
    <#else>
        <#list table.columnList as c>
            <#if c.simpleJavaField == 'parent'>
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">上级${c.comments}:</label>
                <div class="col-lg-5">
                    <sys:treeselect id="${c.simpleJavaField}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                    title="${c.comments}" url="/${urlPrefix}/treeData.do" extId="${'$'}{${className}.id}" cssClass="selectcss" allowClear="true"/>
                </div>
            </div>
            <#elseif c.isEdit?? && c.isEdit == "1" && (c.isNotBaseField || c.simpleJavaField == 'remarks')>
            <div class="form-group">
                <label class="control-label col-lg-2 ftext">${c.comments}：</label>
                <div class="col-lg-5">
                    <#if c.showType == "input">
                        <form:input path="${c.javaFieldId}" htmlEscape="false"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="form-control <#if c.isNull != "1">required</#if><#if c.javaType == "Long" || c.javaType == "Integer"> digits</#if><#if c.javaType == "Double"> number</#if>"/>
                    <#elseif c.showType == "textarea">
                        <form:textarea path="${c.javaFieldId}" htmlEscape="false" rows="4"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="form-control <#if c.isNull != "1">required</#if>"/>
                    <#elseif c.showType == "select">
                        <form:select path="${c.javaFieldId}" class="selectcss <#if c.isNull != "1">required</#if>">
                            <form:option value="" label=""/>
                            <form:options items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    <#elseif c.showType == "checkbox">
                        <form:checkboxes path="${c.javaFieldId}" items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false" class="<#if c.isNull != "1">required</#if>"/>
                    <#elseif c.showType == "radiobox">
                        <form:radiobuttons path="${c.javaFieldId}" items="${"$"}{fns:getDictList('${c.dictType}')}" itemLabel="label" itemValue="value" htmlEscape="false" class="<#if c.isNull != "1">required</#if>"/>
                    <#elseif c.showType == "dateselect">
                        <input name="${c.javaFieldId}" type="text" readonly="readonly" maxlength="20" class="form-control Wdate <#if c.isNull != "1">required</#if>"
                               value="<fmt:formatDate value="${"$"}{${className}.${c.javaFieldId}}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
                    <#elseif c.showType == "userselect">
                        <sys:treeselect id="${c.simpleJavaField}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                        title="用户" url="/office/treeData.do?type=3" cssClass="selectcss <#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
                    <#elseif c.showType == "officeselect">
                        <sys:treeselect id="${c.simpleJavaField}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                        title="部门" url="/office/treeData.do?type=2" cssClass="selectcss <#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
                    <#elseif c.showType == "areaselect">
                        <sys:treeselect id="${c.simpleJavaField}" name="${c.javaFieldId}" value="${"$"}{${className}.${c.javaFieldId}}" labelName="${c.javaFieldName}" labelValue="${"$"}{${className}.${c.javaFieldName}}"
                                        title="区域" url="/area/treeData.do" cssClass="selectcss <#if c.isNull != "1">required</#if>" allowClear="true" notAllowSelectParent="true"/>
                    <#elseif c.showType == "fileselect">
                        <form:hidden id="${c.simpleJavaField}" path="${c.javaFieldId}" htmlEscape="false"<#if c.dataLength != "0"> maxlength="${c.dataLength}"</#if> class="form-control"/>
                        <sys:ckfinder input="${c.simpleJavaField}" type="files" uploadPath="/${moduleName}<#if subModuleName != "">/${subModuleName}</#if>/${className}" selectMultiple="true"/>
                    </#if>
                </div>
            </div>
            </#if>
        </#list>
    </#if>

</#macro>