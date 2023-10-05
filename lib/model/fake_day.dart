
enum TypeOfWork{
  dev,
  preparation,
  cours,
  formation,
  none,
}

class FakeDay {
  const FakeDay ({required this.type,required this.repos, this.formation,required this.nbrPerson});
  final TypeOfWork type;
  final bool repos;
  final String? formation;
  final int nbrPerson;
}