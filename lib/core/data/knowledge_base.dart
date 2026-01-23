class KnowledgeBase {
  static const List<Map<String, dynamic>> designRules = [
    {
      "id": "R001",
      "category": "Typography",
      "rule": "Header-Body Contrast",
      "description":
          "Headers should be at least 2x the weight of body text for clear hierarchy.",
      "citation": "Material Design 3 Guidelines"
    },
    {
      "id": "R002",
      "category": "Color",
      "rule": "60-30-10 Rule",
      "description": "60% primary neutral, 30% secondary, 10% accent color.",
      "citation": "Color Theory 101"
    },
    {
      "id": "R003",
      "category": "Layout",
      "rule": "Whitespace Breathing Room",
      "description":
          "Elements should have padding equal to at least 50% of their font size.",
      "citation": "Refactoring UI"
    },
  ];

  static const List<Map<String, dynamic>> goldenExamples = [
    {
      "id": "EX001",
      "type": "Listing",
      "title": "Modern Loft in Downtown",
      "score": 98,
      "tags": ["High Contrast", "Great Lighting", "Clear Facade"]
    },
    {
      "id": "EX002",
      "type": "Listing",
      "title": "Cozy Cottage",
      "score": 95,
      "tags": ["Warm Tones", "Inviting Angles"]
    },
  ];
}
