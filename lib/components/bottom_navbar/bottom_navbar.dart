import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/components/bottom_navbar/for_normal.dart';
import 'package:booqs_mobile/components/bottom_navbar/for_school.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbar extends ConsumerWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? user = ref.watch(currentUserProvider);
    final bool school = user?.school ?? false;
    if (school) {
      return const BottomNavbarForSchool();
    }
    return const BottomNavbarForNormal();
  }
}