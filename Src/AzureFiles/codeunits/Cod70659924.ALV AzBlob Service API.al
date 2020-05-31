codeunit 70659924 "ALV AzBlob Service API" implements CloudManagementInterface
{


    procedure Download(containerName: Text; blobName: Text; var text: Text): Boolean
    var
        configuration: Record "ALV AzConnector Configuration";
        client: HttpClient;
        response: HttpResponseMessage;
    begin
        if not configuration.FindFirst() then exit(false);
        //GET https://<accountname>.blob.core.windows.net/<container>/<blob>?<sastoken>
        if not client.Get(StrSubstNo('%1/%2/%3?%4', configuration.AzureBlobUri, containerName, blobName, configuration.AzureBlobToken), response) then exit(false);
        exit(response.Content().ReadAs(text));
    end;

    procedure Download(containerName: Text; blobName: Text; var stream: InStream): Boolean
    var
        configuration: Record "ALV AzConnector Configuration";
        client: HttpClient;
        response: HttpResponseMessage;
    begin
        if not configuration.FindFirst() then exit(false);
        //GET https://<accountname>.blob.core.windows.net/<container>/<blob>?<sastoken>
        if not client.Get(StrSubstNo('%1/%2/%3?%4', configuration.AzureBlobUri, containerName, blobName, configuration.AzureBlobToken), response) then exit(false);
        exit(response.Content().ReadAs(stream))
    end;


}

