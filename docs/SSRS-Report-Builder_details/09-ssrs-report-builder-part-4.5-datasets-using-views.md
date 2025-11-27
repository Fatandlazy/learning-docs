# SSRS Report Builder — Part 4.5: Using Views as Datasets

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

Objective: When and why to use SQL Views as data sources for Datasets in SSRS/Report Builder. This covers pros and cons versus Stored Procedures and inline SELECTs, plus performance, parameterization, and maintenance notes.

1) Why use Views?
- Views encapsulate complex SELECT logic into a reusable database object.
- They keep reports simpler — a report can reference `SELECT * FROM dbo.vSalesSummary` instead of embedding a complex query.

2) Benefits
- Reuse: multiple reports can share the same view.
- Maintainability: change logic in one place (the view) and all reports that use it get updated.
- Security: grant SELECT permissions on the view without exposing underlying tables.

3) Limitations and performance considerations
- Views do not automatically optimize themselves; the optimizer still translates the view into queries against the underlying tables.
- A `SELECT *` on a complex view can be slow; consider an indexed view (if appropriate) or simplifying the view logic.
- Views that use scalar functions, correlated subqueries, or complex APPLYs can negatively impact performance.

4) Views vs Stored Procedures
- Views return a resultset usable in a Dataset but do not accept parameters (except where replaced with inline table-valued functions).
- Stored Procedures support parameters and arbitrary procedural logic; if you need parameterized behavior, prefer Stored Procedures or Table-Valued Functions (TVFs).

5) Using Views in Report Builder
- Create a Dataset with a simple query: `SELECT CustomerID, CompanyName, [Year], [Month], SalesTotal FROM dbo.vSalesSummary`.
- Alternatively create a Shared Dataset on the Report Server that selects from the view and reference that from multiple reports.

6) Parameterizing view logic
- Because views don’t accept parameters, options include:
  - Report-side filtering: fetch the full resultset from the view and apply report-level filters (inefficient for large resultsets).
  - Table-Valued Function (TVF): use an inline TVF to accept parameters while maintaining a table-like interface.
  - Stored Procedure: put parameterized logic into a Stored Procedure and call it from the Dataset.

7) Best practices
- If logic can be parameterized, use a TVF or Stored Procedure rather than relying on client-side filtering.
- Use a Shared Dataset based on a view when many reports need the same relatively static resultset.
- Avoid `SELECT *` unless you truly need every column; explicitly select required columns.

8) Example

View `vSalesSummary`:

```sql
CREATE VIEW dbo.vSalesSummary AS
SELECT s.CustomerID,
       c.CompanyName,
       YEAR(s.OrderDate) AS [Year],
       MONTH(s.OrderDate) AS [Month],
       SUM(s.Total) AS SalesTotal
FROM dbo.Orders s
JOIN dbo.Customers c ON s.CustomerID = c.CustomerID
GROUP BY s.CustomerID, c.CompanyName, YEAR(s.OrderDate), MONTH(s.OrderDate);
```

Dataset in Report Builder:

```sql
SELECT CustomerID, CompanyName, [Year], [Month], SalesTotal
FROM dbo.vSalesSummary
WHERE [Year] = @Year; -- use a report parameter @Year
```

Note: Because the view itself doesn’t accept parameters, the `WHERE` clause is applied at the Dataset level; with proper indexing on the underlying tables SQL Server can still produce an efficient plan.

9) Troubleshooting
- Slow data from a view: review execution plans, check indexes on underlying tables, and consider moving aggregation to an indexed view or pre-aggregated table.
- Underlying table changes: update the view and test reports that reference it to make sure column names/types remain compatible.

10) Conclusion
- Views are useful for packaging reusable SELECT logic and simplifying report code.
- For parameterized or complex scenarios, consider TVFs or Stored Procedures for better performance and scalability.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>