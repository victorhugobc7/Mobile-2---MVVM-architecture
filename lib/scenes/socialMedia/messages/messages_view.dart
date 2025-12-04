import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../resources/shared/colors.dart';
import 'messages_view_model.dart';

class MessagesView extends StatelessWidget {
  final MessagesViewModel viewModel;

  const MessagesView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MessagesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: primaryInk),
                onPressed: vm.goBack,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mensagens',
                    style: TextStyle(
                      color: primaryInk,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (vm.totalUnread > 0)
                    Text(
                      '${vm.totalUnread} não lida${vm.totalUnread > 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: gray_600,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list, color: gray_600),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.edit_square, color: gray_600),
                  onPressed: vm.composeNewMessage,
                ),
              ],
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _buildSearchBar(vm),
                      Expanded(
                        child: vm.messages.isEmpty
                            ? _buildEmptyState()
                            : ListView.separated(
                                itemCount: vm.messages.length,
                                separatorBuilder: (_, __) => const Divider(
                                  height: 1,
                                  indent: 80,
                                ),
                                itemBuilder: (context, index) {
                                  return _buildMessageItem(
                                    vm.messages[index],
                                    vm,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(MessagesViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: vm.updateSearch,
        decoration: InputDecoration(
          hintText: 'Pesquisar mensagens',
          hintStyle: const TextStyle(color: gray_500),
          prefixIcon: const Icon(Icons.search, color: gray_500),
          filled: true,
          fillColor: gray_200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message_outlined,
            size: 80,
            color: gray_400,
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhuma mensagem',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: gray_600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Comece uma conversa!',
            style: TextStyle(
              fontSize: 14,
              color: gray_500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(MessageModel message, MessagesViewModel vm) {
    return InkWell(
      onTap: () => vm.openConversation(message.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: navy_700,
                  child: Text(
                    message.contactAvatar,
                    style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (message.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: green_confirmation,
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.contactName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: message.unreadCount > 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: primaryInk,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        message.timeAgo,
                        style: TextStyle(
                          fontSize: 12,
                          color: message.unreadCount > 0 ? blue_500 : gray_500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.lastMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: message.unreadCount > 0
                                ? primaryInk
                                : gray_600,
                            fontWeight: message.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (message.unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: blue_500,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message.unreadCount.toString(),
                            style: const TextStyle(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
