<cfcomponent extends="mura.cfobject" output="true">

	<cffunction name="onGlobalRequestStart" access="public" output="false" returntype="any">
		<cfargument name="Mura" hint="mura scope" />
		
		<cfif not application.configBean.getCurrentUser().isSuperUser() 
			and listFindNoCase("cSettings.editPlugin,cSettings.deployPlugin,cSettings.updatePlugin,cSettings.updatePluginVersion,cPlugins.list", Mura.event('muraAction'))>
			<cfset var s = structNew()>
			<cfset s.error = "Plugin configuration not available.">
			<cfset application.userManager.getCurrentUser().setValue("errors", s)>
			<cflocation url="?muraAction=cSettings.list" addtoken="false">
		</cfif>

	</cffunction>

	<cffunction name="onAdminHTMLHeadRender" access="public" output="false" returntype="any">
		<cfargument name="Mura" hint="mura scope" />
		<cfset var returnVar = "">

		<cfif not application.configBean.getCurrentUser().isSuperUser()>
			<cfsavecontent variable="returnVar">
				<script>
					Mura(document).ready(function(){
						Mura('#tabModules .block-content:first').html('<div class="alert alert-error">Module configuration not available.</div>')
						Mura('#tabPlugins .block-content:first').html('<div class="alert alert-error">Plugin configuration not available.</div>')
					});
				</script>
			</cfsavecontent>
		</cfif>

		<cfreturn returnVar>
	</cffunction>		
</cfcomponent>