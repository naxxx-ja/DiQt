import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/models/sentence_source.dart';

class Sentence {
  Sentence({
    required this.id,
    required this.dictionaryId,
    this.sentenceSourceId,
    required this.original,
    required this.langNumberOfOriginal,
    required this.translation,
    required this.langNumberOfTranslation,
    this.explanation,
    required this.acceptedSentenceRequestsCount,
    required this.pendingSentenceRequestsCount,
    required this.sentenceRequestsCount,
    required this.createdAt,
    required this.updatedAt,
    this.quiz,
    this.speakingQuiz,
    this.sentenceSource,
    this.dictionary,
  });

  int id;
  int dictionaryId;
  int? sentenceSourceId;
  String original;
  int langNumberOfOriginal;
  String translation;
  int langNumberOfTranslation;
  String? explanation;
  int acceptedSentenceRequestsCount;
  int pendingSentenceRequestsCount;
  int sentenceRequestsCount;
  DateTime createdAt;
  DateTime updatedAt;
  Quiz? quiz;
  Quiz? speakingQuiz;
  SentenceSource? sentenceSource;
  Dictionary? dictionary;

  Sentence.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dictionaryId = json['dictionary_id'],
        sentenceSourceId = json['sentence_source_id'],
        original = json['original'],
        langNumberOfOriginal = json['lang_number_of_original'],
        translation = json['translation'] ?? '',
        langNumberOfTranslation = json['lang_number_of_translation'],
        explanation = json['explanation'],
        acceptedSentenceRequestsCount =
            json['accepted_sentence_requests_count'],
        pendingSentenceRequestsCount = json['pending_sentence_requests_count'],
        sentenceRequestsCount = json['sentence_requests_count'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        quiz = json['quiz'] == null ? null : Quiz.fromJson(json['quiz']),
        speakingQuiz = json['speaking_quiz'] == null
            ? null
            : Quiz.fromJson(json['speaking_quiz']),
        sentenceSource = json['sentence_source'] == null
            ? null
            : SentenceSource.fromJson(json['sentence_source']),
        dictionary = json['dictionary'] == null
            ? null
            : Dictionary.fromJson(json['dictionary']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dictionary_id': dictionaryId,
        'sentence_source_id': sentenceSourceId,
        'original': original,
        'lang_number_of_original': langNumberOfOriginal,
        'translation': translation,
        'lang_number_of_translation': langNumberOfTranslation,
        'accepted_sentence_requests_count': acceptedSentenceRequestsCount,
        'pending_sentence_requests_count': pendingSentenceRequestsCount,
        'sentence_requests_count': sentenceRequestsCount,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'quiz': quiz,
        'speaking_quiz': speakingQuiz,
        'sentence_source': sentenceSource,
        'dictionary': dictionary,
      };
}
