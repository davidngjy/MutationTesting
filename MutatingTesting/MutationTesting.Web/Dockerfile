#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["MutationTesting.Business/MutationTesting.Business.csproj", "MutationTesting.Business/"]
COPY ["MutationTesting.Web/MutationTesting.Web.csproj", "MutationTesting.Web/"]
RUN dotnet restore "MutationTesting.Web/MutationTesting.Web.csproj"
COPY . .
WORKDIR "/src/MutationTesting.Web"
RUN dotnet build "MutationTesting.Web.csproj" -c Release -o /app/build

FROM build AS unittests
WORKDIR /src
RUN dotnet new sln -n MutationTesting.UnitTests
RUN dotnet sln MutationTesting.UnitTests.sln add MutationTesting.*.Test.UnitTests
RUN dotnet restore MutationTesting.UnitTests.sln
RUN dotnet build MutationTesting.UnitTests.sln
ENTRYPOINT ["dotnet", "test", "MutationTesting.UnitTests.sln", "--logger:trx", "--collect:XPlat Code Coverage", "--results-directory:./TestResults"]

FROM build AS mutationtests
WORKDIR /src
RUN dotnet new tool-manifest
RUN dotnet tool install dotnet-stryker

CMD (cd MutationTesting.Web.Test.UnitTests && dotnet stryker) && \
	(cd MutationTesting.Business.Test.UnitTests && dotnet stryker)

FROM build AS publish
RUN dotnet publish "MutationTesting.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MutationTesting.Web.dll"]