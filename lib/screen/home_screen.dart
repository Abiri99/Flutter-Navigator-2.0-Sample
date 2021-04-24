import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_bloc.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_event.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_state.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final List<Todo> todos;
  final Function(int todoId) onTodoItemTap;
  final Function(int todoId) onTodoItemUpdateButtonTap;
  final Function() onFabPressed;

  HomeScreen({
    @required this.todos,
    @required this.onTodoItemTap,
    @required this.onTodoItemUpdateButtonTap,
    @required this.onFabPressed,
  })  : assert(todos != null),
        assert(onFabPressed != null),
        assert(onTodoItemTap != null),
        assert(onTodoItemUpdateButtonTap != null);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;

  void _dispatchInitialEvents() {
    _bloc.add(HomeTodosFetched());
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _dispatchInitialEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos',
            style: GoogleFonts.fredokaOne().copyWith(
              color: Colors.black,
            )),
        backgroundColor: Color(0xffe0e0e0),
        centerTitle: true,
        elevation: 1.0,
        shadowColor: Colors.black26,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: widget.onFabPressed,
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.todos.status == Status.Completed) {
            return ListView.builder(
              itemCount: state.todos.data.length,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var item = state.todos.data.elementAt(state.todos.data.length - 1 - index);
                return GestureDetector(
                  onTap: () {
                    print('item id: ${item.title}');
                    widget.onTodoItemTap(item.id);
                  },
                  child: Container(
                    height: 68,
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
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black12,
                          offset: Offset(0, 0),
                        ),
                      ],
                      // borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                item.description,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {
                            widget.onTodoItemUpdateButtonTap(item.id);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state.todos.status == Status.Loading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            );
          } else if (state.todos.status == Status.Empty) {
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
