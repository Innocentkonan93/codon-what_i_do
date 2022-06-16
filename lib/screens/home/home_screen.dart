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
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool isGrid = true;
  @override
  void initState() {
    BlocProvider.of<NotesBloc>(context).add(LoadNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState!.openDrawer();
          },
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          TextButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            child: SvgPicture.asset(
              "assets/icons/search.svg",
              color: Theme.of(context).colorScheme.onBackground,
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
                  'Mes notes',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isGrid = !isGrid;
                    });
                  },
                  child: Icon(
                    Icons.art_track_rounded,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                )
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
                    isGrid: isGrid,
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
