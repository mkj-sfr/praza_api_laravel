<?php


namespace App\Services;
use Illuminate\Support\Facades\Http;

class SmsMessageService
{
    public function verification_sms($phone, $code)
    {
        $patternId = ""; // This should be the pattern ID
        $params = [
            "verification-code" => $code
        ];
        $response = $this->sms_sender($patternId, $phone, $params);

        return $response;
    }

    private function sms_sender($patternId, $to_number, $params)
    {
        $url = "https://api2.ippanel.com/api/v1/sms/pattern/normal/send";
        $apikey = "";
        $fromNumber = "3000505";
        $requestParams = [
            "code" => $patternId,
            "sender" => $fromNumber,
            "recipient" => $to_number,
            "variable" => $params
        ];

        $response = Http::withHeaders([
            'apikey' => $apikey,
            'Content-Type' => 'application/json',
        ])->post($url, $requestParams);

        return $response;
    }
}
