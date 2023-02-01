import 'package:flutter/material.dart';
import 'package:resource_monitor/resource_monitor.dart';
import 'package:system_info2/system_info2.dart';

const int kMEGABYTE = 1024 * 1024;

class SystemInfo extends StatefulWidget {
  const SystemInfo({super.key});

  @override
  State<SystemInfo> createState() => _SystemInfoState();
}

class _SystemInfoState extends State<SystemInfo> {
  late String totalPhysicalMemory;
  late String freePhysicalMemory;
  late String totalVirtualMemory;
  late String virtualMemorySize;
  late String freeVirtualMemory;
  String? cpuUsage;
  String? memoryUsage;

  _setSystemInfo() async {
    totalPhysicalMemory =
        'Total physical memory: ${SysInfo.getTotalPhysicalMemory() ~/ kMEGABYTE} MB';
    freePhysicalMemory =
        'Free physical memory: ${SysInfo.getFreePhysicalMemory() ~/ kMEGABYTE} MB';
    totalVirtualMemory =
        'Total virtual memory: ${SysInfo.getTotalVirtualMemory() ~/ kMEGABYTE} MB';
    virtualMemorySize =
        'Free virtual memory: ${SysInfo.getVirtualMemorySize() ~/ kMEGABYTE} MB';
    freeVirtualMemory =
        'Virtual memory size: ${SysInfo.getFreeVirtualMemory() ~/ kMEGABYTE} MB';
    try {
      final data = await ResourceMonitor.getResourceUsage;

      cpuUsage = '${data.cpuInUseByApp.toStringAsFixed(2)}%';
      memoryUsage = '${data.memoryInUseByApp.toStringAsFixed(2)}%';
    } catch (e) {
      //Do Nothing
    }
  }

  @override
  void initState() async {
    await _setSystemInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        IconButton(
          onPressed: () {
            setState(() async {
              await _setSystemInfo();
            });
          },
          icon: const Icon(Icons.repeat),
        ),
        Text(totalPhysicalMemory),
        Text(freePhysicalMemory),
        Text(totalVirtualMemory),
        Text(virtualMemorySize),
        Text(freeVirtualMemory),
        if (cpuUsage != null) Text(cpuUsage!),
        if (memoryUsage != null) Text(memoryUsage!),
      ],
    );
  }
}
