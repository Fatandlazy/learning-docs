# SSRS Report Builder Part 10.7 — Parameter UI, Layout and Visibility

Back to playlist

Well-designed parameter UI improves usability. This page covers arranging parameters, group labels, tooltips, and accessibility considerations.

1) Parameter panel layout
- Report Builder lays out parameters in the order they are defined. Use grouping and creation order to control layout.
- For many parameters, choose multi-column layout or compact labels to avoid excessive vertical space.

2) Labels, prompts and tooltips
- Use the `Prompt` property to provide a user-friendly label. Keep prompts short and descriptive.
- There is no built-in tooltip field for parameters — include helpful prompt text or create a `Label` control on the report body that explains complex parameters.

3) Visibility (Hidden vs Internal)
- Use `Hidden` for values that may be set by subscriptions or URL but should not be shown in the UI.
- Use `Internal` for parameters that should never be set from outside the report (useful for intermediate values).

4) Grouping related parameters
- To visually group, add a text box or rectangle in the report body near the report header that repeats for each page, showing active parameter selections.

5) Accessibility and keyboard use
- Ensure parameter prompts are clear for screen readers. Keep a logical tab order by creating parameters in a natural reading order.

6) Setting parameter defaults and prompts for ad-hoc users
- Provide sensible defaults so occasional users can run the report without making selections.
- Consider a `Quick Range` parameter (Today, Last 7 days, This Month) that maps to Start/End dates internally for common cases.

7) Hiding complexity behind simple choices
- Expose a single friendly parameter (e.g., `Region`) while driving multiple internal parameters via expressions or dataset defaults.

8) Troubleshooting
- Parameter order changed unexpectedly: open the parameter dialog and reorder or recreate parameters to ensure evaluation order.
- Users report slow parameter loading: check whether parameter datasets return large result sets — add filters or search functionality.

Back to playlist