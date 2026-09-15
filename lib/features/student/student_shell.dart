import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/cubit/auth_cubit.dart';

class StudentShell extends StatelessWidget {
  const StudentShell({super.key});

  @override
  Widget build(BuildContext context) {
    final profile =
        context.select((AuthCubit c) => c.state.profile);

    return Scaffold(
      appBar: AppBar(
        title: Text('Student - ${profile?.name ?? ''}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => context.read<AuthCubit>().signOut(),
          ),
        ],
      ),
      body: const Center(
        child: Text('Student dashboard — coming soon.'),
      ),
    );
  }
}
