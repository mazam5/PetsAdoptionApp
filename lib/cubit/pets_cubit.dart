import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/pets.dart';

part 'pets_state.dart';

class PetsCubit extends Cubit<PetsState> {
  PetsCubit()
      : super(
          const PetsState(
            filter: '',
            search: '',
            pets: [],
            presentPets: [],
            adoptedPets: [],
            darkMode: false,
          ),
        );

  int _currentPage = 0;
  final int _pageSize = 12;

  void toggleDarkMode() {
    emit(
      state.copyWith(
        darkMode: !state.darkMode,
        pets: state.pets,
        adoptedPets: state.adoptedPets,
        presentPets: state.presentPets,
      ),
    );
  }

  Future<void> fetchPets() async {
    final petJson = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> data = json.decode(petJson);
    final List<dynamic> pets = data['pets'];
    emit(
      state.copyWith(
        pets: pets.map((e) => PetModel.fromJson(e)).toList(),
        presentPets: _getPaginatedPets(
          pets.map((e) => PetModel.fromJson(e)).toList(),
        ),
        darkMode: false,
        adoptedPets: state.adoptedPets,
      ),
    );
  }

  List<PetModel> _getPaginatedPets(List<PetModel> pets) {
    final int start = _currentPage * _pageSize;
    final int end = start + _pageSize;
    return pets.sublist(start, end);
  }

  void nextPage() {
    if ((_currentPage + 1) * _pageSize < state.pets.length) {
      _currentPage++;
      emit(
        state.copyWith(
          presentPets: _getPaginatedPets(state.pets),
          darkMode: false,
          pets: state.pets,
          adoptedPets: state.adoptedPets,
        ),
      );
    }
  }

  void previousPage() {
    if (_currentPage > 0 && _currentPage * _pageSize < state.pets.length) {
      _currentPage--;
      emit(
        state.copyWith(
          presentPets: _getPaginatedPets(state.pets),
          darkMode: false,
          pets: state.pets,
          adoptedPets: state.adoptedPets,
        ),
      );
    }
  }

  void searchPets(String value) {
    final List<PetModel> pets = state.pets;
    final String search = value;
    final List<PetModel> searchedPets = pets
        .where(
          (element) =>
              element.name.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
    emit(
      state.copyWith(
        presentPets: searchedPets,
        darkMode: false,
        adoptedPets: [],
      ),
    );
  }

  void filterPets(String value) {
    final List<PetModel> pets = state.pets;
    final String filter = value;
    final List<PetModel> filteredPets = pets
        .where(
          (element) => element.category.toLowerCase() == filter.toLowerCase(),
        )
        .toList();
    emit(
      state.copyWith(
        presentPets: filteredPets,
        darkMode: false,
        adoptedPets: [],
      ),
    );
  }

  void adoptPet(int id) {
    final List<PetModel> adoptedPets = List.from(state.adoptedPets);
    final List<PetModel> pets = List.from(state.pets);
    final PetModel pet = pets.firstWhere((element) => element.id == id);
    adoptedPets.add(pet);
    final List<PetModel> updatedPresentPets = List.from(state.presentPets);
    updatedPresentPets.removeWhere((element) => element.id == id);
    emit(
      state.copyWith(
        presentPets: updatedPresentPets,
        adoptedPets: adoptedPets,
        darkMode: false,
      ),
    );
    print(state.adoptedPets.length);
  }
}

enum ThemeModeEvent { loadSettings, updateThemeMode }

class ThemeModeCubit extends Cubit<ThemeMode> {
  final DarkModeService _settingsService;

  ThemeModeCubit(this._settingsService) : super(ThemeMode.system);

  Future<void> loadSettings() async {
    ThemeMode mode = await _settingsService.themeMode();
    emit(mode);
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    emit(newThemeMode);
    await _settingsService.updateThemeMode(newThemeMode);
  }
}

class DarkModeService {
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<void> updateThemeMode(ThemeMode theme) async {}
}
