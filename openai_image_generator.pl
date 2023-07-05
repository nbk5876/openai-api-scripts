#-------------------------------------------------------------
# Script Name:  openai_image_generator.pl
# Author: TonyB
# Date: July 5 2023
# Purpose: 
# OpenAI Completion Endpoint Documentation:
#   https://platform.openai.com/docs/api-reference/images/create
#
# Before running this script under Windows Powershell, set 
# the api key into the environment with: 
#   $env:OPENAI_API_KEY="sk-ais__MY_KEY__9sPExnwg8piZeCX" 
#
# Changes:
# 7/5/2023 First time deployment. 
#-------------------------------------------------------------
#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Data::Dumper;

my $api_key = $ENV{'OPENAI_API_KEY'}; 
print "API Key: [$api_key]\n";

my $url = "https://api.openai.com/v1/images/generations";

my $ua = LWP::UserAgent->new;

my $req = HTTP::Request->new(POST => $url);
$req->header('Content-Type' => 'application/json');
$req->header('Authorization' => "Bearer $api_key");

my $post_data = { 'prompt' => 'A cute baby sea otter', 'n' => 2, 'size' => '1024x1024' };
my $json = encode_json $post_data;

$req->content($json);

my $resp = $ua->request($req);
if ($resp->is_success) {
    my $message = decode_json($resp->decoded_content);
    print "Received reply: ", Dumper($message), "\n";

    # Download images
    my $image_index = 1;
    for my $image (@{$message->{data}}) {
        my $image_url = $image->{url};
        print "Downloading image from $image_url\n";

        my $res = $ua->get($image_url, ':content_file' => "image$image_index.png");
        if ($res->is_success) {
            print "Image saved as image$image_index.png\n";
        }
        else {
            print "Failed to download image: ", $res->status_line, "\n";
        }
        $image_index++;
    }
}
else {
    print "HTTP POST error code: ", $resp->code, "\n";
    print "HTTP POST error message: ", $resp->message, "\n";
}
