# Wise Owl Answers - How Do I Highlight the Parameter Search String in a Report Builder Table?

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/4X_DyRPXFaA)

This note explains how to highlight a search string entered as a report parameter inside a table in SSRS Report Builder. The technique uses an expression to wrap the matched substring with HTML markup and renders the textbox with HTML interpretation enabled.

When to use this
- Use highlighting when you want users to visually see where the search term occurs in returned text fields (for example: searching names, descriptions, or comments).

Steps (overview)
1. Create a text parameter (e.g. `SearchText`) in the **Report Data** → `Parameters` node.
2. In the Tablix cell where the field appears (for example `Fields!Description.Value`), replace the default placeholder with an expression that inserts HTML around the matching text.
3. Set the textbox placeholder's **Markup type** to **HTML - Interpret HTML tags as styles** so that the `<span>` styling is rendered.

Example expression (simple, case-sensitive):

```vb
=Replace(Fields!Description.Value, Parameters!SearchText.Value, "<span style='background-color:yellow'>" & Parameters!SearchText.Value & "</span>")
```

Notes on the simple approach:
- This uses the built-in `Replace` function, which performs a case-sensitive replacement.
- If `Parameters!SearchText.Value` is empty or nothing, the expression simply returns the original field value (you can wrap it in an IIF check to avoid inserting empty spans).

Case-insensitive and more robust approach (recommended):
SSRS allows calling .NET methods from expressions. Use `System.Text.RegularExpressions.Regex.Replace` to perform case-insensitive matching and to escape special regex characters in the search term.

```vb
=System.Text.RegularExpressions.Regex.Replace(
	Fields!Description.Value,
	System.Text.RegularExpressions.Regex.Escape(Parameters!SearchText.Value),
	"<span style='background-color:yellow'>$0</span>",
	System.Text.RegularExpressions.RegexOptions.IgnoreCase
)
```

Important: When using the Regex approach, handle empty/null parameter values to avoid runtime exceptions. Example guard expression:

```vb
=IIF(String.IsNullOrEmpty(Parameters!SearchText.Value), Fields!Description.Value, 
	System.Text.RegularExpressions.Regex.Replace(...)
)
```

After adding either expression to the textbox, configure the placeholder:
- Right-click the textbox → **Placeholder Properties** → **General** → **Markup type** → select **HTML - Interpret HTML tags as styles**.

Limitations & tips
- Be careful with HTML: SSRS supports a limited subset of HTML tags and inline styles; simple `<span style='background-color:...'>` works in most viewers, but complex HTML may not render.
- Escape user input for regex to avoid errors or unexpected patterns (use `Regex.Escape`).
- Very long text or extremely frequent replacements can affect rendering performance.
- If your field contains user-entered HTML, sanitise it first to avoid mixing markup.

Accessibility
- Ensure highlighted color provides sufficient contrast.

Example: full expression including guard (copy/paste-ready):

```vb
=IIF(String.IsNullOrEmpty(Parameters!SearchText.Value), Fields!Description.Value,
	System.Text.RegularExpressions.Regex.Replace(
		Fields!Description.Value,
		System.Text.RegularExpressions.Regex.Escape(Parameters!SearchText.Value),
		"<span style='background-color:yellow'>$0</span>",
		System.Text.RegularExpressions.RegexOptions.IgnoreCase
	)
)
```

Preview the report and test with different search strings (case variations, substrings, special characters) to confirm the highlight behavior.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
