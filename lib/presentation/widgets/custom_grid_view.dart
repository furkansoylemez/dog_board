import 'package:dog_board/domain/entity/image_list.dart';
import 'package:dog_board/presentation/widgets/custom_image_container.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    required this.imageList,
    super.key,
  });
  final ImageList imageList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: imageList.images.length,
      itemBuilder: (context, index) {
        return CustomImageContainer(imageUrl: imageList.images[index]);
      },
    );
  }
}
