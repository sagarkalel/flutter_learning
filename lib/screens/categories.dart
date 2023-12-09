import 'package:todo_app/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/dummy_data.dart';
import 'package:todo_app/screens/meals.dart';
import 'package:todo_app/widgets/category_grid_item.dart';

import '../data/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availabelMeals,
  });

  final List<Meal> availabelMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      upperBound: 1,
      lowerBound: 0,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availabelMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (a) => MealsScreen(
                  title: category.title,
                  meals: filteredMeals,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: child(),
      builder: (ctx, child) => SlideTransition(
        // position: Tween(
        //   begin: const Offset(0, 0.21),
        //   end: const Offset(0, 0),
        // ).animate(
        //   CurvedAnimation(
        //       curve: Curves.fastEaseInToSlowEaseOut,
        //       parent: _animationController),
        // ),
        position: _animationController
            .drive(Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))),
        child: child,
      ),
    );
  }

  Widget child() {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelect: () => _selectCategory(context, category),
          )
      ],
    );
  }
}
