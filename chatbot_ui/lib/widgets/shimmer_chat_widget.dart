import 'package:chatbot_ui/models/chat_model.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/constants.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class ShimmerChatWidget extends StatelessWidget {
  const ShimmerChatWidget({super.key, required this.chatIndex});

  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: cardColor,
        highlightColor: Colors.grey.shade900,
        enabled: true,
        child: Column(
          children: [
            Material(
              color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Expanded(
                        child: TextWidget(
                      label: ChatModel.loadingMessage,
                      color: Colors.white,
                    )),
                    chatIndex == 0
                        ? const SizedBox.shrink()
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.thumb_down_alt_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
