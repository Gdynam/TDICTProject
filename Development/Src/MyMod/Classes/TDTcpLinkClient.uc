class TDTcpLinkClient extends TcpLink;
 
var string TargetHost; //De Url van de website waar hij mee moet communiceren
var int TargetPort; //De poort van de website
var string path; //path to file you want to request
var string requesttext; //de data dat we zenden
var string websitequery;//will send query
var bool send; //Of hij moet zenden of ontvangen
var string recivedtext; //text dat we terug krijgen
var bool sending;   //of hij nog in verbinding is.
 
event PostBeginPlay()
{
    super.PostBeginPlay();
}
 
function ResolveMe() //removes having to send a host
{
    Resolve(targethost);
}
 
event Resolved( IpAddr Addr )
{
    // The hostname was resolved succefully
    `Log("[TcpLinkClient] "$TargetHost$" resolved to "$ IpAddrToString(Addr));
 
    // Make sure the correct remote port is set, resolving doesn't set
    // the port value of the IpAddr structure
    Addr.Port = TargetPort;
 
    //dont comment out this log because it rungs the function bindport
    `Log("[TcpLinkClient] Bound to port: "$ BindPort() );
    if (!Open(Addr))
    {
        //`Log("[TcpLinkClient] Open failed");
    }
}
 
event ResolveFailed()
{
    `Log("[TcpLinkClient] Unable to resolve "$TargetHost);
}
 
event Opened()
{
	sending = true;
    // A connection was established
    `Log(">>>>>>>[TcpLinkClient] event opened<<<<<<<<");
    `Log(">>>>>>>[TcpLinkClient] Sending simple HTTP query<<<<<<<<<<");
 
    //The HTTP GET request
    //char(13) and char(10) are carrage returns and new lines
    if(send == false)
    {
        SendText("GET /"$path$" HTTP/1.0");
        SendText(chr(13)$chr(10));
        SendText("Host: "$TargetHost);
        SendText(chr(13)$chr(10));
        SendText("Connection: Close");
        SendText(chr(13)$chr(10)$chr(13)$chr(10));
    }
    else if(send == true && websitequery != "")
    {
		//De variable submit zorgt ervoor dat niet iedereen zomaar gegevens kan sturen
        requesttext = "webquery="$websitequery$"&submit=35056";
 
        SendText("POST /"$path$" HTTP/1.0"$chr(13)$chr(10));
        SendText("Host: "$TargetHost$chr(13)$chr(10));
        SendText("User-Agent: HTTPTool/1.0"$Chr(13)$Chr(10));
        SendText("Content-Type: application/x-www-form-urlencoded"$chr(13)$chr(10));
        //We gebruike de lengte van de request om te vertellen aan de host
        //hoe lang de content is
        SendText("Content-Length: "$len(requesttext)$Chr(13)$Chr(10));
        SendText(chr(13)$chr(10));
        SendText(requesttext);
        SendText(chr(13)$chr(10));
        SendText("Connection: Close");
        SendText(chr(13)$chr(10)$chr(13)$chr(10));
    }
 
    `Log("[TcpLinkClient] end HTTP query");

}
 
event Closed()
{
    // In this case the remote client should have automatically closed
    // the connection, because we requested it in the HTTP request.
	sending = false;
	`Log(">>>>>>[TcpLinkClient] event closed<<<<<");

    // After the connection was closed we could establish a new
    // connection using the same TcpLink instance.
}
 
event ReceivedText( string Text )
{
    // receiving some text, note that the text includes line breaks
    `Log("[TcpLinkClient] ReceivedText:: "$Text);
 
    //we dont want the header info, so we split the string after two new lines
    Text = Split(Text, chr(13)$chr(10)$chr(13)$chr(10), true);
    `Log("[TcpLinkClient] SplitText:: " $Text);
	recivedtext = Text;
 
    //First we will recieve data from the server via GET
    if (send == false)
    {
        send = true; //next time we resolve, we will send player score
    }
}
 
defaultproperties
{
    TargetHost="ictprojects.123bemyhost.com"
    TargetPort=80 //default voor HTTP
    path = "config/databasequery.php"
	websitequery = ""
    send = false
	recivedtext = "0"
	sending = false
}