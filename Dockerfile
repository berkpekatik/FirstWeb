# Base image olarak .NET Core SDK kullanýn
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Baðýmlýlýklarý kopyalayýn ve proje dosyalarýný kopyalayýn
COPY *.csproj ./
RUN dotnet restore

# Proje dosyalarýný kopyalayýn ve build iþlemini gerçekleþtirin
COPY . .
RUN dotnet publish -c Release -o out

# Son aþamada sadece runtime için hafif bir imaj kullanýn
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 80

# Uygulamayý çalýþtýrýn
ENTRYPOINT ["dotnet", "FirstWeb.dll"]