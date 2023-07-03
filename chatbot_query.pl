#-----------------------------------------------------------
# Script Name:  chatbot_query.pl
# Date: July 3 2023
# Purpose: calls the OpenAI Completion API
#
#-----------------------------------------------------------

use strict;
use warnings;
use JSON;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;

my $api_key = 'your-api-key'; # replace with your OpenAI API key
my $endpoint = 'https://api.openai.com/v1/engines/davinci-codex/completions';

my $req = HTTP::Request->new('POST', $endpoint);
$req->header('Content-Type' => 'application/json');
$req->header('Authorization' => "Bearer $api_key");

my $post_data = {
    'prompt' => 'Translate the following English text to French: {}',
    'max_tokens' => 60,
};

$req->content(encode_json($post_data));

my $resp = $ua->request($req);

if ($resp->is_success) {
    my $message = $resp->decoded_content;
    print "Received reply: $message\n";
}
else {
    print "HTTP POST error code: ", $resp->code, "\n";
    print "HTTP POST error message: ", $resp->message, "\n";
}
