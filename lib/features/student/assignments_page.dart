import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
	const AssignmentsPage({super.key});

	static const _incoming = <_Homework>[
		_Homework('Read John 1–3', 'New Testament Study', 'Due tomorrow', Icons.menu_book_rounded, false),
		_Homework('Memorize Psalm 23:1', 'Bible Memorization', 'Due in 4 days', Icons.auto_stories_rounded, false),
	];

	static const _done = <_Homework>[
		_Homework('Parables of Jesus', 'Gospel Studies', 'Submitted May 18', Icons.check_circle_rounded, true),
		_Homework('Faith and works reflection', 'Christian Living', 'Submitted May 12', Icons.check_circle_rounded, true),
	];

	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 2,
			child: Scaffold(
				backgroundColor: const Color(0xFFF7F8FC),
				appBar: AppBar(
					title: const Text('Assignments'),
					centerTitle: true,
					elevation: 0,
					backgroundColor: const  Color.fromARGB(255, 22, 192, 98).withOpacity( 0.4),
					bottom: const TabBar(
						labelColor: Color.fromARGB(255, 1, 44, 34),
						unselectedLabelColor: Colors.grey,
						indicatorColor: Color.fromARGB(255, 1, 44, 34),
						tabs: [Tab(text: 'Incoming'), Tab(text: 'Done')],
					),
				),
				body: const TabBarView(
					children: [
						_HomeworkList(items: _incoming, emptyText: 'No incoming homework'),
						_HomeworkList(items: _done, emptyText: 'No completed homework'),
					],
				),
			),
		);
	}
}

class _HomeworkList extends StatelessWidget {
	const _HomeworkList({required this.items, required this.emptyText});

	final List<_Homework> items;
	final String emptyText;

	@override
	Widget build(BuildContext context) {
		if (items.isEmpty) return Center(child: Text(emptyText));
		return ListView.separated(
			padding: const EdgeInsets.all(20),
			itemCount: items.length,
			separatorBuilder: (_, __) => const SizedBox(height: 12),
			itemBuilder: (_, index) => _HomeworkTile(homework: items[index]),
		);
	}
}

class _HomeworkTile extends StatelessWidget {
	const _HomeworkTile({required this.homework});

	final _Homework homework;

	@override
	Widget build(BuildContext context) {
		final color = homework.done ? const Color(0xFF16A34A) : Color.fromARGB(255, 1, 44, 34);
		return Card(
			elevation: 0,
			margin: EdgeInsets.zero,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
			child: ListTile(
				contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
				leading: CircleAvatar(
					backgroundColor: color.withAlpha(24),
					child: Icon(homework.icon, color: color),
				),
				title: Text(homework.title, style: const TextStyle(fontWeight: FontWeight.w700)),
				subtitle: Padding(
					padding: const EdgeInsets.only(top: 6),
					child: Text('${homework.subject}\n${homework.status}', style: TextStyle(color: color, height: 1.5)),
				),
				trailing: Icon(
          homework.done ? Icons.done :
           Icons.chevron_right, color: color
          
           ),
			),
		);
	}
}

class _Homework {
	const _Homework(this.title, this.subject, this.status, this.icon, this.done);

	final String title;
	final String subject;
	final String status;
	final IconData icon;
	final bool done;
}
