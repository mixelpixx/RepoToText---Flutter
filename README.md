![example workflow](https://github.com/JeremiahPetersen/RepoToText/actions/workflows/pylint.yml/badge.svg)
![example workflow](https://github.com/JeremiahPetersen/RepoToText/actions/workflows/es-lint.yml/badge.svg)

![repo to text 5](https://github.com/JeremiahPetersen/RepoToText/assets/118206017/0d65016d-6388-48e0-b833-4ea1a169acfe)

![repo to text 7](https://github.com/JeremiahPetersen/RepoToText/assets/118206017/7d28fa8f-8bb1-4ddd-99f3-b33ddb26f0e9)

## RepoToText

RepoToText is a web app that scrapes a GitHub repository and converts its files into a single organized .txt. It allows you to enter the URL of a GitHub repository and an optional documentation URL (the doc info will append to the top of the .txt). The app retrieves the contents of the repository, including all files and directories, and also fetches the documentation from the provided URL and includes it in a single organized text file. The .txt file will be saved in the /data folder with user + repo + timestamp info. This file can then be uploaded to (GPT-4, Claude Opus, etc) and you can use the chatbot to interact with the entire GitHub repo. 

...

## Running the Application with 'Flutter'

To run the application using 'Flutter', follow these steps:

1. Clone the repository.
2. Install Flutter and Dart on your local machine.
3. Navigate to the project directory and run `flutter pub get` to fetch the dependencies.
4. Start the application with `flutter run`.
5. Access the application (http://localhost:8080) in a web browser and enter the GitHub repository URL and documentation URL (if available).
6. Choose All files or choose specific file types.
7. Click the "Submit" button to initiate the scraping process. The converted text will be displayed in the output area, and it will also be saved in the /data folder. 
8. You can also click the "Copy Text" button to copy the generated text to the clipboard.

...

## Prompt Example

This is a .txt file that represents an entire GitHub repository. The repository's individual files are separated by the sequence '''--- , followed by the file path, ending with ---. Each file's content begins immediately after its file path and extends until the next sequence of '''--- *Add your idea here (Example)*: Please create a react front end that will work with the back end 

## Environment Configuration
Add your GitHub API Key in the .env file
