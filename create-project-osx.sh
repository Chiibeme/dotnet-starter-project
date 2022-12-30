#!/usr/bin/env bash
green="\033[1;32m"
reset="\033[m"

echo -e "${green}Creating solution and projects${reset}"
dotnet new sln
dotnet new webapi -n API
dotnet new classlib -n Application
dotnet new classlib -n Domain
dotnet new classlib -n Persistence

echo -e "${green}Adding projects to the solution${reset}"
dotnet sln add API/API.csproj
dotnet sln add Application/Application.csproj
dotnet sln add Domain/Domain.csproj
dotnet sln add Persistence/Persistence.csproj

echo -e "${green}Setting up project dependencies${reset}"
cd API
dotnet add reference ../Application/Application.csproj
cd ../Application
dotnet add reference ../Domain/Domain.csproj
dotnet add reference ../Persistence/Persistence.csproj
cd ../Persistence
dotnet add reference ../Domain/Domain.csproj
cd ..

echo -e "${green}Executing dotnet restore${reset}"
dotnet restore

echo -e "${green}Add gitignore${reset}"
dotnet new gitignore
cat << \EOF >> .gitignore

#User defined
appsettings.json
EOF

echo -e "${green}Clean up files!\n"
rm -rf API/**/*Forecast*.cs
rm -rf ./**/*/Class1.cs

echo -e "${green}Finished!"