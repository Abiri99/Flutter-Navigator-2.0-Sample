import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_bloc.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_event.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_state.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUpdateTodoScreen extends StatefulWidget {
  final Todo todo;
  final Future Function(Todo todo) onAddTodoCallback;
  final Future Function(Todo todo) onUpdateTodoCallback;

  AddUpdateTodoScreen({
    this.todo,
    this.onAddTodoCallback,
    this.onUpdateTodoCallback,
  });

  @override
  _AddUpdateTodoScreenState createState() => _AddUpdateTodoScreenState();
}

class _AddUpdateTodoScreenState extends State<AddUpdateTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(-5, 0),
            ),
          ],
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${widget.todo != null ? 'Update' : 'Add'} Todo',
              style: GoogleFonts.fredokaOne().copyWith(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.black,
            // backgroundColor: Color(0xffe0e0e0),
            centerTitle: true,
            elevation: 2.0,
          ),
          body: BlocBuilder<AddUpdateTodoBloc, AddUpdateTodoState>(
            builder: (context, state) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffe0e0e0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        child: TextFormField(
                          enabled: !state.loading,
                          autofocus: true,
                          initialValue: widget.todo?.title ?? '',
                          onChanged: (value) {
                            BlocProvider.of<AddUpdateTodoBloc>(context)
                                .add(AddUpdateTodoTitleSet(title: value));
                          },
                          maxLines: 1,
                          minLines: 1,
                          cursorColor: Colors.black45,
                          decoration: InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffe0e0e0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        child: TextFormField(
                          enabled: !state.loading,
                          autofocus: true,
                          initialValue: widget.todo?.description ?? '',
                          onChanged: (value) {
                            BlocProvider.of<AddUpdateTodoBloc>(context).add(
                                AddUpdateTodoDescriptionSet(
                                    description: value));
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          minLines: 5,
                          cursorColor: Colors.black45,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 48.0,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0,),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: state.loading
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                )
                              : Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        onPressed: () {
                          if (state.loading) {
                            return;
                          }
                          if (widget.todo == null) {
                            BlocProvider.of<AddUpdateTodoBloc>(context).add(
                              AddUpdateTodoAddItemToDB(),
                            );
                          } else {
                            BlocProvider.of<AddUpdateTodoBloc>(context).add(
                                AddUpdateTodoUpdateDBItem(
                                    todoId: widget.todo.id));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
