import 'package:battle_app/controllers/comment_controller.dart';
import 'package:battle_app/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final String videoId;
  final String currentUserId;

  const CommentItem({
    super.key,
    required this.comment,
    required this.videoId,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final CommentController commentController =
    Get.find<CommentController>(tag: videoId); // get controller for this video

    final isOwner = currentUserId == comment.authorId;
    final avatarUrl = comment.authorAvatar?.filePathUrl;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: avatarUrl != null
            ? NetworkImage('http://10.0.2.2:8080$avatarUrl')
            : const AssetImage("assets/images/output-onlinepngtools.png") as ImageProvider,
        child: comment.authorAvatar == null ? const Icon(Icons.person) : null,
      ),
      title: Text(comment.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(comment.content),
      trailing: isOwner
          ? PopupMenuButton<String>(
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'edit', child: Text('Edit')),
          PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
        onSelected: (value) async {
          if (value == 'delete') {
            // Use controller to delete comment
            await commentController.deleteComment(
              videoId: videoId,
              commentId: comment.id,
            );
          } else if (value == 'edit') {
            // Show edit dialog
            final TextEditingController editController =
            TextEditingController(text: comment.content);

            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text("Edit Comment"),
                content: TextField(
                  controller: editController,
                  maxLines: null,
                  decoration: const InputDecoration(hintText: "Edit your comment"),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      final newContent = editController.text.trim();
                      if (newContent.isNotEmpty) {
                        await commentController.updateComment(
                          videoId: videoId,
                          commentId: comment.id,
                          newContent: newContent,
                        );
                      }
                      Navigator.pop(dialogContext);
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            );
          }
        },
      )
          : null,
    );
  }
}
