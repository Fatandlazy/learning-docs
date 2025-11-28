<#
generate-md-from-youtube.ps1 - Generate playlist markdown and per-video detail files

CLI usage:
    PowerShell -File .\generate-md-from-youtube.ps1 -Url <playlist-url> [-OutDir <path>] [-DetailDir <name>] [-WritePlaylist]

Parameters:
    -Url         (required) YouTube playlist URL (must include `list=`)
    -OutDir      (optional) Output directory for playlist and detail files. Default: `$PSScriptRoot` (script folder). Can be absolute or relative.
    -DetailDir   (optional) Subfolder name for per-video detail files. Default: 'SSRS details'
    -WritePlaylist (switch) When present, writes the playlist markdown and per-video detail files.

Notes:
    - If `yt-dlp` is available in PATH the script will use it for more reliable metadata.
    - Without `yt-dlp` the script parses YouTube HTML which can be less reliable.
    - Requires PowerShell (Windows PowerShell 5.1+ or PowerShell Core) and internet access.

Example:
    powershell -File .\generate-md-from-youtube.ps1 -Url 'https://www.youtube.com/playlist?list=...' -WritePlaylist
#>
Param(
    [Parameter(Mandatory=$true)][string]$Url,
    [string]$OutDir = $PSScriptRoot,
    [string]$DetailDir = 'SSRS details',
    [switch]$WritePlaylist
)

function Make-Slug {
    param([string]$s)
    if (-not $s) { return "" }
    $s = $s.Normalize([Text.NormalizationForm]::FormD)
    $chars = $s.ToCharArray()
    $sb = New-Object System.Text.StringBuilder
    foreach ($c in $chars) {
        $cat = [Globalization.CharUnicodeInfo]::GetUnicodeCategory($c)
        if ($cat -ne [Globalization.UnicodeCategory]::NonSpacingMark) { [void]$sb.Append($c) }
    }
    $s = $sb.ToString()
    $s = $s.ToLower()
    # Allow dots in slugs so numeric parts like '4.1' are preserved
    $s = $s -replace '[^a-z0-9\s\.-]', ''
    $s = $s -replace '\s+', '-'    
    $s = $s -replace '-{2,}', '-'
    # Trim trailing/leading hyphens or dots
    $s = $s.Trim('-','.')
    if (-not $s) { $s = [guid]::NewGuid().ToString() }
    return $s
}

function Make-FilenameSafe {
    param([string]$name)
    if (-not $name) { return "playlist.md" }
    $invalid = [IO.Path]::GetInvalidFileNameChars()
    foreach ($c in $invalid) { $name = $name -replace [regex]::Escape($c), '-' }
    $name = $name.Trim()
    if (-not $name) { $name = 'playlist' }
    return "$name.md"
}

function Make-DirSafe {
    param([string]$name)
    if (-not $name) { return "playlist_details" }
    $invalid = [IO.Path]::GetInvalidPathChars() + [IO.Path]::GetInvalidFileNameChars()
    foreach ($c in $invalid) { $name = $name -replace [regex]::Escape($c), '-' }
    $name = $name.Trim()
    if (-not $name) { $name = 'playlist' }
    # normalize whitespace
    $name = $name -replace '\s+', '-'
    return "$name`_details"
}

function Get-VideoIdFromUrl {
    param([string]$u)
    if (-not $u) { return $null }
    # match v=... or youtu.be/...
    $m = [regex]::Match($u, '(?:v=|youtu\.be/)([^&?/]+)')
    if ($m.Success) { return $m.Groups[1].Value }
    return $null
}

function Get-PlaylistIdFromUrl {
    param([string]$u)
    $m = [regex]::Match($u, '[\?&]list=([^&]+)')
    if ($m.Success) { return $m.Groups[1].Value }
    return $null
}

function HtmlDecode([string]$s) { return [System.Net.WebUtility]::HtmlDecode($s) }

