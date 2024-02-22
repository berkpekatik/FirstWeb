# Base image olarak .NET Core SDK kullan�n
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Ba��ml�l�klar� kopyalay�n ve proje dosyalar�n� kopyalay�n
COPY *.csproj ./
RUN dotnet restore

# Proje dosyalar�n� kopyalay�n ve build i�lemini ger�ekle�tirin
COPY . .
RUN dotnet publish -c Release -o out

# Son a�amada sadece runtime i�in hafif bir imaj kullan�n
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 80

# Uygulamay� �al��t�r�n
ENTRYPOINT ["dotnet", "FirstWeb.dll"]