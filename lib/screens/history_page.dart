import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/cubit/pets_cubit.dart';

class History extends StatefulWidget {
  const History({
    super.key,
  });

  static const routeName = '/history';

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopted Pets'),
      ),
      body: BlocBuilder<PetsCubit, PetsState>(
        builder: (context, state) {
          print(state.adoptedPets.length);
          print(state.pets.length);
          return state.adoptedPets.isEmpty
              ? const Center(
                  child: Text('No pets adopted yet!'),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: state.adoptedPets.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final pet = state.adoptedPets[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Image.asset(
                            pet.image,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                          title: Text(pet.name),
                          subtitle: Text(pet.price),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
