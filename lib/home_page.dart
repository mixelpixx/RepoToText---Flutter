import 'package:flutter/material.dart';
import 'repo_scraper.dart';
import 'file_types.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _repoScraper = RepoScraper();
  final _formKey = GlobalKey<FormState>();
  String _repoUrl = '';
  String _docUrl = '';
  String _fileSelection = 'all';
  List<String> _selectedFileTypes = [];
  String _response = '';

  void _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      List<String> fileTypesToSend = _fileSelection == 'all' ? FILE_TYPES : _selectedFileTypes;
      try {
        String response = await _repoScraper.scrapeRepo(_repoUrl, _docUrl, fileTypesToSend);
        setState(() {
          _response = response;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter Github repo URL'),
              validator: (value) => value.isEmpty ? 'Please enter a repo URL' : null,
              onSaved: (value) => _repoUrl = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter documentation URL (optional)'),
              onSaved: (value) => _docUrl = value,
            ),
            ...rest of the code...
          ],
        ),
      ),
    );
  }
}

...rest of the code...
