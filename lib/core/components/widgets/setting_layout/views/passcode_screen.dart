import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

class PassCodeScreen extends StatefulWidget {
  final String? routes;
  final String? passCode;
  const PassCodeScreen({super.key, this.routes, this.passCode});

  @override
  State<PassCodeScreen> createState() => _PassCodeScreenState();
}

class _PassCodeScreenState extends State<PassCodeScreen> {
  // style
  final List<String> input = Constant.boardNumber;

  final List<String> _passCodeConfirm = List<String>.empty();
  Color get _backgroundColor => Theme.of(context).scaffoldBackgroundColor;
  Color get _primaryColor => Theme.of(context).primaryColor;
  bool isWrong = false;

  void _onTapButton(int index) {
    if (isWrong) {
      setState(() {
        isWrong = false;
      });
    }
    if (index == 11) {
      return _removePassCode();
    }
    if (index == 9) {
      context.pop();
    }
  }

  void _addPassCode(String charCode) {
    setState(() {
      _passCodeConfirm.add(charCode);
    });
    if (_passCodeConfirm.length == 4) {
      _checkCode();
    }
  }

  void _removePassCode() {
    if (_passCodeConfirm.isNotEmpty) {
      setState(() {
        _passCodeConfirm.removeLast();
      });
    }
  }

  void _checkCode() {
    String result = _passCodeConfirm
        .fold('', (previousValue, element) => previousValue += element)
        .trim()
        .toLowerCase();
    if (widget.passCode?.isNotEmpty ?? false) {
      if (result == widget.passCode) {
        if (widget.routes?.isNotEmpty ?? false) {
          context.openListPageWithRoute(widget.routes!);
        }
      } else {
        setState(() {
          isWrong = true;
        });
      }
    } else {
      context.popArgs(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: context.heightDevice * 0.1),
          Text(
            'Enter Code',
            textAlign: TextAlign.center,
            style: context.titleMedium,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _passCodeConfirm.map((e) {
              if (e.isEmpty) {
                return _buildUnActiveBox();
              }
              return _buildActiveBox();
            }).toList(),
          ),
          if (isWrong) ...[
            const SizedBox(height: 10),
            Text(
              'AppLocalizations.of(context)!.zpinNotMatch',
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: _primaryColor,
              ),
            ),
          ],
          SizedBox(height: context.heightDevice * 0.1),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthDevice * 0.2,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  String s = input[index];
                  if (index == 9 || index == 11) {
                    return GestureDetector(
                      onTap: () => _onTapButton(index),
                      child: _buildInput(s, _primaryColor),
                    );
                  }
                  return GestureDetector(
                    onTap: () => _addPassCode(s),
                    child: _buildInput(s, null),
                  );
                },
                itemCount: input.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildInput(String s, Color? color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).cardColor,
      ),
      child: Center(
        child: Text(
          s,
          style: color != null
              ? context.titleMedium.copyWith(color: color)
              : context.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
        ),
      ),
    );
  }

  Container _buildActiveBox() {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _primaryColor,
      ),
    );
  }

  Container _buildUnActiveBox() {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _primaryColor,
        border: Border.all(color: context.titleLarge.color!),
      ),
    );
  }
}
