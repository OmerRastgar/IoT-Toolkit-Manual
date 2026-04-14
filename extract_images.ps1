
$filePath = "d:\IOT Framework Manual\Copy of IoT Kit - Tehqiq.md"
$outputDir = "d:\IOT Framework Manual\docs\assets\images\toolkit"

if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force
}

$content = Get-Content $filePath -Raw

# Regex to find [imageX]: <data:image/png;base64,...>
# It looks for the image label and captures the base64 content between the prefix and the closing '>'
$regex = "\[image(\d+)\]: <data:image/png;base64,([^>]+)>"

$imageMatches = [regex]::Matches($content, $regex)

Write-Host "Found $($imageMatches.Count) images."

foreach ($match in $imageMatches) {
    $imgNum = $match.Groups[1].Value
    $base64 = $match.Groups[2].Value.Trim()
    
    $outputPath = Join-Path $outputDir "image$imgNum.png"
    
    try {
        $bytes = [Convert]::FromBase64String($base64)
        [IO.File]::WriteAllBytes($outputPath, $bytes)
        Write-Host "Extracted image$imgNum to $outputPath"
    } catch {
        Write-Host "Failed to extract image$imgNum : $($_.Exception.Message)" -ForegroundColor Red
    }
}
