# SSRS Report Builder Part 12.4 - Drill Through Reports using Maps

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/OrCsunn-05E)

This note describes how to configure drill-through actions on Map layers and spatial elements in SSRS Report Builder. Map drill-throughs are useful for exploring details about a geographic feature (for example, clicking a state to open a report filtered to that state).

Where to attach actions
- Actions can be attached to map polygon layers, point layers, or even map markers representing your spatial features.

Steps
1. Ensure your map dataset includes a unique identifier field for each shape/feature (for example `StateID`) and any display labels.
2. In the Map layer properties (right-click the layer or polygon), choose **Symbology** or the Layer's **Action** settings depending on your Report Builder version.
3. Set the action type to **Go to report** and choose the target report.
4. Map parameters: set `StateID = =Fields!StateID.Value` or map by `StateName` as required by the target report.

Examples
- Click a state polygon to open `StateDetails` where `StateID` is passed to show demographic and order data for the chosen state.

UI and interaction tips
- Provide a tooltip for the map layer showing the feature name (for example `=Fields!StateName.Value`) so users know what they are clicking.
- Consider zooming or focusing the target report to the specific geometry; pass lat/long or bounding box parameters if the target report supports map centering.

Performance and data
- Map layers can be heavy; simplify geometry if possible (reduce polygon vertex count) or use spatial indexes on the source to speed map queries.

Troubleshooting
- Click does nothing: verify the Action is set on the correct layer or polygon and the dataset field used for parameter mapping is available in the layer's dataset.
- Incorrect feature: ensure your layer's join field correctly matches the dataset field used for the action mapping.

Preview and test drill-throughs in both Report Builder preview and the deployed environment; rendering differences can affect clickable areas.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
