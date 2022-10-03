import 'package:booqs_mobile/data/provider/user.dart';
import 'package:booqs_mobile/models/user.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/for_normal.dart';
import 'package:booqs_mobile/widgets/bottom_navbar/for_school.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavbar extends ConsumerWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? _user = ref.watch(currentUserProvider);
    final bool school = _user?.school ?? false;
    if (school) {
      return const BottomNavbarForSchool();
    }
    return const BottomNavbarForNormal();
  }
}