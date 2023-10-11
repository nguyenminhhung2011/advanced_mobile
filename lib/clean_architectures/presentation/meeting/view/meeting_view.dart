import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class MeetingView extends StatefulWidget {
  final String serverUrl;
  const MeetingView({super.key, required this.serverUrl});

  @override
  State<MeetingView> createState() => _MeetingViewState();
}

class _MeetingViewState extends State<MeetingView> {
  SettingBloc get _bloc => context.read<SettingBloc>();

  User? get _currentUser => _bloc.data.currentUser;

  bool isAudioMuted = true;
  bool isAudioOnly = false;
  bool isVideoMuted = true;

  Icon _renderIcon(int index) => Icon(
      switch (index) {
        0 => Icons.volume_mute_rounded,
        1 => Icons.audiotrack,
        _ => Icons.video_call_sharp
      },
      color: Colors.white);

  Color? _renderColor(index) =>
      switch (index) { 0 => isAudioMuted, 1 => isAudioOnly, _ => isVideoMuted }
          ? null
          : Colors.red;
  void _onAudioOnlyChanged() {
    setState(() {
      isAudioOnly = !isAudioOnly;
    });
  }

  void _onAudioMutedChanged() {
    setState(() {
      isAudioMuted = !isAudioMuted;
    });
  }

  void _onVideoMutedChanged() {
    setState(() {
      isVideoMuted = !isVideoMuted;
    });
  }

  void _onItemTap(int index) {
    if (index == 0) {
      _onAudioMutedChanged();
      return;
    }
    if (index == 1) {
      _onAudioOnlyChanged();
      return;
    }
    _onVideoMutedChanged();
  }

  void _joinMeeting() async {
    final meetingToken = widget.serverUrl.split('token=')[1];
    if (meetingToken.isNotEmpty) {
      Map<String, Object> featureFlags = {};
      // Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
      // final String room = jwtDecoded['room'];
      try {
        // if (Platform.isAndroid) {
        //   featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
        // } else if (Platform.isIOS) {
        //   featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
        // }

        var options = JitsiMeetingOptions(
          roomNameOrUrl: "learningRoom",
          serverUrl: "https://meet.lettutor.com",
          // subject: subjectText.text,
          token: meetingToken,
          isAudioMuted: isAudioMuted,
          isAudioOnly: isAudioOnly,
          isVideoMuted: isVideoMuted,
          userDisplayName: _currentUser?.name ?? '',
          userEmail: _currentUser?.email ?? '',
          userAvatarUrl: _currentUser?.avatar ?? ImageConst.baseImageView,
          featureFlags: featureFlags,
        );

        await JitsiMeetWrapper.joinMeeting(options: options);
      } catch (e) {
        log("🐛[Exception] ${e.toString()}");
        // print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const SizedBox();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).meetingSettings),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: buildMeetConfig(),
      ),
    );
  }

  Widget buildMeetConfig() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _renderProfilePreview(),
        const SizedBox(height: 16.0),
        _setUpField(),
        const Divider(height: 48.0, thickness: 2.0),
        ButtonCustom(
          height: 45.0,
          radius: 5.0,
          color: Theme.of(context).cardColor,
          borderColor: Theme.of(context).primaryColor,
          onPress: () => _joinMeeting(),
          child: Text(
            S.of(context).joinMeeting,
            style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: kToolbarHeight)
      ],
    );
  }

  Row _setUpField() {
    return Row(
      children: [
        ...[isAudioMuted, isAudioOnly, isVideoMuted]
            .mapIndexed((index, e) => Expanded(
                  child: ButtonCustom(
                    color: _renderColor(index),
                    height: 45.0,
                    radius: 5.0,
                    onPress: () => _onItemTap(index),
                    child: _renderIcon(index),
                  ),
                ))
            .expand((e) => [e, const SizedBox(width: 10.0)])
            .toList()
          ..removeLast(),
      ],
    );
  }

  Container _renderProfilePreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).primaryColor.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).profilePreview,
            style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: ImageCustom(
                  imageUrl: _currentUser?.avatar ?? ImageConst.baseImageView,
                  isNetworkImage: true,
                  height: 80.0,
                  width: 80.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...[_currentUser?.name, _currentUser?.email].mapIndexed(
                      (index, e) {
                        if (e == null) {
                          return const SizedBox();
                        }
                        return _richText(
                          header: switch (index) {
                            0 => S.of(context).name,
                            _ => S.of(context).email,
                          },
                          title: e,
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _richText({
    required String header,
    required String title,
    required BuildContext context,
  }) {
    return RichText(
        text: TextSpan(
      style: context.titleMedium,
      children: [
        TextSpan(
          text: header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: ': $title')
      ],
    ));
  }
}
