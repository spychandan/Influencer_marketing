import 'package:appcreasip/util/consts/screen_routes.dart';
import 'package:appcreasip/widgets/appbar.dart';
import 'package:appcreasip/widgets/nextbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:appcreasip/creasipmodel/presentation/switchSelectionViewModel.dart';
import '../util/consts/colors.dart';

class SwitchSelection extends ConsumerStatefulWidget {
  const SwitchSelection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SwitchSelectionState();
}

class _SwitchSelectionState extends ConsumerState<SwitchSelection> {
  late SwitchSelectionViewModel _switchSelectionViewModel;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    _switchSelectionViewModel =
        ref.watch(switchSelectionViewModelProvider.notifier);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          const Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          const Text(
            'Choose who you are',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = true;
                      _switchSelectionViewModel.setApplicantType('Influencer');
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                _switchSelectionViewModel.getApplicantType() ==
                                        'Influencer'
                                    ? kPrimaryColor
                                    : Colors.transparent,
                            width: 6,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/about/about_1.jpg'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Influencer'),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = true;
                      _switchSelectionViewModel.setApplicantType('Brand');
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _switchSelectionViewModel.getApplicantType() == 'Brand'
                                ? kPrimaryColor
                                : Colors.transparent,
                            width: 6,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/about/about_1.jpg'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Brand'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
          visible: _isVisible,
          child: NextButton(onPressed: () {
            Navigator.of(context).pushNamed(signUpScreenRoute);
          })),
    );
  }
}
