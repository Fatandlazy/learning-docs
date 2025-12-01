# SSRS Report Builder Part 11.6 - Cascading Parameters

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/mM9Ki4YSxBo)

This guide explains how to set up cascading parameters in SSRS Report Builder — parameters whose available values depend on earlier selections (for example: Country → State → City).

Why use cascading parameters?
- They improve usability by restricting choices to relevant values and can reduce dataset size for downstream queries.

Basic setup steps
1. Create the parent parameter and its dataset:
	- Create a dataset that returns the parent list (e.g., `dsCountries` returning `CountryID, CountryName`).
	- Create the parameter `CountryParam` and set Available Values to come from `dsCountries` (Value field = `CountryID`, Label field = `CountryName`).

2. Create the child parameter and its dataset:
	- Create a dataset `dsStates` that takes a parameter `@CountryID` and returns states for that country, e.g.:

```sql
SELECT StateID, StateName FROM States WHERE CountryID = @CountryID ORDER BY StateName
```

	- Create the parameter `StateParam`, set Available Values to come from `dsStates`, and ensure the dataset parameter `@CountryID` is mapped to `=Parameters!CountryParam.Value`.

3. Repeat for additional levels (City): make the city dataset take `@StateID` and map accordingly.

Important notes
- Dataset execution order: SSRS evaluates datasets that provide available values before rendering parameters. Ensure datasets are set up so parent parameters are available for child datasets.
- Default values: set sensible defaults for parent parameters to allow immediate population of the child lists.
- Performance: cascading parameters trigger extra queries; design parent lists to be compact and index filter columns to keep child dataset queries fast.
- Null handling: allow `NULL` for parent parameter if you want child dataset to return all values when parent is not selected; adjust child dataset SQL accordingly (`WHERE (@CountryID IS NULL OR CountryID = @CountryID)`).

Example end-to-end
- `dsCountries` (no inputs) → populates `CountryParam`.
- `dsStates(@CountryID)` → populates `StateParam` and maps `@CountryID` to `=Parameters!CountryParam.Value`.
- `dsCities(@StateID)` → populates `CityParam` and maps `@StateID` to `=Parameters!StateParam.Value`.

UI tips
- Order parameter prompts top-to-bottom in the Report Data pane or the parameter layout so users select parent first.
- If child lists can be large, consider adding a text search filter or turning child selection into a lookup dataset with type-ahead.

Troubleshooting
- Child list not populating: verify dataset parameter mapping and ensure parent parameter has a default or explicit selection.
- Slow loading: profile child dataset SQL and add appropriate indexes.

Preview the report and test selecting different parents to confirm child lists update and the final dataset is correctly filtered.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
