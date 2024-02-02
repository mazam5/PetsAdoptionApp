import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets_app/cubit/pets_cubit.dart';
import 'package:pets_app/src/adopted/darkmode_controller.dart';
import 'package:pets_app/widgets/pet_item.dart';

import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DarkModeController controller;

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<PetsCubit>().fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopt a Pet'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, History.routeName);
            },
            icon: const Icon(Icons.favorite_rounded),
          ),
          IconButton(
            tooltip: "Toggle Theme",
            onPressed: () {
              widget.controller.updateThemeMode(
                widget.controller.themeMode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
            icon: Icon(
              widget.controller.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: BlocBuilder<PetsCubit, PetsState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            context.read<PetsCubit>().searchPets(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(value: 'dog', child: Text('Dog')),
                        DropdownMenuItem(value: 'cat', child: Text('Cat')),
                      ],
                      onChanged: (value) {
                        context.read<PetsCubit>().filterPets(value!);
                      },
                      hint: const Text('Filter'),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        context.read<PetsCubit>().fetchPets();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.presentPets.length,
                  itemBuilder: (context, index) {
                    return PetItem(
                      id: state.presentPets[index].id,
                      name: state.presentPets[index].name,
                      age: state.presentPets[index].age,
                      price: state.presentPets[index].price,
                      category: state.presentPets[index].category,
                      image: state.presentPets[index].image,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<PetsCubit>().previousPage();
                    },
                    icon: const Icon(Icons.arrow_circle_left_sharp),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<PetsCubit>().nextPage();
                    },
                    icon: const Icon(Icons.arrow_circle_right_sharp),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
