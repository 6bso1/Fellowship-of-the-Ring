class Player {
  late int id;
  String firstName;
  String lastName;
  String position;
  int age;
  String imageAddress;
  String country;
  String city;

  Player(this.id, this.firstName, this.lastName, this.age, this.position,
      this.imageAddress, this.country, this.city) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
    this.position = position;
    this.imageAddress = imageAddress;
    this.country = country;
    this.city = city;
  }
}
