import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final Map job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        title: Text(job['title'] ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(job['description'] ?? ''),
        trailing: Text(job['location'] ?? ''),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => JobDetailScreen(job: job))),
      ),
    );
  }
}

class JobDetailScreen extends StatelessWidget {
  final Map job;
  const JobDetailScreen({super.key, required this.job});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(job['title'] ?? ''),
          backgroundColor: const Color(0xFF0A47A1)),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(job['description'] ?? '')),
    );
  }
}
