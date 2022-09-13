codeunit 62000 "Mgt Api Graph"
{
    trigger OnRun()
    var
        Token: Text;

    begin
        //Añadir el dato extraido de Azure
        ClientID := '';
        ClientSecret := '';
        Tenant := '';

        Token := GetTocken();
        Message('el token es: ' + Token);
    end;

    local procedure GetTocken() AccessToken: text
    var
        OAuth2: Codeunit OAuth2;
        Scopes: List of [Text];
        URL: Text;
        ScopeLbl: Label 'https://graph.microsoft.com/.default', Locked = true;
        UrlTokenLbl: Label 'https://login.microsoftonline.com/%1/oauth2/v2.0/token', Locked = true;
    begin
        Clear(Scopes);
        clear(OAuth2);

        Scopes.Add(ScopeLbl);

        URL := StrSubstNo(UrlTokenLbl, Tenant);
        OAuth2.AcquireTokenWithClientCredentials(ClientID, ClientSecret, URL, '', Scopes, AccessToken);

    end;

    var
        ClientID: Text;
        ClientSecret: Text;
        Tenant: Text;

}