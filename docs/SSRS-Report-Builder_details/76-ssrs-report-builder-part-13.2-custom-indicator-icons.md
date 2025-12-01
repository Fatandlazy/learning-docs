# SSRS Report Builder Part 13.2 - Custom Indicator Icons

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>

[Watch on YouTube](https://youtu.be/vWzaFekQKmM)

This note explains how to use custom indicator icons in SSRS Report Builder — replacing the built-in icon set with your own images, recommended formats and sizes, and mapping values to icons.

When to use custom icons
- Use custom icons to match corporate branding, provide clearer meaning than the built-in shapes, or present localized artwork.

Supported approaches
- **Built-in indicator with custom icons:** you can replace the built-in indicator images with external images by choosing the indicator's **State** properties and selecting an external image for each state.
- **Image placeholder driven by expression:** alternatively use a regular `Image` report item and set its `Source` to `External` or `Embedded` and choose the `Value` expression to pick an image path or embedded resource.

Recommended image formats and sizes
- Use PNG for transparency support. JPEG is OK but has no transparency.
- Keep icons small (typically 16×16, 20×20 or 24×24) so they align well in tables and matrices. Use 32×32 only where space allows.
- For retina/high-dpi displays you may include higher-resolution images and scale down in the report, but test viewers (Report Manager, web portal) to confirm rendering.

Steps: replace an indicator's icon images
1. Add an Indicator to your report (Insert → Indicator) or select an existing Indicator.
2. In the Indicator Properties, set the **Value** expression that drives the indicator's state.
3. Click **Edit Indicator** (or open the States editor). For each state, choose **Image** and then pick either an `Embedded` image you added to the report or set `External` and provide a URL/path.
4. If using External images, ensure the report server has access to the image path (HTTP URL or file share configured for the server).

Example expression to choose an external image path (used with an `Image` item):

```vb
=Switch(
	Fields!Status.Value = "Good", "http://cdn.example.com/icons/green-check.png",
	Fields!Status.Value = "Warning", "http://cdn.example.com/icons/yellow-exclamation.png",
	Fields!Status.Value = "Bad", "http://cdn.example.com/icons/red-cross.png",
	True, "http://cdn.example.com/icons/grey-question.png"
)
```

Embedding images
- To embed images in the report file, add them under Report → Embedded Images and reference them by name in the indicator state or image `Value` expression: `="/ReportFolder/ImageName.png"` is not needed for Embedded — choose the Embedded source and select the image.

Security and deployment notes
- External images referenced by URL must be accessible by the report server (and sometimes by the client's viewer). Use HTTPS where possible.
- If images are stored on a UNC share, ensure the report server service account has read access or use a web-hosted CDN.

Accessibility
- Provide tooltip text for images (Right-click → Image properties → General → ToolTip) and consider adding an adjacent text label for screen readers.

Testing
- Test in Preview and on the report server — rendering may differ between the designer and the deployed server.

<a href="../SSRS Report Builder.md" style="color:#FFA239">Back to playlist</a>
