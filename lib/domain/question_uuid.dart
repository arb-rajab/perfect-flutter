final RegExp _uuidPattern = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
);

/// Whether [value] has the canonical 8-4-4-4-12 hexadecimal uuid format.
/// Checked before a `/q/<uuid>` share link value is used for anything.
bool isQuestionUuid(String value) => _uuidPattern.hasMatch(value);
