import 'package:flutter/cupertino.dart';
import 'package:order_app_362/profile-view.dart';
import 'dart:collection';

class ProfileNotifier with ChangeNotifier{
  List<Profile> _profileList = [];
  Profile _currentProfile;

  UnmodifiableListView<Profile> get profileList => UnmodifiableListView(_profileList);

  set profileList(List<Profile> profileList){
    _profileList = profileList;
    notifyListeners();
  }

  set currentProfile(Profile profile){
    currentProfile = profile;
    notifyListeners();
  }
}