import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoknot/screens/notes/add_note_screen.dart';

import '../../bloc/notes/notes_bloc.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    });
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(LoadNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: SvgPicture.asset(
              "assets/icons/search.svg",
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const AddNoteScreen();
              },
              fullscreenDialog: true,
            ),
          );
        },
        child: SvgPicture.asset(
          "assets/icons/edit-2.svg",
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Mes productions',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state is NotesLoaded) {
                  print(state.notes.length);
                  return NotesGrid(
                    isGrid: true,
                    notes: state.notes,
                  );
                }
                return const Center(
                  child: Text('Something went wring'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
