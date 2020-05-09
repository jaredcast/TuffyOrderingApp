class Profile{
  String uid;
  String email;
  String role;

  Profile.fromMap(Map<String, dynamic> data){
    uid = data['uid'];
    email = data['email'];
    role = data['role'];  
  }
}
