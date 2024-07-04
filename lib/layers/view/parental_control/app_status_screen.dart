import 'package:careflix_parental_control/layers/view/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../../core/app/state/app_state.dart';
import '../../../core/services/assets_loader.dart';
import '../../../injection_container.dart';
import '../../bloc/rule/rule_cubit.dart';
import '../../data/model/rule.dart';

class AppStatusScreen extends StatefulWidget {
  const AppStatusScreen({super.key});

  @override
  State<AppStatusScreen> createState() => _AppStatusScreenState();
}

class _AppStatusScreenState extends State<AppStatusScreen> {
  late SMIInput<bool> _isPressed;
  Artboard? _bearArtboard;

  final _ruleCubit = sl<RuleCubit>();

  switchThemeMode() {
    _isPressed.change(!_isPressed.value);
    setState(() {});
    _ruleCubit.setRule(Provider.of<AppState>(context, listen: false)
        .rule!
        .copyWith(isOn: _isPressed.value));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<AppState>(context, listen: false);
    final Rule? rule = provider.rule;

    final file = RiveFile.import(AssetsLoader.onOffButton);
    final artboard = file.mainArtboard;
    var controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);
      _isPressed = controller.findInput('push')!;
    }
    _isPressed.change(rule != null ? rule.isOn ?? true : true);

    setState(() {
      _bearArtboard = artboard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0XFF313131),
      ),
      backgroundColor: Color(0XFF313131),
      body: _bearArtboard != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isPressed!.value ? "App is On!" : "App is Off!",
                  style: TextStyle(fontSize: 30),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => switchThemeMode(),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Rive(
                          artboard: _bearArtboard!,
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                ),
              ],
            )
          : SizedBox(),
    );
  }
}
