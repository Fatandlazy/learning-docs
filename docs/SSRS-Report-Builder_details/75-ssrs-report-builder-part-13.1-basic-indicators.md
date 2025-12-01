# SSRS Report Builder Part 13.1 - Basic Indicators

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/7To9RZaSg9o)

This guide introduces basic Indicators in SSRS Report Builder: visual symbols that communicate status by mapping numeric or categorical values to states (icons or shapes).

What is an Indicator?
- An Indicator is a small visual (for example a traffic light, arrow, or gauge-like icon) that represents a state. Indicators are useful in tables, matrices, or dashboards to show performance at-a-glance.

Creating an Indicator
1. Insert → **Indicator** and choose a style (shapes, symbols, or data bars if available).
2. Set the **Value** expression that determines the indicator state (for example `=Fields!Sales.Value / Fields!Target.Value`).
3. Edit the states (Indicator Properties → States) and define ranges or expressions that map a numeric value to a state index.

Defining states and thresholds
- Indicators use integer state indexes (0,1,2...) — define the thresholds in the States editor. For example:
	- State 2 (Green): value >= 1.0
	- State 1 (Amber): 0.9 <= value < 1.0
	- State 0 (Red): value < 0.9

Example expression for a performance indicator (state calculated inline):

```vb
=IIF(Fields!Target.Value = 0, 0, 
	IIF(Fields!Sales.Value / Fields!Target.Value >= 1, 2, 
		IIF(Fields!Sales.Value / Fields!Target.Value >= 0.9, 1, 0)
	)
)
```

Using images or custom icons
- Indicators can use built-in shapes or custom images (see Part 13.2 for custom icon techniques). Use embedded or external images for consistent branding.

Sizing and placement
- Keep indicators small (16–20 px) and align them within cells. If you need text and an indicator, place them side-by-side with minimal padding.

Accessibility
- Add ToolTip text describing the state (for example `="Performance: " & FormatPercent(Fields!Sales.Value / Fields!Target.Value, 1)`). Provide a textual alternative nearby for screen readers if necessary.

Performance tips
- If the indicator value requires heavy computation, pre-calculate it in the dataset or in SQL to reduce report rendering cost.

Preview with realistic data to ensure thresholds map as expected and visuals are legible in all output formats (HTML, PDF, Excel).

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
