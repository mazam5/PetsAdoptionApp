part of 'pets_cubit.dart';

class PetsInitial extends PetsState {
  const PetsInitial({
    required List<PetModel> pets,
    required List<PetModel> presentPets,
    required List<PetModel> adoptedPets,
    required String filter,
    required String search,
  }) : super(
          pets: pets,
          presentPets: presentPets,
          adoptedPets: adoptedPets,
          filter: filter,
          search: search,
        );
}

class PetsState extends Equatable {
  const PetsState({
    required this.pets,
    required this.presentPets,
    required this.adoptedPets,
    required this.filter,
    required this.search,
  });

  final List<PetModel> pets;
  final List<PetModel> presentPets;
  final List<PetModel> adoptedPets;
  final String filter;
  final String search;

  @override
  List<Object?> get props => [pets, presentPets];

  PetsState copyWith({
    List<PetModel>? pets,
    List<PetModel>? presentPets,
    required List<PetModel> adoptedPets,
  }) {
    return PetsState(
      adoptedPets: adoptedPets,
      filter: filter,
      search: search,
      pets: pets ?? this.pets,
      presentPets: presentPets ?? this.presentPets,
    );
  }
}
