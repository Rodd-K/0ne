import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/job_card.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});
  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  List<dynamic> _jobs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final jobs = await ApiService.fetchJobs();
      setState(() {
        _jobs = jobs;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Jobs'), backgroundColor: const Color(0xFF0A47A1)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _jobs.length,
                    itemBuilder: (c, i) => JobCard(job: _jobs[i]),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0A47A1),
        child: const Icon(Icons.add),
        onPressed: () {/* open job creation flow */},
      ),
    );
  }
}
