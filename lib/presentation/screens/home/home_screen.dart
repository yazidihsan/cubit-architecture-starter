import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:crudmvvm/cubit/user/user_cubit.dart';
import 'package:crudmvvm/data/data_provider/user/user_data_provider.dart';
import 'package:crudmvvm/data/repository/user_repository.dart';
import 'package:crudmvvm/models/user_model.dart';
import 'package:crudmvvm/presentation/common_widgets/custom_button.dart';
import 'package:crudmvvm/presentation/common_widgets/custom_loading_button.dart';
import 'package:crudmvvm/presentation/common_widgets/custom_text_field.dart';
import 'package:crudmvvm/presentation/common_widgets/refresh_data.dart';
import 'package:crudmvvm/presentation/screens/add%20user/add_user_screen.dart';
import 'package:crudmvvm/presentation/screens/edit%20user/edit_user_screen.dart';
import 'package:crudmvvm/theme_manager/space_manager.dart';
import 'package:crudmvvm/theme_manager/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  late UserCubit _userCubit;

  bool isLoading = false;
  bool isUpdate = false;

  bool isAdd = false;

  int userId = 0;

  int item = 0;

  String? message;

  late String name;
  late String email;
  late String phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final httpClient = http.Client();
    _userCubit = UserCubit(UserRepository(UserDataProvider(httpClient)));
    _userCubit.getAllUser();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    deleteItem(item);
  }

  void deleteItem(int id) {
    context.read<UserCubit>().deleteUser(id);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  Widget _addForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.spaceY,
              const Text(
                "CRUD",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              48.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  title: "Username"),
              16.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  title: "Email Address"),
              16.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  title: "Phone Number"),
              38.0.spaceY,
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CustomLoadingButton());
                  }
                  if (state is UserFailed) {
                    final message = state.message;
                    if (message.isNotEmpty) {
                      ValueManager.customToast(message);
                    }
                  }

                  return CustomButton(
                      onPressed: () {
                        if ((_formKey.currentState ?? FormState()).validate()) {
                          _userCubit.startCreateUser(UserModel(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text));
                          Navigator.pop(context);
                          setState(() {
                            RefreshData(
                                onPressed: () async =>
                                    context.read<UserCubit>().getAllUser());
                          });
                        }
                      },
                      title: "Create");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _updateForm(int userIdx) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.spaceY,
              const Text(
                "CRUD",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              48.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  title: "Username"),
              16.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  title: "Email Address"),
              16.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  title: "Phone Number"),
              38.0.spaceY,
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CustomLoadingButton());
                  }
                  if (state is UserFailed) {
                    final message = state.message;
                    if (message.isNotEmpty) {
                      ValueManager.customToast(message);
                    }
                  }

                  return CustomButton(
                      onPressed: () {
                        if ((_formKey.currentState ?? FormState()).validate()) {
                          _userCubit.updateUser(
                            userIdx,
                            UserModel(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text),
                          );

                          RefreshData(
                            onPressed: () async =>
                                context.read<UserCubit>().getAllUser(),
                          );
                          Navigator.pop(context);
                        }
                      },
                      title: "Update");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BottomSheet content
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          maxChildSize: 1.0,
          minChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 1.0,
              child: isAdd == true ? _addForm() : _updateForm(userId),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo List'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddUserScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CustomLoadingButton());
            } else if (state is UserSuccess) {
              final data = state.users;

              return ListView.builder(
                key: ValueKey(userId),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final user = data[index];
                  item = user.id!;
                  userId = user.id!;
                  name = user.name;
                  email = user.email;
                  phone = user.phone;

                  return ListTile(
                    title: Text(name),
                    subtitle: Text('$email - $phone'),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteItem(userId);
                          // context.read<UserCubit>().deleteUser(user.id!);
                          context.read<UserCubit>().getAllUser();
                        }),
                    onTap: () {
                      // Example of marking a todo as completed
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserScreen(
                            userId: user.id!,
                            name: user.name,
                            email: user.email,
                            phone: user.phone,
                          ),
                        ),
                      );

                      // setState(() {
                      //   isAdd = false;
                      // });

                      // _showBottomSheet(context);
                    },
                  );
                },
              );
            } else if (state is UserFailed) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
