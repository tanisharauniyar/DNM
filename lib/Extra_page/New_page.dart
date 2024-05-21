import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPage extends ConsumerStatefulWidget {
  const NewPage({super.key});

  @override
  ConsumerState<NewPage> createState() => _UpdateVisitViewState();
}

class _UpdateVisitViewState extends ConsumerState<NewPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}