import 'package:flutter/material.dart';
import 'dart:io' show File, Platform;
import '../../../utils/color_resources.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final List<String> _categories = [
    'Recent',
    'Favourites',
    'For You',
    'New',
    'Trending'
  ];
  int _selectedCategoryIndex = 0;
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Normal', 'Blur', 'B&W', 'Sepia', 'Vintage'];
  final List<String> recentLens = ['Black', 'Blue', 'Purple', 'Green'];
  final List<String> favouriteLens = ['Dog', 'Cat', 'Voice'];
  final List<String> foryouLens = ['SunKissed', 'Day&Night', 'Vinashe Mood'];
  final List<String> trendingLens = ['Blue', 'Sunkissed', 'Vinashe Mood'];
  final List<String> newLens = [
    'Color Picker',
    'Creemy',
    'Toaster',
    'Vabia',
    'Nogia'
  ];

  CameraController? _controller;
  File? _capturedImage;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _captureImage() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isCapturing) {
      return;
    }

    setState(() {
      _isCapturing = true;
    });

    try {
      final XFile image = await _controller!.takePicture();
      setState(() {
        _capturedImage = File(image.path);
        _isCapturing = false;
      });

      // Show preview screen
      if (mounted) {
        await _showCapturePreview();
      }
    } catch (e) {
      print('Error capturing image: $e');
      setState(() {
        _isCapturing = false;
      });
    }
  }

  Future<void> _showCapturePreview() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Captured Image
              Center(
                child: Image.file(_capturedImage!),
              ),

              // Bottom Actions
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _capturedImage = null;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.check,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        // TODO: Handle saving/sharing the image
                        Navigator.pop(context);
                        setState(() {
                          _capturedImage = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getCurrentLenses() {
    switch (_categories[_selectedCategoryIndex]) {
      case 'Recent':
        return recentLens;
      case 'Favourites':
        return favouriteLens;
      case 'For You':
        return foryouLens;
      case 'New':
        return newLens;
      case 'Trending':
        return trendingLens;
      default:
        return _filters;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          if (_controller?.value.isInitialized ?? false)
            Center(
              child: CameraPreview(_controller!),
            ),

          // Filter Scroller and Capture Button Row
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    // Main Filter Scroller
                    SizedBox(
                      height: 80,
                      child: PageView.builder(
                        itemCount: _getCurrentLenses().length,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedFilterIndex = index;
                          });
                        },
                        controller: PageController(
                          viewportFraction: 0.18,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 65,
                            height: 65,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedFilterIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _getCurrentLenses()[index],
                              style: TextStyle(
                                color: _selectedFilterIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.7),
                                fontSize: 11,
                                fontWeight: _selectedFilterIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Categories Scroller
                    if (_selectedFilterIndex != 0)
                      Container(
                        height: 36,
                        margin: const EdgeInsets.only(top: 15),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  color: _selectedCategoryIndex == index
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 3,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  _categories[index],
                                  style: TextStyle(
                                    color: _selectedCategoryIndex == index
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.8),
                                    fontSize: 13,
                                    fontWeight: _selectedCategoryIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),

                // Capture Button
                Positioned(
                  top: -5,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: _captureImage,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedFilterIndex == 0
                              ? Colors.transparent
                              : Platform.isIOS
                                  ? IOSColorResources.COLOR_PRIMARY
                                      .withOpacity(0.3)
                                  : AndroidColorResources.COLOR_PRIMARY
                                      .withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
