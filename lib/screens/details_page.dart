import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/cubit/pets_cubit.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  static const routeName = '/details';

  final int id;

  @override
  State<DetailsPage> createState() => DetailsViewState();
}

class DetailsViewState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Details'),
      ),
      body: BlocBuilder<PetsCubit, PetsState>(
        builder: (context, state) {
          final pet = state.pets[widget.id];
          if (state.pets.isNotEmpty) {
            return Column(
              children: [
                Image.asset(
                  pet.image,
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        pet.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<PetsCubit>().adoptPet(pet.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("You've adopted ${pet.name}!"),
                            ),
                          );
                        },
                        label: const Text('Adopt Me!'),
                        icon: const Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  pet.price,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  pet.age,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  pet.category,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
