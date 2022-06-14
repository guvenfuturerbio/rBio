import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/demo/audio_recorder/cubit/recorder_cubit.dart';
import 'package:onedosehealth/features/demo/play_audio/controller/audio_controller.dart';
import 'package:onedosehealth/features/demo/play_audio/cubit/files_cubit.dart';

class AudioRecordScreen extends StatelessWidget {
  const AudioRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RecorderCubit()..deleteRecordFolder(),
        ),
        BlocProvider(
          create: (context) => FilesCubit(),
        ),
      ],
      child: const AudioRecordView(),
    );
  }
}

class AudioRecordView extends StatefulWidget {
  const AudioRecordView({Key? key}) : super(key: key);

  @override
  State<AudioRecordView> createState() => _AudioRecordViewState();
}

class _AudioRecordViewState extends State<AudioRecordView> {
  final AudioPlayerController audioPlayerController = AudioPlayerController();

  @override
  void dispose() {
    audioPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(title: const Text('Test')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.mic),
                onPressed: () async {
                  await context.read<RecorderCubit>().startRecording();
                },
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: () async {
                  await context.read<RecorderCubit>().stopRecording();
                  await context.read<FilesCubit>().getFiles(path: 'myrecord');
                },
              ),
              IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () {
                  context.read<RecorderCubit>().pauseRecording();
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow_outlined),
                onPressed: () {
                  context.read<RecorderCubit>().resumeRecording();
                },
              ),
            ],
          ),
          BlocBuilder<FilesCubit, FilesState>(
            builder: (context, FilesState state) {
              return state.when(
                initial: () => const SizedBox(),
                loadInProgress: () => const RbioLoading(),
                success: (recordList) => Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  audioPlayerController.setPath(filePath: recordList[index].file.path);
                                  audioPlayerController.play();
                                },
                                icon: const Icon(Icons.play_arrow_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  audioPlayerController.pause();
                                },
                                icon: const Icon(Icons.pause),
                              ),
                              IconButton(
                                onPressed: () {
                                  audioPlayerController.play();
                                },
                                icon: const Icon(Icons.play_circle_outline),
                              ),
                              IconButton(
                                onPressed: () {
                                  audioPlayerController.stop();
                                  audioPlayerController.setPath(filePath: recordList[index].file.path);
                                },
                                icon: const Icon(Icons.stop),
                              ),
                            ],
                          ),
                          Text(recordList.first.file.path),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemCount: recordList.length,
                  ),
                ),
                failure: () => const RbioBodyError(),
              );
            },
          ),
        ],
      ),
    );
  }
}
