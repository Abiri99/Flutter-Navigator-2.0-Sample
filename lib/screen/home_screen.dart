import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_bloc.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_event.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  final List<Map<String, dynamic>> movies;
  final Function(String imdbID) onMovieItemTap;

  HomeScreen({@required this.movies, @required this.onMovieItemTap}) : assert(onMovieItemTap != null);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;

  void _dispatchInitialEvents() {
    _bloc.add(HomeMoviesFetched());
  }

  void _setSystemOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _dispatchInitialEvents();
    _setSystemOverlayStyle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.movies.status == Status.Completed) {
            return ListView.builder(
              itemCount: state.movies.data.length,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var item = state.movies.data.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    print('item id: ${item['imdbID']}');
                    widget.onMovieItemTap(item['imdbID']);
                  },
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black12,
                          offset: Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: CachedNetworkImage(
                            imageUrl: item['Poster'],
                            errorWidget: (_, __, ___) {
                              return Container(
                                child: Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.black45,
                                  ),
                                ),
                              );
                            },
                            fadeInDuration: Duration(milliseconds: 200),
                            fit: BoxFit.cover,
                            width: 80,
                            placeholder: (context, _) {
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['Title'],
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                item['Year'],
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state.movies.status == Status.Loading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            );
          } else if (state.movies.status == Status.Empty) {
            return Center(
              child: Text('Error!'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
