import 'package:camera/camera.dart';
import 'package:camera_app/main.dart';
import 'package:camera_app/view/gallery_view.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('Access was desnied');
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: CameraPreview(_cameraController),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2.7,
            child: MaterialButton(
              onPressed: () async {
                if (!_cameraController.value.isInitialized) {
                  return;
                }
                if (_cameraController.value.isTakingPicture) {
                  return;
                }

                try {
                  await _cameraController.setFlashMode(FlashMode.auto);
                  XFile picture = await _cameraController.takePicture();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GalleryView(file: picture)));
                } on CameraException catch (e) {
                  debugPrint('Something went wrong! $e');
                  return;
                }
              },
              child: const Text(
                // "⚪",
                "📸",
                style: TextStyle(fontSize: 50),
              ),
            ),
          )
        ],
      ),
    );
  }
}
