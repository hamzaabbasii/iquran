

class uModel {
  final String ? uid;
  final String ? name;
  final String ? email;
  final String ? phone;
  final String ? password;
  final String ? role;
  final String ? imageName;
  final String ? gender;

  uModel(
      {
        required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.role,
        required this.imageName,
        required this.gender,

      });

  Map<String, dynamic> toMap()
  {
    return{
      'uid':uid.toString(),
      'name':name,
      'email':email,
      'phone':phone,
      'password':password,
      'role':role,
      'gender':gender,
      'imageName':imageName,
    };
  }




  factory uModel.fromFirestore(Map<String, dynamic> userData) {
    return uModel(
      uid:userData['userId'],
      name: userData['name'],
      email: userData['email'],
      phone: userData['phone'],
      password: userData['password'],
      role: userData['role'],
      imageName: userData['imageName'],
      gender: userData['gender'],
    );
  }

}
