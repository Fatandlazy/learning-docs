# SSRS Report Builder Part 1 - Installing Report Builder

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/RxIzJbEbC8w)

Objective: Guide to installing Microsoft Report Builder, download/install options, post-install checks, and some common troubleshooting tips.

**When should you use Report Builder?**
- Use it when end users or report authors want to quickly create or edit reports on SSRS without installing Visual Studio/SSDT.
- Report Builder is suitable for quick tasks, ad-hoc reporting, and editing reports when deploying to a Report Server.

**Basic requirements**
- Operating system: Windows (Report Builder is a Windows application).
- Installer is usually an EXE/MSI; installation may require administrative privileges (UAC) for system-wide install.
- Compatibility: use the Report Builder version appropriate for, or newer than, your SSRS server version (recommended to use the latest compatible build for your SQL Server/SSRS).

**Official download sources**
- Download directly from the Report Server web portal: visit `http://<report-server>/reports` (or your portal URL) and click the "Report Builder" link — the server typically provides a suitable installer.
- Download from Microsoft Docs / Download Center:
    - Docs: https://learn.microsoft.com/sql/reporting-services/report-builder
    - Manual download: search the Microsoft Download Center for the correct "Report Builder" package if you need to download it manually.

**How to install (summary)**
1. Install from the Report Server web portal
   - Open a browser to the portal: `http://<report-server>/reports`.
   - In the portal (often in the top-right), choose "Report Builder" or "Download Report Builder". The browser will either download the installer or launch it.
   - Run the downloaded file, accept UAC if prompted, and follow the wizard to complete installation.

2. Install manually from a downloaded file (MSI/EXE)
   - Run the downloaded `ReportBuilder.exe` or `ReportBuilder.msi`.
   - Choose Install (if shown) and wait for the installer to finish.

**Post-install checks**
- Open Report Builder (Start Menu → Report Builder).
- Go to `File` → `Help` → `About Report Builder` to check the version.
- Create a quick report: `File` → `New` → `Blank Report`.
    - Add a Data Source: `Data` → `Add Data Source` → set `Type = Microsoft SQL Server` and use an example connection string:

```
Data Source=your_server_name;Initial Catalog=your_database;Integrated Security=True;
```

    - Create a DataSet: `Add Dataset` → paste sample SQL:

```
SELECT TOP 10 * FROM dbo.YourTable
```

    - Drag and drop a table/matrix onto the canvas to verify data.

**Compatibility notes and recommendations**
- Using the latest Report Builder is often backwards compatible with older SSRS servers, but it's best to use a version compatible with your server (for example, SSRS 2019 → use the Report Builder version for SQL Server v16 when available).
- If your organization allows it, recommend users install Report Builder locally for quick editing; however, deployment should be performed by someone with publish permissions on the Report Server.

**Common issues & how to fix them**
- Browser won't download Report Builder from the portal:
    - Verify the portal URL is correct and that the SSRS service is running.
    - Some browsers block .exe downloads — try a different browser or download and run the installer manually.
- Unable to connect to the database when creating a Data Source:
    - Check the connection string, server name, and credentials (Integrated Security vs SQL Authentication).
    - Verify firewall settings (default SQL port 1433) and that the account has database access.
- "Report Builder" link not showing in the portal:
    - The download feature may be disabled on the server or the portal not configured to expose the link. Check SSRS configuration or contact the server admin.
- Installer errors (permissions): run the installer as administrator (Right-click → Run as administrator).

**Suggestions for additional content (needs screenshots / specific examples)**
- Add screenshots: where to click on the portal to download, installer wizard screens, and the `About` dialog to show the version.
- Include example connection strings for SQL Authentication vs Integrated Security.
- Add a checklist of permissions needed to publish to the server (publish permission, target folder, SSRS role assignments).

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
