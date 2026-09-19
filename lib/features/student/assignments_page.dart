import 'package:bible_study_app/core/widgets/app_text.dart' show AppText;
import 'package:bible_study_app/features/student/done_homework.dart' show DoneHomeworkPage, DoneHomework;
import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
	const AssignmentsPage({super.key});

	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 2,
			child: Scaffold(
				appBar: AppBar(
          centerTitle: true,
					title: const AppText(text:'Homework'),
					bottom: const TabBar(
						tabs: [
							Tab(text: 'الواجبات القادمة'),
							Tab(text: 'انتهت'),
						],
					),
				),
				body: const TabBarView(
					children: [
						_IncomingAssignmentsBuilder(),
						_DoneAssignmentsBuilder(),
					],
				),
			),
		);
	}
}

class _Assignment {
	const _Assignment({
		required this.title,
		required this.subject,
		required this.date,
		this.degree,
	});

	final String title;
	final String subject;
	final String date;
	final String? degree;
}

const _incomingAssignments = <_Assignment>[
	_Assignment(
		title: 'Read Psalm 23',
		subject: 'Bible Study',
		date: 'Due tomorrow',
	),
	_Assignment(
		title: 'Memory Verse',
		subject: 'Weekly Lesson',
		date: 'Due Friday',
	),
];

const _doneAssignments = <_Assignment>[
	_Assignment(
		title: 'The Ten Commandments',
		subject: 'Bible Study',
		date: 'Completed May 12',
		degree: '10/10',
	),
	_Assignment(
		title: 'Kindness Challenge',
		subject: 'Weekly Lesson',
		date: 'Completed May 8',
		degree: '9/10',
	),
];

class _IncomingAssignmentsBuilder extends StatelessWidget {
	const _IncomingAssignmentsBuilder();

	@override
	Widget build(BuildContext context) {
		if (_incomingAssignments.isEmpty) {
			return const Center(child: Text('No assignments here'));
		}

		return ListView.separated(
			padding: const EdgeInsets.all(16),
			itemCount: _incomingAssignments.length,
			separatorBuilder: (_, _) => const SizedBox(height: 12),
			itemBuilder: (context, index) {
				final assignment = _incomingAssignments[index];
				return Card(
					child: ListTile(
						contentPadding: const EdgeInsets.all(16),
						leading: const CircleAvatar(
							child: Icon(Icons.menu_book_outlined),
						),
						title: Text(assignment.title),
						subtitle: Padding(
							padding: const EdgeInsets.only(top: 6),
							child: Text('${assignment.subject}\n${assignment.date}'),
						),
					),
				);
			},
		);
	}
}

class _DoneAssignmentsBuilder extends StatelessWidget {
	const _DoneAssignmentsBuilder();

	@override
	Widget build(BuildContext context) {
		if (_doneAssignments.isEmpty) {
			return const Center(child: Text('No assignments here'));
		}

		return ListView.separated(
			padding: const EdgeInsets.all(16),
			itemCount: _doneAssignments.length,
			separatorBuilder: (_, _) => const SizedBox(height: 12),
			itemBuilder: (context, index) {
				final assignment = _doneAssignments[index];
				return Card(
					child: ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder:(context)=>const DoneHomework(),
                ));
            },
						contentPadding: const EdgeInsets.all(16),
						leading: const CircleAvatar(
							child: Icon(Icons.check),
						),
						title: Text(assignment.title),
						subtitle: Padding(
							padding: const EdgeInsets.only(top: 6),
							child: Text(
								'${assignment.subject}\n${assignment.date}\nDegree: ${assignment.degree}',
							),
						),
					),
				);
			},
		);
	}
}