try {
    # Determine URL type (playlist vs single video)
    $listId = Get-PlaylistIdFromUrl $Url
    $videoId = Get-VideoIdFromUrl $Url
    if ($listId) {
        $isPlaylist = $true
        $playlistUrl = "https://www.youtube.com/playlist?list=$listId"
    } elseif ($videoId) {
        $isPlaylist = $false
        $isSingleVideo = $true
        Write-Output "Detected single video URL: $videoId"
    } else {
        Write-Error "No playlist or video id found in URL: $Url" ; exit 2
    }

    # Resolve and validate OutDir early so write operations never receive an empty Path
    if (-not $OutDir) { $OutDir = $PSScriptRoot }
    try {
        $resolved = Resolve-Path -Path $OutDir -ErrorAction Stop
        $OutDir = $resolved.Path
    } catch {
        try {
            $resolvedScript = Resolve-Path -Path $PSScriptRoot -ErrorAction Stop
            $OutDir = $resolvedScript.Path
        } catch {
            $OutDir = $PSScriptRoot
        }
    }
    Write-Output "Resolved OutDir: $OutDir"

    # If yt-dlp available, use it (more reliable) for playlist or video metadata
    $yt = Get-Command yt-dlp -ErrorAction SilentlyContinue
    if ($yt -and $isPlaylist) {
        Write-Output "Using yt-dlp to fetch playlist data..."
        $json = & yt-dlp --flat-playlist -J $playlistUrl 2>$null
        if (-not $json) { Write-Error "yt-dlp returned no JSON" ; exit 3 }
        $obj = $json | ConvertFrom-Json
        $playlistTitle = $obj.title
        Write-Output "Playlist: $playlistTitle"

        # Populate $items so downstream WritePlaylist logic can create files
        $items = @()
        $i = 1
        foreach ($e in $obj.entries) {
            $vtitle = $e.title
            $vid = $e.id
            $vurl = "https://youtu.be/$vid"
            Write-Output ("{0}. {1} -> {2}" -f $i, $vtitle, $vurl)
            $items += [PSCustomObject]@{ Title = $vtitle; Url = $vurl }
            $i++
        }
    }

    # If single video (no playlist), write a simple markdown and exit
    if ($isSingleVideo) {
        if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir -Force | Out-Null }
        # Fetch title via yt-dlp if available, otherwise oEmbed
        if ($yt) {
            Write-Output "Using yt-dlp to fetch video metadata..."
            $vjson = & yt-dlp -j "https://www.youtube.com/watch?v=$videoId" 2>$null
            if ($vjson) { $vobj = $vjson | ConvertFrom-Json ; $vtitle = $vobj.title } else { $vtitle = "(video)" }
        } else {
            try {
                $oembedUrl = "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$videoId&format=json"
                $meta = Invoke-RestMethod -Uri $oembedUrl -ErrorAction Stop
                $vtitle = $meta.title
            } catch {
                $vtitle = "(video)"
            }
        }
        $fileName = Make-FilenameSafe($vtitle)
        $outPath = Join-Path $OutDir $fileName
        $body = "# $vtitle`n`n[Watch on YouTube](https://youtu.be/$videoId)`n`nTODO: Add notes for this video.`n"
        Set-Content -Path $outPath -Value $body -Encoding UTF8
        Write-Output "Wrote single video file: $outPath"
        exit 0
    }

    # For playlist fallback parsing only when playlist and no yt-dlp
    if ($isPlaylist -and -not $yt) {
        Write-Output "yt-dlp not found; falling back to HTML parsing of $playlistUrl"

        # Fetch playlist page
        $resp = Invoke-WebRequest -Uri $playlistUrl -UseBasicParsing -ErrorAction Stop
        $html = $resp.Content

        # Playlist title from <title> tag
        $t = [regex]::Match($html, '<title>(.*?)</title>', 'IgnoreCase')
        if ($t.Success) {
            $playlistTitle = $t.Groups[1].Value -replace '\s*-\s*YouTube\s*$', ''
        } else {
            $playlistTitle = "(unknown)"
        }
        $playlistTitle = HtmlDecode($playlistTitle.Trim())
        Write-Output "Playlist: $playlistTitle"

        # Find anchors to videos within the playlist page
        # Look for <a ... href="/watch?v=...&list=...&index=..."> or anchor with id="video-title"
        $pattern = '<a[^>]+href="(?<href>/watch\?v=[^\"]*?)"[^>]*>(?<text>.*?)</a>'
        $matches = [regex]::Matches($html, $pattern, 'IgnoreCase')

        $seen = @{}
        $items = @()
        foreach ($m in $matches) {
            $href = $m.Groups['href'].Value
            # Title text may contain tags; strip HTML tags
            $rawText = $m.Groups['text'].Value
            $titleText = [regex]::Replace($rawText, '<[^>]+>', '')
            $titleText = HtmlDecode($titleText.Trim())
            # Extract video id param
            $vidMatch = [regex]::Match($href, 'v=([^&]+)')
            if ($vidMatch.Success) {
                $vid = $vidMatch.Groups[1].Value
                if (-not $seen.ContainsKey($vid)) {
                    $seen[$vid] = $true
                    $items += [PSCustomObject]@{ Title = $titleText; Url = "https://youtu.be/$vid" }
                }
            }
        }

        if ($items.Count -eq 0) {
            Write-Output "No items found via anchor parsing; trying to extract from ytInitialData JSON..."
            $initMatch = [regex]::Match($html, 'ytInitialData\s*=\s*(\{.*?\})\s*;', 'Singleline')
            if ($initMatch.Success) {
                $jsonText = $initMatch.Groups[1].Value
                try {
                    $videoRuns = Select-String -InputObject $jsonText -Pattern '"videoId"\s*:\s*"([^"]+)"' -AllMatches
                    $vids = @()
                    foreach ($mm in $videoRuns.Matches) { $vids += $mm.Groups[1].Value }
                    $uniq = $vids | Select-Object -Unique

                    # Attempt to fetch titles via oEmbed if possible
                    foreach ($v in $uniq) {
                        $oembedUrl = "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$v&format=json"
                        try {
                            $meta = Invoke-RestMethod -Uri $oembedUrl -ErrorAction Stop
                            $vtitle = $meta.title
                        } catch {
                            $vtitle = "(video)"
                        }
                        $items += [PSCustomObject]@{ Title = $vtitle; Url = "https://youtu.be/$v" }
                    }
                    # continue (do not exit) so playlist writing can proceed
                } catch {
                    Write-Error "Failed to parse ytInitialData JSON: $_"
                    exit 6
                }
            } else {
                Write-Output "ytInitialData not found; cannot parse playlist items." ; exit 5
            }
        }
    }

    # Log items
    for ($i = 0; $i -lt $items.Count; $i++) {
        $n = $i + 1
        $it = $items[$i]
        Write-Output ("{0}. {1} -> {2}" -f $n, $it.Title, $it.Url)
    }

    if ($WritePlaylist) {
        # Ensure OutDir exists
        if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir -Force | Out-Null }
        $playlistSafeName = Make-FilenameSafe($playlistTitle)
        $outPath = Join-Path $OutDir $playlistSafeName

        $count = $items.Count
        $pad = $count.ToString().Length

        $sb = New-Object System.Text.StringBuilder
        [void]$sb.AppendLine("# $playlistTitle")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("Tutorials (each link opens the playlist at the corresponding video):")
        [void]$sb.AppendLine("")

        # Create details folder per playlist
        $playlistDirName = Make-DirSafe($playlistTitle)
        $detailsFullDir = Join-Path $OutDir $playlistDirName
        if (-not (Test-Path $detailsFullDir)) { New-Item -ItemType Directory -Path $detailsFullDir -Force | Out-Null }

        for ($i = 0; $i -lt $items.Count; $i++) {
            $num = $i + 1
            $it = $items[$i]
            $index = $num.ToString("D$pad")
            $slug = Make-Slug $it.Title
            $detailFile = "$index-$slug.md"

            # create detail file inside playlist-specific details folder
            $detailFullPath = Join-Path $detailsFullDir $detailFile
            $detailRelPath = "$playlistDirName/$detailFile"

            # If detail file doesn't exist, create with preserved title and anchors
            # build back anchor, optional Next link and body (always write/overwrite so formatting is correct)
            $backAnchor = '<a href="../{0}" style="color:#FFA239">Back to playlist</a>' -f $playlistSafeName
            # remove escaped quotes in backAnchor (ensure proper quotes)
            $backAnchor = $backAnchor -replace '\\"','"'

            # Build Next link (if there is a next item)
            if ($i -lt ($items.Count - 1)) {
                $nextNum = $i + 2
                $nextIndex = $nextNum.ToString("D$pad")
                $nextSlug = Make-Slug $items[$i+1].Title
                $nextFile = "$nextIndex-$nextSlug.md"
                $nextRelPath = "$playlistDirName/$nextFile"
                $nextLinkMd = "[Next: $($items[$i+1].Title)]($nextRelPath)"
            } else {
                $nextLinkMd = ""
            }

            if ($nextLinkMd -ne "") {
                $bottomAnchorLine = "$backAnchor | $nextLinkMd"
            } else {
                $bottomAnchorLine = $backAnchor
            }

            $body = "# $($it.Title)`n`n$backAnchor`n`n[Watch on YouTube]($($it.Url))`n`nTODO: Add detail notes for this tutorial.`n`n$bottomAnchorLine"
            Set-Content -Path $detailFullPath -Value $body -Encoding UTF8
            Write-Output "Created/Updated detail: $detailRelPath"

            $line = '{0}. <a href="{3}" style="color:#FFA239">View detail | </a> [{1}]({2})' -f $num, $it.Title, $it.Url, $detailRelPath
            [void]$sb.AppendLine($line)
        }

        Set-Content -Path $outPath -Value $sb.ToString() -Encoding UTF8
        Write-Output "Wrote playlist file: $outPath"
    }

    exit 0
} catch {
    Write-Error "Error fetching/parsing playlist: $_"
    exit 9
}
