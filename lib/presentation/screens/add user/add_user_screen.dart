import 'package:crudmvvm/cubit/user/user_cubit.dart';
import 'package:crudmvvm/models/user_model.dart';
import 'package:crudmvvm/presentation/common_widgets/custom_button.dart';
import 'package:crudmvvm/presentation/common_widgets/custom_loading_button.dart';
import 'package:crudmvvm/presentation/common_widgets/custom_text_field.dart';
import 'package:crudmvvm/presentation/common_widgets/refresh_data.dart';
import 'package:crudmvvm/presentation/screens/home/home_screen.dart';
import 'package:crudmvvm/presentation/screens/home/main_screen.dart';
import 'package:crudmvvm/theme_manager/space_manager.dart';
import 'package:crudmvvm/theme_manager/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add  User'),
      ),
      body: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                              if ((_formKey.currentState ?? FormState())
                                  .validate()) {
                                context.read<UserCubit>().startCreateUser(
                                    UserModel(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreen()));
                              }
                            },
                            title: "Create");
                      },
                    ),
                  ],
                ))),
      ),
    );
  }
}
