mkdir .vscode bin lib src

touch .vscode/settings.json

echo '{
    "java.project.sourcePaths": [
        "src"
    ],
    "java.project.outputPath": "bin",
    "java.project.referencedLibraries": [
        "lib/**/*.jar",
    ]
}'>.vscode/settings.json 