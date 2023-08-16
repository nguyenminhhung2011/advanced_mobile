import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/local/preferences.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

class PassCodeScreen extends StatefulWidget {
  final String? routes;
  const PassCodeScreen({super.key, this.routes});

  @override
  State<PassCodeScreen> createState() => _PassCodeScreenState();
}

class _PassCodeScreenState extends State<PassCodeScreen> {
  // style
  final List<String> input = Constant.boardNumber;
  final List<String> _passCodeConfirm = List<String>.empty(growable: true);
  Color get _backgroundColor => Theme.of(context).scaffoldBackgroundColor;
  Color get _primaryColor => Theme.of(context).primaryColor;
  bool _isWrong = false;
  String? _passCode;

  void _onTapButton(int index) {
    if (_isWrong) {
      setState(() {
        _isWrong = false;
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
    if (_passCodeConfirm.length >= 4) {
      return;
    }
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
    if (_passCode?.isNotEmpty ?? false) {
      if (result == _passCode) {
        if (widget.routes?.isNotEmpty ?? false) {
          context.openListPageWithRoute(widget.routes!);
        } else {
          context.popArgs(result);
        }
      } else {
        setState(() {
          _isWrong = true;
        });
      }
    } else {
      context.popArgs(result);
    }
  }

  @override
  void initState() {
    _passCode = CommonAppSettingPref.getPassCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: context.heightDevice * 0.2),
          Text(
            S.of(context).enterCode,
            textAlign: TextAlign.center,
            style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return _buildActiveBox(index < _passCodeConfirm.length);
              })),
          if (_isWrong) ...[
            const SizedBox(height: 10),
            Text(
              S.of(context).errorCode,
              style: context.titleMedium
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.red),
            ),
          ],
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
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.3),
            blurRadius: 5.0,
          )
        ],
      ),
      child: Center(
        child: Text(
          s,
          style: color != null
              ? context.titleMedium
                  .copyWith(color: color, fontWeight: FontWeight.w700)
              : context.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
        ),
      ),
    );
  }

  Container _buildActiveBox(bool isActive) {
    final dotColor = _isWrong
        ? Colors.red
        : isActive
            ? _primaryColor
            : Colors.transparent;
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dotColor,
        border: Border.all(color: _isWrong ? Colors.red : _primaryColor),
      ),
    );
  }
}
