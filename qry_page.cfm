<cfheader
		name="Content-Type"
		value="application/json">

<cfif fusebox.fuseAction eq 'content.locations.list'>

			<cfquery datasource="#Application.datasource.gpp#" name="q_content_groups">
				SELECT
				   	 [typeID] as groupid
			      ,[typeLabel] as groupname
				FROM
						[types]
				WHERE typeGroup = 'content'
				ORDER BY typeLabel
			</cfquery>
			<cfoutput>#serializeJSON(q_content_groups, 'struct')#</cfoutput>
</cfif>

<cfif fusebox.fuseAction eq 'content.group.put'>


			<cfquery datasource="#Application.datasource.gpp#" name="q_content_groups_put">
				INSERT INTO types
						(
							typeID,
							typeLabel,
							typeGroup
						)
				OUTPUT INSERTED.typeID
				VALUES
						(
							((SELECT TOP 1 typeID FROM Types WHERE typeGroup = 'content' ORDER BY typeID DESC) + 1),
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.value#">,
							'content'
						)
			</cfquery>
			<cfscript>
				group = {
					'GROUPID' : q_content_groups_put.typeID,
					'GROUPNAME' : form.value
				};
				WriteOutput(serializeJSON(group));
			</cfscript>
			<!--- <cfoutput>{"GROUPID":#q_content_groups_put.typeID#, "GROUPNAME": "#form.value#"}</cfoutput> --->
</cfif>

<cfif fusebox.fuseAction eq 'content.item.add'>

			<cfscript>
				///if form.contentID eq 0 , meaning a new content call fnction to create new record
				if( form.contentID eq 0){
						form.contentID = contentAdd(form.contentTypeID);
				}
			</cfscript>

			<cfquery>
					UPDATE
						 [contents]
					SET
						 [contentType] 				= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contentType#">
						,[pageTitle]					= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title#">
						,[contentName]				= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">
						,[contentDateUpdated] = getdate()
						,[contentStaffIDupdated]= <cfqueryparam cfsqltype="cf_sql_integer" value="#session.staffID#">
						,[contentLabel] 			= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subject#">
						,[contentHTML] 				= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contentbody#">
						,[contentText] 				= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">
					WHERE
						 [contentID] = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.contentID#">
			</cfquery>
			<cfoutput>[{"item":"done"}]</cfoutput>
</cfif>

<cfif fusebox.fuseAction eq 'content.item.get'>

			<cfquery datasource="#Application.datasource.gpp#" name="q_content">
				SELECT TOP 1
					 [contentID]
					 ,[contentTypeID] as TypeID
					 ,[contentArea]
					 ,[pageTitle]
					 ,[contentName] as name
					 ,[contentLabel]
					 ,[contentText]
					 ,[contentHTML] as html
					 ,[contentType]
					 <!--- ,[contentDateAdded]
					 ,[contentDateUpdated]
					 ,[contentStaffIDadded]
					 ,[contentStaffIDupdated] --->
				FROM
					[contents]
				WHERE
					contentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.contentID#">
			</cfquery>
			<cfscript>
					newContent = ArrayNew(1);
					ArrayAppend(newContent, generateBlankContent());
					content = (q_content.recordcount eq 0) ? newContent : q_content;
			</cfscript>
			<cfoutput>#serializeJSON(content, 'struct')#</cfoutput>
</cfif>

<cffunction name="generateBlankContent" returnType="struct" access="public" >
	<cfscript>

			return {
				contentID 	: 0,
				TypeID 			: 0,
				contentArea : '',
				pageTitle 	: '',
				name 				: 'Create New Content',
				contentLabel: '',
				contentText : '',
				html 				: '',
				contentType : 'html'
			};
	</cfscript>
</cffunction>


<cfif fusebox.fuseAction eq 'content.groups.list'>

			<cfquery datasource="#Application.datasource.gpp#" name="q_content_list">
				SELECT
					 dbo.contents.contentID
					<!--- , dbo.contents.contentArea AS groups --->
					, dbo.contents.contentName AS name
					<!--- , dbo.contents.contentDateAdded AS dateAdded --->
					, CONVERT(VARCHAR, dbo.contents.contentDateUpdated, 111)  AS dateUpdated
					<!--- , dbo.contents.contentStaffIDadded AS StaffIDadded --->
					<!--- , dbo.contents.contentStaffIDupdated AS StaffIDupdated --->
					, dbo.contents.contentType AS type
					<!--- , dbo.contents.contentHTML AS HTML --->
					<!--- , staff_1.staffName AS staffAddedName --->
					, dbo.staff.staffName AS staffUpddatedName
					<!--- , dbo.contents.contentTypeID AS TypeID --->
				FROM
					dbo.contents
				LEFT OUTER JOIN
					dbo.staff
				ON
					dbo.contents.contentStaffIDupdated = dbo.staff.staffID
				LEFT OUTER JOIN
					dbo.staff AS staff_1 ON dbo.contents.contentStaffIDadded = staff_1.staffID
				WHERE
					 [contentTypeID] = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.groupID#">
				ORDER BY contentName
			</cfquery>

			<cfoutput>#serializeJSON(q_content_list, 'struct')#</cfoutput>
</cfif>


<cffunction name="contentAdd" returnType="numeric" access="private" description="add a new content record"  displayName="add new content">
	<cfargument name="contentTypeID" type="numeric" required="yes" default="0" displayname="This is the ID of he category">
		<cfquery datasource="#Application.datasource.gpp#" name="insert">
				INSERT INTO contents
						(
					 		[contentTypeID],
							[contentStaffIDadded],
							[contentDateAdded]
					 	)
				OUTPUT inserted.contentID
				VALUES
						(
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.contentTypeID#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#session.staffID#">,
							getDate()
						)
		</cfquery>
	<cfreturn insert.contentID>
</cffunction>
