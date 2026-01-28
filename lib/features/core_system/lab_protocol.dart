// --- LAB PROTOCOL ENGINE (v13.0) ---
// Handles the 8-step slide logic and platform context data.

enum PlatformContext { creativeMarket, etsy }

class LabSlide {
  final String title;
  final String description;
  final Map<PlatformContext, String> requirements; // Dynamic text per platform

  const LabSlide({
    required this.title,
    required this.description,
    required this.requirements,
  });
}

class LabProtocol {
  // THE 8-STEP PROTOCOL (Reconstructed from Neural Pathway)
  static const List<LabSlide> slides = [
    LabSlide(
      title: "HERO COVER",
      description:
          "The primary visual anchor. Must capture attention in < 0.2s.",
      requirements: {
        PlatformContext.creativeMarket:
            "Rec: 1820 x 1214px (3:2). No text clutter.",
        PlatformContext.etsy:
            "Rec: 2700 x 2025px (4:3). Center focus for thumbnail crop.",
      },
    ),
    LabSlide(
      title: "FLAT PROOF",
      description: "Evidence of contents. The 'What's Inside' shot.",
      requirements: {
        PlatformContext.creativeMarket:
            "Show file formats (PSD, AI) and layer structure.",
        PlatformContext.etsy:
            "Show physical dimensions or digital file list clearly.",
      },
    ),
    LabSlide(
      title: "COLOR MATRIX",
      description: "Palette verification and aesthetic cohesion.",
      requirements: {
        PlatformContext.creativeMarket:
            "RGB for Digital. CMYK for Print templates.",
        PlatformContext.etsy: "Include color variations if applicable.",
      },
    ),
    LabSlide(
      title: "TYPOGRAPHY",
      description: "Font usage and hierarchy check.",
      requirements: {
        PlatformContext.creativeMarket:
            "List used fonts. Validate licensing rights.",
        PlatformContext.etsy: "Ensure readable overlay text (no tiny script).",
      },
    ),
    LabSlide(
      title: "SCALE CONTEXT",
      description: "Real-world application or relative size.",
      requirements: {
        PlatformContext.creativeMarket:
            "Mockup in situ (Laptop screen, Poster frame).",
        PlatformContext.etsy: "Hand-held or room context is mandatory.",
      },
    ),
    LabSlide(
      title: "DETAIL ZOOM",
      description: "Pixel-perfect quality inspection.",
      requirements: {
        PlatformContext.creativeMarket: "100% crop of texture/brush details.",
        PlatformContext.etsy: "Close-up of material texture or print quality.",
      },
    ),
    LabSlide(
      title: "USER GUIDE",
      description: "Instructional access and help assets.",
      requirements: {
        PlatformContext.creativeMarket: "PDF included? Video link active?",
        PlatformContext.etsy: "Download link instructions clear?",
      },
    ),
    LabSlide(
      title: "SOCIAL PROOF",
      description: "Testimonials or Cross-Sell grid.",
      requirements: {
        PlatformContext.creativeMarket: "Link to similar shop items.",
        PlatformContext.etsy: "Link to 5-star reviews or shop usage policy.",
      },
    ),
  ];
}
