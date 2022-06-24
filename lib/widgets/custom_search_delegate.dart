import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoknot/bloc/notes/notes_bloc.dart';
import 'package:zoknot/models/note_model.dart';
import 'package:zoknot/widgets/widgets.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      scaffoldBackgroundColor: Theme.of(context).colorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
          
    );
  }

  @override
  String? get searchFieldLabel {
    return "Recherchez titre, mot...";
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        child: SvgPicture.asset(
          "assets/icons/x-circle.svg",
          height: 20,
          width: 20,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return TextButton(
      onPressed: () {
        close(context, null);
      },
      child: SvgPicture.asset(
        "assets/icons/arrow-left.svg",
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        'Aucune note trouvée',
        style: Theme.of(context).textTheme.headline6!,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<NoteModel> notes =
        (BlocProvider.of<NotesBloc>(context).state as NotesLoaded).notes;
    List<NoteModel> searchResult = notes.where((searchResult) {
      final inTitleSearchResult = searchResult.noteTitle.toLowerCase();
      final inBodySearchResult = searchResult.noteBody.toLowerCase();
      final input = query.toLowerCase();
      return inTitleSearchResult.contains(input) ||
          inBodySearchResult.contains(input);
    }).toList();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SearchSuggestionGrid(
        isGrid: true,
        notes: searchResult,
      ),
    );
  }
}
