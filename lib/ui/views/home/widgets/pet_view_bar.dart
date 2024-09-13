import 'package:flutter/material.dart';
import 'package:myapp/ui/views/home/controller/home_controller.dart';

class PetViewBar extends StatelessWidget {
  const PetViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          //TODO: reactivar esta wea
          Container(
            width: double.infinity,
            color: Colors.red,
            alignment: Alignment.bottomCenter,
            child: Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 200,
            ),
            // child: O3D.asset(
            //   key: UniqueKey(),
            //   src: 'assets/3d_models/toon_cat_free.glb',
            //   controller: HomeController.instance.modelController,
            //   backgroundColor: Colors.purple,
            //   ar: false,
            //   autoPlay: true,
            //   autoRotate: false,
            //   xrEnvironment: false,
            //   touchAction: TouchAction.none,
            //   cameraControls: true,
            //   disablePan: true,
            //   disableZoom: true,
            // ),
          ),
          const Positioned(
            top: 30,
            child: SafeArea(
              child: Text(
                'Donita Barra',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
