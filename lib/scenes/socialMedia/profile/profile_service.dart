import 'profile_view_model.dart';

class ProfileService {
  Future<UserProfileModel> fetchProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return UserProfileModel(
      name: 'Victor Hugo',
      headline: 'Desenvolvedor Mobile | Flutter | iOS | Android',
      location: 'São Paulo, Brasil',
      avatar: 'VH',
      connections: 487,
      about: 'Desenvolvedor apaixonado por criar aplicativos móveis incríveis. '
          'Especializado em Flutter e desenvolvimento nativo. '
          'Sempre buscando aprender novas tecnologias e compartilhar conhecimento com a comunidade.',
      experiences: [
        ExperienceModel(
          title: 'Desenvolvedor Mobile Senior',
          company: 'Tech Innovation',
          duration: 'jan 2022 - Presente · 2 anos',
          location: 'São Paulo, Brasil',
          description: 'Desenvolvimento de aplicativos Flutter multiplataforma. '
              'Liderança técnica de squad mobile.',
        ),
        ExperienceModel(
          title: 'Desenvolvedor Flutter',
          company: 'StartupXYZ',
          duration: 'mar 2020 - dez 2021 · 1 ano 10 meses',
          location: 'São Paulo, Brasil',
          description: 'Desenvolvimento e manutenção de apps Flutter.',
        ),
        ExperienceModel(
          title: 'Desenvolvedor Android',
          company: 'Mobile Solutions',
          duration: 'jan 2018 - fev 2020 · 2 anos 2 meses',
          location: 'São Paulo, Brasil',
        ),
      ],
      education: [
        EducationModel(
          institution: 'Universidade de São Paulo',
          degree: 'Bacharelado em Ciência da Computação',
          period: '2014 - 2018',
        ),
        EducationModel(
          institution: 'Alura',
          degree: 'Formação Flutter',
          period: '2020',
        ),
      ],
      skills: [
        'Flutter',
        'Dart',
        'iOS',
        'Android',
        'Swift',
        'Kotlin',
        'Firebase',
        'REST APIs',
        'Git',
        'Agile/Scrum',
      ],
    );
  }

  Future<bool> updateProfile(UserProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<bool> updateAbout(String about) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> addExperience(ExperienceModel experience) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> updateExperience(String id, ExperienceModel experience) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> deleteExperience(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> addEducation(EducationModel education) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<bool> addSkill(String skill) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> removeSkill(String skill) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<String?> uploadProfilePhoto(String imagePath) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return 'https://example.com/photos/profile.jpg';
  }

  Future<String> getShareableLink() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return 'https://linkedin.com/in/victorhugo';
  }
}
