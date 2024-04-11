import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Type Selector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FileTypeSelector(),
    );
  }
}

class FileTypeSelector extends StatefulWidget {
  const FileTypeSelector({Key? key}) : super(key: key);

  @override
  State<FileTypeSelector> createState() => _FileTypeSelectorState();
}

class _FileTypeSelectorState extends State<FileTypeSelector> {
  final TextEditingController _githubRepoController = TextEditingController();
  final TextEditingController _documentationUrlController = TextEditingController();
  bool _selectAllFiles = false;
  final List<String> _fileTypes = [
    'txt', 'py', 'js', 'sql', 'env', 'json', 'html', 'css', 
    'java', 'cpp', 'c', 'php', 'rb', 'asm', 'xml', 'md', 'bat',
    'sh', 'swift', 'h', 'pyw', 'go', 'aspx', 'asp', 'java',
    'cmd', 'clis', 'coffee', 'erb', 'pas', 'groovy', 'htaccess', 'lua',
    'jsp', 'scala', 'make', 'matlab', 'vb', 'perl', 'phtml', 'xsl', 'r', 'scm', 'sin'
  ];
  final List<bool> _selectedFileTypes = List.filled(42, false);

  Future<void> fetchRepoData() async {
    final selectedFileTypes = _fileTypes.where((type, index) => _selectedFileTypes[index]).toList();
    final response = await http.post(
      Uri.parse('http://localhost:5000/scrape'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'repoUrl': _githubRepoController.text,
        'docUrl': _documentationUrlController.text,
        'selectedFileTypes': selectedFileTypes,
      }),
    );
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      print(jsonDecode(response.body)['response']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch repo data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Type Selector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Github Repo URL Input
            TextFormField(
              controller: _githubRepoController,
              decoration: const InputDecoration(
                labelText: 'Enter Github repo URL',
              ),
            ),
            const SizedBox(height: 20),

            // Documentation URL Input
            TextFormField(
              controller: _documentationUrlController,
              decoration: const InputDecoration(
                labelText: 'Enter documentation URL (optional)',
              ),
            ),
            const SizedBox(height: 20),

            // File Type Selection
            Row(
              children: [
                // Select All Checkbox
                Checkbox(
                  value: _selectAllFiles,
                  onChanged: (value) {
                    setState(() {
                      _selectAllFiles = value!;
                      _selectedFileTypes.fillRange(0, _selectedFileTypes.length, value);
                    });
                  },
                ),
                const Text('All Files'),

                const SizedBox(width: 20),

                // Select File Types Radio Button
                Radio(
                  value: false,
                  groupValue: _selectAllFiles,
                  onChanged: (value) {
                    setState(() {
                      _selectAllFiles = false;
                    });
                  },
                ),
                const Text('Select File Types'),
              ],
            ),
            
            // File Type Checkboxes
            Expanded(
              child: GridView.count(
                crossAxisCount: 5,
                children: List.generate(_fileTypes.length, (index) {
                  return CheckboxListTile(
                    title: Text(_fileTypes[index]),
                    value: _selectedFileTypes[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedFileTypes[index] = value!;
                      });
                    },
                  );
                }),
              ),
            ),

            // Submit & Copy Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fetchRepoData();
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement copy text logic
                  },
                  child: const Text('Copy Text'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
