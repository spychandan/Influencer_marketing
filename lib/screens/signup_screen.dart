import 'package:appcreasip/creasipmodel/presentation/loginPageViewModel.dart';
import 'package:appcreasip/util/consts/screen_routes.dart';
import 'package:appcreasip/widgets/appbar.dart';
import 'package:appcreasip/widgets/nextbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late LoginPageViewModel _loginPageViewModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;

  void initState() {
    super.initState();
    _phoneNumberController.text =
        ref.read(loginPageViewModelProvider).phoneNumber;
    _emailController.text = ref.read(loginPageViewModelProvider).applicantEmail;
    _nameController.text = ref.read(loginPageViewModelProvider).applicantName;
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a valid date of birth';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _loginPageViewModel = ref.watch(loginPageViewModelProvider.notifier);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              const Text(
                'Please Enter Your Details',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w200,
                  color: Color.fromARGB(255, 68, 68, 68),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8),
                height: 80,
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: '123 456 7890',
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500], // set the color here
                        ),
                      ),
                      onChanged: (value) =>
                          _loginPageViewModel.setPhoneNumber(value),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  onChanged: (value) => _loginPageViewModel.setName(value),
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: _validateName),
              SizedBox(height: 20.0),
              TextFormField(
                  onChanged: (value) =>
                      _loginPageViewModel.setEmailAddress(value),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: _validateEmail),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _dobController,
                onTap: () => _selectDate(context),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: _validateDOB,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NextButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
        // Perform signup or login logic
        // You can access form values using _phoneNumberController.text,
        // _nameController.text, _emailController.text, and _selectedDate
        // and perform the necessary operations here.
        // For simplicity, we'll just display a snackbar with the values.
        Navigator.of(context).pushNamed(bottomNavigationRoute);
          }
      }),
    );
  }
}
