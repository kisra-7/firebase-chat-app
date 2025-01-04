import 'package:flutter/material.dart';

class Usertile extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const Usertile({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.person,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(name)
          ],
        ),
      ),
    );
  }
}
