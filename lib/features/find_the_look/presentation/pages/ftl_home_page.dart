import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/local_picker_info.dart';
import '../../../../service_locator.dart';
import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/route_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/widgets/app_bars/app_bar_widget.dart';
import '../widgets/menu_item_widget.dart';
import 'ftl_live_page.dart';

class FTLHomePage extends StatefulWidget {
  const FTLHomePage({super.key});

  @override
  State<FTLHomePage> createState() => _FTLHomePageState();
}

class _FTLHomePageState extends State<FTLHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.horizontalPadding,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "How do you want to find the look?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            MenuItemWidget(
              iconPath: IconPath.liveCamera,
              title: "Live Camera",
              description:
                  "Capture the essence of elegance in real-time with our live camera feature. Experience instant analysis and personalized recommendations as you discover the allure of your desired look.",
              steps: const [
                "Hold the camera parallel to the face you want to analyze.",
                "Ensure the entire face is centered in the frame.",
                "Position the camera at eye level with the face.",
                "Keep the camera steady and avoid tilting.",
                "Ensure the area is well-lit for clear detection.",
                "Avoid shadows on the face by using soft, even lighting.",
              ],
              buttonText: "USE LIVE CAMERA",
              onTap: _onLiveCamera,
            ),
            const SizedBox(
              height: 20,
            ),
            MenuItemWidget(
              iconPath: IconPath.camera,
              title: "Take a Snapshot",
              description:
                  "Unveil the potential of your favorite images with our photo upload feature. Effortlessly transform static snapshots into dynamic makeup inspirations.",
              steps: const [
                "Take a clear, high-resolution photo for the best results.",
                "Make sure the entire upper body is visible in the photo.",
                "Take a photo with even lighting and minimal shadows.",
                "Ensure the photo contains only one individual for accurate analysis.",
              ],
              buttonText: "UPLOAD PHOTO",
              onTap: _onUploadImage,
            ),
            const SizedBox(
              height: 20,
            ),
            MenuItemWidget(
              iconPath: IconPath.uploadPhoto,
              title: "Upload Photo or Video",
              description:
                  "Immerse yourself in the luxury of transformation with our video upload feature. Discover and recreate makeup magic with effortless ease.",
              steps: const [
                "Choose a high-quality photo or video for upper body only.",
                "Ensure the photo or video is stable and not shaky.",
                "Make sure the entire look is visible.",
                "Opt for a photo or video with bright, even lighting and minimal shadows.",
                "Ensure the photo or video contains only one individual for precise detection.",
              ],
              buttonText: "UPLOAD VIDEO",
              onTap: _onUploadVideo,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _onLiveCamera() {
    context.goNamed(
      AppRoute.ftlLive.name,
      extra: const FTLLivePageParams(
        file: null,
      ),
    );
  }

  Future<void> _onUploadImage() async {
    // select image from gallery
    final selectedImage = await sl<LocalPickerInfo>().selectImage(
      imageSource: ImageSource.gallery,
    );
    if (selectedImage == null) {
      return;
    }

    // go to live makeup page
    context.goNamed(
      AppRoute.ftlLive.name,
      extra: FTLLivePageParams(
        file: selectedImage,
      ),
    );
  }

  Future<void> _onUploadVideo() async {
    // select video from gallery
    final selectedVideo = await sl<LocalPickerInfo>().selectVideo(
      imageSource: ImageSource.gallery,
    );
    if (selectedVideo == null) {
      return;
    }

    // go to live makeup page
    context.goNamed(
      AppRoute.ftlLive.name,
      extra: FTLLivePageParams(
        file: selectedVideo,
      ),
    );
  }
}
