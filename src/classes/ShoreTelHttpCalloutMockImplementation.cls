@isTest
public class ShoreTelHttpCalloutMockImplementation implements HttpCalloutMock {

    public HTTPResponse respond(HTTPRequest req){
        HTTPResponse theHTTPResponse = new HTTPResponse();
        theHTTPResponse.setHeader('Content-Type', 'application/json');
        theHTTPResponse.setBody('{"foo":"A wonderful HTTP response<pre>0003339993</pre>"}');
        theHTTPResponse.setStatusCode(200);
        return theHTTPResponse;
    }
    
}