import 'feed_view_model.dart';

class FeedService {
  Future<List<PostModel>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      PostModel(
        id: '1',
        authorName: 'Maria Silva',
        authorTitle: 'Desenvolvedora Senior na Tech Corp',
        authorAvatar: 'MS',
        content: '🚀 Acabei de concluir minha certificação em Flutter! Muito feliz com essa conquista. A jornada foi desafiadora, mas valeu cada momento de dedicação.\n\n#Flutter #Desenvolvimento #Carreira',
        likes: 234,
        comments: 45,
        shares: 12,
        timeAgo: '2h',
      ),
      PostModel(
        id: '2',
        authorName: 'João Santos',
        authorTitle: 'Product Manager na StartupXYZ',
        authorAvatar: 'JS',
        content: 'Dica de carreira: Nunca pare de aprender! O mercado de tecnologia está em constante evolução e quem não se atualiza fica para trás.\n\nQuais cursos vocês estão fazendo atualmente?',
        likes: 567,
        comments: 89,
        shares: 34,
        timeAgo: '4h',
      ),
      PostModel(
        id: '3',
        authorName: 'Ana Costa',
        authorTitle: 'UX Designer na DesignStudio',
        authorAvatar: 'AC',
        content: 'Estamos contratando! 🎨\n\nProcuramos designers talentosos para integrar nossa equipe. Se você tem paixão por criar experiências incríveis, venha fazer parte do nosso time!\n\n#Vagas #UXDesign #Emprego',
        likes: 890,
        comments: 156,
        shares: 78,
        timeAgo: '6h',
      ),
      PostModel(
        id: '4',
        authorName: 'Pedro Oliveira',
        authorTitle: 'CEO na InovaTech',
        authorAvatar: 'PO',
        content: 'Reflexão do dia: O sucesso não é sobre onde você está, mas sobre a direção que você está seguindo. Continue evoluindo! 💪',
        likes: 1234,
        comments: 203,
        shares: 89,
        timeAgo: '8h',
      ),
    ];
  }

  Future<bool> toggleLike(String postId, bool currentlyLiked) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return !currentlyLiked;
  }

  Future<void> createComment(String postId, String comment) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> sharePost(String postId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
