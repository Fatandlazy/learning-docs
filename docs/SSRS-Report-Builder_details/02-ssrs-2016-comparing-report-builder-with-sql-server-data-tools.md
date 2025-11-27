# SSRS 2016 - Comparing Report Builder and SQL Server Data Tools (SSDT)

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: Explain the differences between the two report design tools — who should use each tool, pros/cons, and considerations when choosing a tool for developing or maintaining SSRS reports.

**Quick overview**
- Report Builder: a lightweight tool aimed at business users and report authors who want to create or edit reports quickly without Visual Studio. Good for ad-hoc tasks and making edits on a production server (if permission is granted).
- SQL Server Data Tools (SSDT) / Report Designer in Visual Studio: a full development environment for developers and teams; supports project-level organization, source control, managing multiple reports and related files (shared data sources, shared datasets, custom code/assemblies).

**Comparison by criteria**
- Interface & experience
    - Report Builder: simple, intuitive drag-and-drop interface for non-developers. Includes templates and Report Parts for reuse.
    - SSDT: more complex but powerful — integrated into Visual Studio, allows debugging, solution/project management, and source-control integration.

- Project management & source control
    - Report Builder: no project concept; users work directly on RDL files or publish to the server. Versioning is harder without an additional process.
    - SSDT: supports projects (RDLs within a solution), easy integration with Git/TFS, and convenient for CI/CD and code review workflows.

- Complex development & reuse
    - Report Builder: suitable for single, quick reports. Limited when you need complex logic, custom assemblies, or many interrelated reports.
    - SSDT: better for complex reports, using custom code, referencing assemblies, and multi-developer scenarios.

- Deployment & operations
    - Report Builder: suitable for making quick edits directly on the Report Server (if permitted), fast but risky without change management.
    - SSDT: supports building artifacts and controlled deployment (for example, deploying via scripts or from CI pipelines).

- Debugging & development capabilities
    - Report Builder: fewer debugging options — mainly design-time preview and manual testing.
    - SSDT: supports debugging expressions and dataset queries in the development environment, and is easier to test when combined with source control.

**When to choose Report Builder**
- Business users who need to create or edit reports quickly.
- Small edits directly on the Report Server (e.g., updating titles, filters, default parameters).
- When you want to provide templates or Report Parts for non-technical users.

**When to choose SSDT / Visual Studio**
- Projects with many reports that need team-based management.
- When integration with source control, code review, and CI/CD is required.
- Reports that include complex logic, custom assemblies, or shared components across reports.

**Version/compatibility notes**
- Use a Report Builder version that is appropriate for or newer than the SSRS server; some newer features may only be available in updated Report Builder releases.
- SSDT/Report Designer: use a Visual Studio version that is compatible with the reporting extensions. Check Microsoft's documentation for the matching versions.

**Practical tips**
- Good process: develop primarily in SSDT with source control, then publish to Test/Prod servers; allow users to use Report Builder for small edits when needed (with an approval process).
- Create and distribute Report Parts or templates to Report Builder users to maintain consistency.
- If you need an audit trail of changes, avoid letting everyone edit production directly; prefer a controlled change process (SSDT + source control).

**Short conclusion**
- Report Builder: fast, simple, and powerful for business users.
- SSDT: the professional tool for development, control, and maintenance of larger reporting solutions.

Back to playlist

Would you like me to standardize the style (Vietnamese translation, screenshots, practical examples) for the remaining pages? I can continue in groups (Data Sources, Tables, Parameters) if you agree.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
