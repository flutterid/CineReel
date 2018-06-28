import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_movies/bloc/movie_bloc.dart';
import 'package:flutter_bloc_movies/bloc/movie_provider.dart';
import 'package:flutter_bloc_movies/common_widgets/CommonWidgets.dart';
import 'package:flutter_bloc_movies/models/Movie.dart';
import 'package:flutter_bloc_movies/ui/movie_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

// ignore: mixin_inherits_from_not_object
class _MyTabbedPageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Now Playing'),
    new Tab(text: 'RIGHT'),
  ];

  TabController _tabController;
  var _selectedTab;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      return;
    }
    _selectedTab = _tabController.index;
    print("Changed tab to: ${_selectedTab.toString()}");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieBloc = MovieProvider.of(context);

    return new Scaffold(
      appBar: buildAppBar(context, "flutter Bloc!", myTabs, _tabController),
      body: TabBarView(controller: _tabController, children: [
        Column(children: [Flexible(child: buildStreamList(movieBloc))]),
        Center(
            child: Container(
          color: Colors.green,
        ))
      ]),
    );
  }

  StreamBuilder<List<Movie>> buildStreamList(MovieBloc movieBloc) {
    return StreamBuilder(
      stream: movieBloc.movies,
      initialData: movieBloc.getNowPlayingList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        }
        if (!snapshot.hasData) {
          return buildLoadingWidget();
        }
        return buildListView(snapshot);
      },
    );
  }

  ListView buildListView(AsyncSnapshot<List<Movie>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          print(index);
          return MovieRow(snapshot.data[index]);
        });
  }
}
