param(
    [Parameter()]
    [ValidateSet('All', 'UnitTests', 'MutationTests')]
    [String]
    $TestType = 'All'
)

function Invoke-UnitTests {
    docker-compose -f ./MutatingTesting/docker-compose.yml -f ./MutatingTesting/docker-compose.unit-tests.yml up --build mutationtesting.web
    docker-compose -f ./MutatingTesting/docker-compose.yml -f ./MutatingTesting/docker-compose.unit-tests.yml down
}

function Show-TestResults {
    param(
        [Parameter(Mandatory)]
        [String]
        $ResultsFolder
    )

    $testResults = Get-ChildItem -Path $ResultsFolder -Filter *.trx | Select-Object -ExpandProperty FullName | Resolve-Path -Relative
    if ($null -ne $testResults) {
        foreach ($testResult in $testResults) {
            $result = Get-MsTestResult -Path $testResult
            $summary = $result.TestResultSummary
            Write-Host "$($summary.TrxFile) - $($summary.Passed)/$($summary.Total) tests passed."
            if ($null -ne $results.FailedTests) {
                Write-Host "The following tests failed:" -ForegroundColor Red
                $results.FailedTests.TestName
            }
        }
        Remove-Item -Recurse -Force -Path $ResultsFolder
    } else {
        Write-Host "Could not find test results at $ResultsFolder." -ForegroundColor Red
    }
}

function Show-UnitTestsResults {
    Write-Host "Unit Tests Results" -ForegroundColor DarkGreen
    Show-TestResults -ResultsFolder ".\MutatingTesting\TestResults"
}

Install-Module -Name TrxParser

if ($TestType -eq 'All') {
    Invoke-UnitTests
    Show-UnitTestsResults
}

if ($TestType -eq 'UnitTests') {
    Invoke-UnitTests
    Show-UnitTestsResults
}