#-------------------------------------------------------------
# Script Name:  chatbot_query.pl
# Author: TonyB
# Date: July 3 2023
# Purpose: Calls the OpenAI 'Completion' API from Perl to 
#          experiment with integration between Perl
#          and OpenAI API's.
#
# OpenAI Completion Endpoint Documentation:
#   https://platform.openai.com/docs/api-reference/completions
#
# Before running this script under Windows Powershell, we set 
# the api key into the environment with: 
#   $env:OPENAI_API_KEY="sk-ais__MY_KEY__9sPExnwg8piZeCX" 
#
# Changes:
# 7/3/2023 First time deployment. We ask chatGpt how to 
#    bake a cherry pie
#-------------------------------------------------------------
use strict;
use warnings;
use JSON;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;

my $api_key = $ENV{'OPENAI_API_KEY'}; 
print "API Key: [$api_key]\n";
my $endpoint = 'https://api.openai.com/v1/chat/completions';

my $req = HTTP::Request->new('POST', $endpoint);
$req->header('Content-Type' => 'application/json');
$req->header('Authorization' => "Bearer $api_key");

my $post_data = {
    'model' => 'gpt-3.5-turbo',
    'messages' => [
        {'role' => 'system', 'content' => 'You are a helpful assistant.'},
        {'role' => 'user', 'content' => 'Good evening. can you tell me how to bake a cherry pie?'}
    ],
};

$req->content(encode_json($post_data));

my $resp = $ua->request($req);

if ($resp->is_success) {
    my $message = $resp->decoded_content;
    my $decoded_json = decode_json($message);
    print "Assistant's reply: ", $decoded_json->{'choices'}[0]{'message'}{'content'}, "\n";
}
else {
    print "HTTP POST error code: ", $resp->code, "\n";
    print "HTTP POST error message: ", $resp->message, "\n";
}
