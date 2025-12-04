import 'package:flutter/material.dart';
import '../../scenes/login/login_factory.dart';
import '../../scenes/home/home_factory.dart';
import '../../scenes/jobPrediction/job_prediction_factory.dart';
import '../../scenes/socialMedia/feed/feed_factory.dart';
import '../../scenes/socialMedia/profile/profile_factory.dart';
import '../../scenes/socialMedia/network/network_factory.dart';
import '../../scenes/socialMedia/messages/messages_factory.dart';
import '../../scenes/socialMedia/notifications/notifications_factory.dart';
import '../../scenes/socialMedia/createPost/create_post_factory.dart';
import '../../scenes/socialMedia/jobs/jobs_factory.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;

  Widget startApp() {
    return goToFeedAsHome();
  }

  Widget goToLogin() {
    return LoginFactory.make(coordinator: this);
  }

  Widget goToFeedAsHome() {
    return FeedFactory.make(coordinator: this);
  }

  void goToHome(String name, String address) {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => HomeFactory.make(
          coordinator: this,
          userName: name,
          userAddress: address,
        ),
      ),
    );
  }

  void goToJobPrediction() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => JobPredictionFactory.make(coordinator: this),
      ),
    );
  }

  // Social Media Navigation
  void goToFeed() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => FeedFactory.make(coordinator: this),
      ),
    );
  }

  void goToProfile() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => ProfileFactory.make(coordinator: this),
      ),
    );
  }

  void goToNetwork() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => NetworkFactory.make(coordinator: this),
      ),
    );
  }

  void goToMessages() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => MessagesFactory.make(coordinator: this),
      ),
    );
  }

  void goToNotifications() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => NotificationsFactory.make(coordinator: this),
      ),
    );
  }

  void goToCreatePost() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => CreatePostFactory.make(coordinator: this),
      ),
    );
  }

  void goToJobs() {
    _navigator?.push(
      MaterialPageRoute(
        builder: (_) => JobsFactory.make(coordinator: this),
      ),
    );
  }

  void pop() {
    _navigator?.pop();
  }
}