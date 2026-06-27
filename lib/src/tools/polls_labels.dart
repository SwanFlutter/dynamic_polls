/// A class that contains all the text labels used in the polls.
/// This allows for easy internationalization and customization of text.
class PollsLabels {
  /// The text displayed next to the vote count (e.g., "Votes")
  final String votesText;

  /// The error message when maximum options are exceeded
  final String maxOptionsError;

  /// The error message when maximum options must be greater than zero
  final String maxOptionsZeroError;

  const PollsLabels({
    this.votesText = 'Votes',
    this.maxOptionsError = 'Maximum options allowed',
    this.maxOptionsZeroError = 'maximumOptions must be greater than zero.',
  });

  /// Persian/Farsi labels
  static const PollsLabels persian = PollsLabels(
    votesText: 'آرا',
    maxOptionsError: 'حداکثر گزینه مجاز',
    maxOptionsZeroError: 'حداکثر گزینه‌ها باید بیشتر از صفر باشد.',
  );

  /// Arabic labels
  static const PollsLabels arabic = PollsLabels(
    votesText: 'أصوات',
    maxOptionsError: 'الحد الأقصى للخيارات المسموح بها',
    maxOptionsZeroError: 'يجب أن يكون الحد الأقصى للخيارات أكبر من صفر.',
  );

  /// Spanish labels
  static const PollsLabels spanish = PollsLabels(
    votesText: 'Votos',
    maxOptionsError: 'Máximo de opciones permitidas',
    maxOptionsZeroError: 'maximumOptions debe ser mayor que cero.',
  );

  /// French labels
  static const PollsLabels french = PollsLabels(
    votesText: 'Votes',
    maxOptionsError: 'Options maximales autorisées',
    maxOptionsZeroError: 'maximumOptions doit être supérieur à zéro.',
  );

  /// German labels
  static const PollsLabels german = PollsLabels(
    votesText: 'Stimmen',
    maxOptionsError: 'Maximal zulässige Optionen',
    maxOptionsZeroError: 'maximumOptions muss größer als null sein.',
  );

  /// Creates a copy of this PollsLabels with the given fields replaced with the new values.
  PollsLabels copyWith({
    String? votesText,
    String? maxOptionsError,
    String? maxOptionsZeroError,
  }) {
    return PollsLabels(
      votesText: votesText ?? this.votesText,
      maxOptionsError: maxOptionsError ?? this.maxOptionsError,
      maxOptionsZeroError: maxOptionsZeroError ?? this.maxOptionsZeroError,
    );
  }
}
