import 'package:battle_app/controllers/comment_controller.dart';
import 'package:battle_app/services/shared_service.dart';
import 'package:battle_app/widgets/comment_item.dart';
import 'package:battle_app/widgets/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsSheet extends StatefulWidget {
  final String videoId;
  const CommentsSheet({super.key, required this.videoId});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController textController = TextEditingController();
  String? currentUserId;

  late final CommentController commentController;

  @override
  void initState() {
    super.initState();

    commentController =
        Get.find<CommentController>(tag: widget.videoId);

    _initUser();
  }

  Future<void> _initUser() async {
    final details = await SharedService.loginDetails();
    currentUserId = details?.id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: GradientContainer(
          child: Column(
            children: [
              _dragHandle(),

              /// COMMENTS LIST
              Expanded(
                child: Obx(() {
                  if (commentController.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (_, i) => CommentItem(
                      comment: commentController.comments[i],
                      videoId: widget.videoId,
                      currentUserId: currentUserId!,
                    ),
                  );
                }),
              ),

              /// INPUT
              _commentInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commentInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: textController,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 16),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Add a comment...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () async {
              if (textController.text.trim().isEmpty ||
                  currentUserId == null) return;

              await commentController.addComment(
                videoId: widget.videoId,
                userId: currentUserId!,
                content: textController.text,
              );

              textController.clear();
            },
          ),
        ],
      ),
    );
  }

  Widget _dragHandle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
