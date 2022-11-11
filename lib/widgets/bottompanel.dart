import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/bottompanelservice.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';

class BottomPanel extends StatefulWidget {
  const BottomPanel({super.key});

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> with SingleTickerProviderStateMixin {
  
  late AnimationController barAnim;

  @override
  void initState() {
    super.initState();

    barAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250)
    );
  }

  @override
  void dispose() {
    barAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Consumer<BottomPanelService>(
          builder: (context, bpService, child) {
            return Stack(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withOpacity(0.5)
                      ),
                      padding: const EdgeInsets.only(left: 20, top: 20, right: 30, bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              color: AppColors.gameHeaderIconColors,
                              borderRadius: BorderRadius.circular(50),

                              child: Consumer<ScorePanelService>(
                                builder: (context, scorePanelService, child) {
                                  return InkWell(
                                    onTap: () {
                                      bpService.onPause(context);
                                    },
                                    highlightColor: Colors.white.withOpacity(0.2),
                                    splashColor: Colors.green,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        scorePanelService.isTimePaused ? Icons.play_arrow : Icons.pause, 
                                        color: Colors.black, size: 30),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              color: AppColors.gameHeaderIconColors,
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                onTap: () {
                                  bpService.onExitGame(context);
                                },
                                highlightColor: Colors.white.withOpacity(0.2),
                                splashColor: Colors.green,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(Icons.exit_to_app, color: Colors.black, size: 30),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {

                                var calculatedValue = constraints.maxWidth / bpService.initialProgressValue;

                                var valueToIncrement = calculatedValue * bpService.incrementalValue;

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: valueToIncrement,
                                      right: 10
                                      ),
                                      child: const Icon(
                                        SkippingFrogFont.frog,
                                        size: 20, 
                                        color: AppColors.gameHeaderIconColors),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      margin: const EdgeInsets.only(left: 20, bottom: 10, right: 10),
                                      height: 20,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.gameHeaderIconColors,
                                          width: 3
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                        width: valueToIncrement,
                                        decoration: BoxDecoration(
                                          color: AppColors.gameHeaderIconColors,
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                      )
                                    ),
                                  ],
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}