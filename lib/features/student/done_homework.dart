import 'package:flutter/material.dart';

class DoneHomework extends StatelessWidget {
	const DoneHomework({super.key});

	static const homework = HomeworkResult(
		title: 'The Book of Genesis',
		subject: 'Bible Study',
		completedOn: '15 May 2024',
		questions: [
			HomeworkQuestion(
				question: 'Who created the heavens and the earth?',
				answer: 'God',
				correctAnswer: 'God',
				mark: 2,
				maxMark: 2,
			),
			HomeworkQuestion(
				question: 'How many days did God take to create the world?',
				answer: 'Six days',
				correctAnswer: 'Six days',
				mark: 2,
				maxMark: 2,
			),
			HomeworkQuestion(
				question: 'What was the name of the first man?',
				answer: 'Noah',
				correctAnswer: 'Adam',
				mark: 0,
				maxMark: 2,
			),
			HomeworkQuestion(
				question: 'What did God tell Noah to build?',
				answer: 'An ark',
				correctAnswer: 'An ark',
				mark: 2,
				maxMark: 2,
			),
		],
	);

	@override
	Widget build(BuildContext context) {
		final total = homework.questions.fold(0, (sum, item) => sum + item.mark);
		final maximum = homework.questions.fold(0, (sum, item) => sum + item.maxMark);
		return Scaffold(
			appBar: AppBar(title: const Text('Done Homework')),
			body: ListView(
				padding: const EdgeInsets.all(16),
				children: [
					Card(
						child: Padding(
							padding: const EdgeInsets.all(16),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(homework.title, style: Theme.of(context).textTheme.titleLarge),
									const SizedBox(height: 6),
									Text('${homework.subject} • Completed ${homework.completedOn}'),
									const SizedBox(height: 16),
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: [
											const Text('Final mark', style: TextStyle(fontWeight: FontWeight.bold)),
											Text('$total / $maximum', style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
										],
									),
								],
							),
						),
					),
					const SizedBox(height: 12),
					...homework.questions.asMap().entries.map(
						(entry) => _QuestionCard(number: entry.key + 1, question: entry.value),
					),
				],
			),
		);
	}
}

class _QuestionCard extends StatelessWidget {
	const _QuestionCard({required this.number, required this.question});

	final int number;
	final HomeworkQuestion question;

	@override
	Widget build(BuildContext context) {
		final correct = question.mark == question.maxMark;
		return Card(
			margin: const EdgeInsets.only(bottom: 12),
			child: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Row(
							children: [
								Expanded(child: Text('$number. ${question.question}', style: const TextStyle(fontWeight: FontWeight.bold))),
								Text('${question.mark}/${question.maxMark}', style: TextStyle(color: correct ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
							],
						),
						const SizedBox(height: 12),
						Text('Your answer: ${question.answer}'),
						if (!correct) ...[
							const SizedBox(height: 8),
							Text('Correct answer: ${question.correctAnswer}', style: const TextStyle(color: Colors.green)),
						],
					],
				),
			),
		);
	}
}

class HomeworkResult {
	const HomeworkResult({required this.title, required this.subject, required this.completedOn, required this.questions});
	final String title;
	final String subject;
	final String completedOn;
	final List<HomeworkQuestion> questions;
}

class HomeworkQuestion {
	const HomeworkQuestion({required this.question, required this.answer, required this.correctAnswer, required this.mark, required this.maxMark});
	final String question;
	final String answer;
	final String correctAnswer;
	final int mark;
	final int maxMark;
}
