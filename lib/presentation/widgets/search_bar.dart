import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelusas/presentation/providers/breeds_provider.dart';


class BreedSearchAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const BreedSearchAppBar({super.key});

  @override
  ConsumerState<BreedSearchAppBar> createState() => _BreedSearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BreedSearchAppBarState extends ConsumerState<BreedSearchAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _onSearchChanged(String value) {
    if (value.isEmpty) {
      ref.read(breedsProvider.notifier).fetchBreeds();
    } else {
      ref.read(breedsProvider.notifier).fetchBreedsBySearch(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching
          ? TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: _onSearchChanged,
        decoration: const InputDecoration(
          hintText: 'Buscar raza...',
          border: InputBorder.none,
        ),

      )
          : const Text('Razas de Gatos'),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              if (_isSearching) {
                _searchController.clear();
                _onSearchChanged('');
              }
              _isSearching = !_isSearching;
            });
          },
        ),
      ],
    );
  }
}
