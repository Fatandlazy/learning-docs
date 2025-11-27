# SSRS Report Builder Part 8.3 — Placeholders

Back to playlist

Placeholders are objects inside a textbox that allow mixed static text, field values, expressions, and formatting within the same textbox.

Creating and using placeholders
- Insert a textbox, right-click and choose `Create Placeholder` or edit an existing textbox and add placeholders from the `Placeholder Properties` dialog.
- A placeholder supports an expression (for example `=Fields!FirstName.Value`) and formatting (font, color, number/date format).

Examples
- Combine static and dynamic text:
  - Textbox value (single placeholder): `="Customer: " & Fields!CustomerName.Value`
  - Using multiple placeholders inside the same textbox lets you apply different styles to each part.

Formatting within placeholders
- Each placeholder can have its own `Font`, `Color`, and `Format` settings. Use this to emphasize a field (bold name) while keeping the label plain.

Expressions in placeholders
- Placeholders evaluate VB expressions. Example with conditional formatting inside text:
  `=IIF(Fields!IsActive.Value, "Active", "Inactive")`

Placeholders vs separate textboxes
- Use placeholders when you want mixed styling/content inside one line or paragraph. Use separate textboxes when content should be laid out independently or needs separate alignment.

Performance and accessibility
- Placeholders are lightweight; however avoid heavy computations inside many placeholders per row. For accessibility, set `Alt Text` on the parent textbox for screen readers.

Troubleshooting
- Formatting not applied: check the selected placeholder in the `Placeholder Properties` dialog — formatting is applied per placeholder.
- Expression errors: test expressions in a single placeholder before combining multiple placeholders in one textbox.

# SSRS Report Builder Part 8.3 - Placeholders

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>