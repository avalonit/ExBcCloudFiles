codeunit 70659926 "ALV AzFile Service API" implements "ALV CloudManagementInterface"
{
    procedure Download(folderName: Text; fileName: Text; var output: InStream): Boolean
    var
        configuration: Record "ALV AzConnector Configuration";
        AppInsights: Codeunit "ALV Application Insights Mgt.";
        AppTelemetry: Codeunit "ALV Application Telemetry";
        client: HttpClient;
        response: HttpResponseMessage;
        headers: HttpHeaders;
        azureApiEndpoint: Text;
        urlFolderPart: Text;
        requestDateString: Text;
        sharedKeyLite: Text;
        canonicalizedStringToBuild: Text;
        method: Text;
        xmsversion: Text;
        urlCanonicalPath: Text;
        contentType: Text;
        EncryptionManagement: codeunit "Cryptography Management";
        newLine: Text;
        charCr: Char;
        telemetryID: Text;
    begin
        if not configuration.FindFirst() then exit(false);
        AppInsights.TraceInformation('ALV AzFile Service API Download Start');
        telemetryID := 'ALV AzFile Service API::Download::' + fileName;
        AppTelemetry.Start(telemetryID);

        urlFolderPart := StrSubstNo('%1/%2', folderName, fileName);
        azureApiEndpoint := StrSubstNo('%1/%2', configuration.AzureFileUri, urlFolderPart);

        requestDateString := GetUTCDate(CurrentDateTime());
        method := 'GET';
        xmsversion := GetXmsVersion();
        contentType := '';
        urlCanonicalPath := StrSubstNo('/%1/%2/%3/%4', configuration.AzureFileUsername, configuration.CloudWorkingPath, folderName, fileName);

        charCr := 10;
        newLine := FORMAT(charCr);
        canonicalizedStringToBuild := StrSubstNo('%1%6%6%2%6%6x-ms-date:%3%6x-ms-version:%4%6%5', method, contentType, requestDateString, xmsversion, urlCanonicalPath, newLine);
        sharedKeyLite := EncryptionManagement.GenerateBase64KeyedHashAsBase64String(canonicalizedStringToBuild, configuration.AzureBlobToken, 2);
        sharedKeyLite := StrSubstNo('SharedKeyLite %1:%2', configuration.AzureFileUsername, sharedKeyLite);

        client.DefaultRequestHeaders().Clear();
        client.DefaultRequestHeaders().Add('Authorization', sharedKeyLite);
        client.DefaultRequestHeaders().Add('x-ms-date', requestDateString);
        client.DefaultRequestHeaders().Add('x-ms-version', xmsversion);

        if client.Get(azureApiEndpoint, response) then begin
            AppInsights.TraceInformation('ALV AzFile Service API Download Completed');
            AppTelemetry.Log(telemetryID);
            exit(response.Content().ReadAs(output))
        end
        else begin
            AppInsights.TraceError('ALV AzFile Service API Download Failed');
        end;
    end;

    procedure Download(folderName: Text; fileName: Text; var output: Text): Boolean
    var
        configuration: Record "ALV AzConnector Configuration";
        AppInsights: Codeunit "ALV Application Insights Mgt.";
        AppTelemetry: Codeunit "ALV Application Telemetry";
        client: HttpClient;
        response: HttpResponseMessage;
        headers: HttpHeaders;
        azureApiEndpoint: Text;
        urlFolderPart: Text;
        requestDateString: Text;
        sharedKeyLite: Text;
        canonicalizedStringToBuild: Text;
        method: Text;
        xmsversion: Text;
        urlCanonicalPath: Text;
        contentType: Text;
        EncryptionManagement: codeunit "Cryptography Management";
        newLine: Text;
        charCr: Char;
        telemetryID: Text;
    begin
        if not configuration.FindFirst() then exit(false);
        AppInsights.TraceInformation('ALV AzFile Service API Download Start');
        telemetryID := 'ALV AzFile Service API::Download::' + fileName;
        AppTelemetry.Start(telemetryID);

        urlFolderPart := StrSubstNo('%1/%2', folderName, fileName);
        azureApiEndpoint := StrSubstNo('%1/%2', configuration.AzureFileUri, urlFolderPart);

        requestDateString := GetUTCDate(CurrentDateTime());
        method := 'GET';
        xmsversion := GetXmsVersion();
        contentType := '';
        urlCanonicalPath := StrSubstNo('/%1/%2/%3/%4', configuration.AzureFileUsername, configuration.CloudWorkingPath, folderName, fileName);

        charCr := 10;
        newLine := FORMAT(charCr);
        canonicalizedStringToBuild := StrSubstNo('%1%6%6%2%6%6x-ms-date:%3%6x-ms-version:%4%6%5', method, contentType, requestDateString, xmsversion, urlCanonicalPath, newLine);
        sharedKeyLite := EncryptionManagement.GenerateBase64KeyedHashAsBase64String(canonicalizedStringToBuild, configuration.AzureBlobToken, 2);
        sharedKeyLite := StrSubstNo('SharedKeyLite %1:%2', configuration.AzureFileUsername, sharedKeyLite);

        client.DefaultRequestHeaders().Clear();
        client.DefaultRequestHeaders().Add('Authorization', sharedKeyLite);
        client.DefaultRequestHeaders().Add('x-ms-date', requestDateString);
        client.DefaultRequestHeaders().Add('x-ms-version', xmsversion);

        if client.Get(azureApiEndpoint, response) then begin
            AppInsights.TraceInformation('ALV AzFile Service API Download Completed');
            AppTelemetry.Log(telemetryID);
            exit(response.Content().ReadAs(output))
        end
        else begin
            AppInsights.TraceError('ALV AzFile Service API Download Failed');
        end;
    end;


    procedure GetUTCDate(currentDateTime: DateTime): Text
    var
        requestDateString: Text;
    begin
        //UTC: sample Mon, 18 May 2020 08:53:13 GMT
        requestDateString := Format(currentDateTime, 0, '<Weekday Text,3>, <Day> <Month Text> <Year4> <Hours24,2>:<Minutes,2>:<Seconds,2> GMT');
        exit(requestDateString);
    end;

    procedure GetXmsVersion(): Text
    var
        xmsVersion: Text;
    begin
        xmsVersion := '2017-11-09';
        exit(xmsVersion);
    end;
}