# SSRS Report Builder Part 3 - Saving to a Report Server

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: Describe the difference between saving locally and publishing to a Report Server, show how to save/publish from Report Builder, cover required permissions and data source settings, and offer troubleshooting tips and best practices for deployment.

**Overview**
- Report Builder lets you save reports to your local disk (RDL files) or directly to a Report Server. Saving locally is useful for backups or offline editing; publishing to the server makes the report available to users via the web portal and enables scheduling, security, and centralized management.

**Prerequisites**
- A running SSRS instance and Report Server web portal URL (e.g. `http://<report-server>/reports`).
- An account that has permission to save or publish reports on the target folder (Publisher/Content Manager/Folder-level role as configured by your admin).
- A working Data Source (shared or embedded) with credentials that allow the report to run on the server.

Save vs Publish (Report Builder terminology)
- Save to File: stores the report locally as an `.rdl` file. Use `File` → `Save As` → `Save to your computer`.
- Save to Report Server (Publish): stores the report in a folder on the Report Server and makes it accessible via the portal. Use `File` → `Save As` → `Save to Report Server`.

1) Save to Report Server (step-by-step)
- In Report Builder: `File` → `Save As` → `Save to Report Server`.
- Enter the Report Server URL if prompted (for example `http://your-server/reports`) and click Connect.
- Browse to or create the target folder on the server where you want to store the report.
- Give the report a meaningful name and (optionally) a description.
- Click `Save` to publish the report to the selected folder.

What happens when you save:
- The RDL file is uploaded to the Report Server; server-side settings such as item properties, snapshots, and subscription options become available depending on your permissions.
- If the report references a shared data source, the server will try to use the referenced shared data source; if it uses an embedded data source, the connection information is saved with the report.

2) Save to your computer (RDL file)
- `File` → `Save As` → `Save to your computer` → choose a folder and filename.
- Use local saves for versioning, code review, or for handoff into SSDT for team development.

3) Data source and credential considerations
- Shared Data Sources: recommended for production reports. When publishing, choose a shared data source on the server if available to centralize credential management.
- Embedded Data Sources: connection info is stored in the report. Avoid storing plain-text credentials in embedded data sources on production reports.
- Credentials for the Report Server: configure stored credentials on the shared data source or configure the data source to use Windows Integrated Security	—ensure the account the server uses has DB access.

4) Overwriting existing reports and versioning
- If a report with the same name exists in the target folder, saving will overwrite it (if you have permission). Consider adding version numbers to names or use a source control workflow via SSDT.
- To maintain an audit trail, prefer developing in SSDT with source control and deploy from a build pipeline rather than allowing direct edits on production.

5) Deploying from SSDT (alternate route)
- For team scenarios, store RDLs in a Visual Studio (SSDT) solution and use build/deploy routines to push reports to the Report Server. This enables source control, CI/CD, and repeatable deployments.

6) Troubleshooting common issues
- Cannot connect to Report Server:
	- Verify the server URL and that SSRS is running.
	- Ensure firewall or network rules allow access.
- Save fails with permission errors:
	- Confirm the user account has appropriate SSRS folder permissions (Publisher/Content Manager or custom role).
- Report runs locally but fails on the server:
	- Check the data source credentials used by the server.
	- Verify network access and DB permissions for the account configured on the server's data source.
- Browser shows an old version after publish:
	- Clear the browser cache or use the portal's refresh. Confirm the report version/date in the portal's properties.

7) Best practices and checklist before publishing
- Use shared data sources for production environments and configure stored credentials on the server.
- Avoid embedding sensitive credentials in RDL files.
- Test the report in a Test environment before publishing to Production.
- Keep RDLs in source control (SSDT) and use a controlled deployment process for production changes.
- Add a descriptive name and description when saving to the server to help users find and understand the report.

**Quick checklist**
- [ ] Report runs successfully in Preview.
- [ ] Data source is configured and credentials work on the server.
- [ ] You have publish permissions on the target folder.
- [ ] RDL saved to source control (if part of a team workflow).

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
