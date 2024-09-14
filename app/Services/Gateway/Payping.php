<?php
namespace App\Services\Gateway;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class Payping {
    protected $token = "qGdhCQkDHdjnXlahYcssorMHKDMh8IN29-TttgYeoLo";
    protected $returnUrl = "https://boxite/payping/PHP-Basic-API/verify.php";

    function initiatePayment($amount=0, $clientRefId="example@gmail.com", $mobile=null, $desc="") {    
        $payerIdentity = $mobile == null ? $clientRefId : $mobile;
        if ($mobile = null && $clientRefId = null) {
            $payerIdentity = time();
        }
        
        $tokenCode = $this->token;
        $returnUrl = $this->returnUrl; // Replace with your actual return URL
    
        $data = [
            'clientRefId' => $clientRefId,
            'payerIdentity' => $payerIdentity,
            'Amount' => $amount,
            'Description' => $desc,
            'returnUrl' => $returnUrl
        ];
    
        try {
            $response = Http::withHeaders([
                "accept" => "application/json",
                "authorization" => "Bearer " . $tokenCode,
                "cache-control" => "no-cache",
                "content-type" => "application/json"
            ])->post("https://api.payping.ir/v2/pay", $data);
    
            if ($response->successful()) {
                $responseData = $response->json();
                if (isset($responseData) && !empty($responseData)) {
                    $paymentCode = $responseData['code'];
                    $goToIPG = 'https://api.payping.ir/v2/pay/gotoipg/' . $paymentCode;
                    return redirect()->away($goToIPG);
                } else {
                    $msg = 'Transaction failed - Error: No payment code received';
                }
            } elseif ($response->status() == 400) {
                $msg = 'Transaction failed - Error: ' . $response->body();
            } else {
                $msg = 'Transaction failed - Error: ' . $response->status();
            }
        } catch (\Exception $e) {
            $msg = 'Transaction failed - Error on your end: ' . $e->getMessage();
        }
        
        return response()->json(['error' => $msg], 500); // Or handle the error response accordingly
    }

    function verifyPayment(Request $request) {
        $refId = $request->input('refid', 0);
        $amount = 1000; // Amount in toman
        $tokenCode = $this->token; // Replace with your actual token
    
        $data = [
            'amount' => $amount,
            'refId' => $refId
        ];
    
        try {
            $response = Http::withHeaders([
                "accept" => "application/json",
                "authorization" => "Bearer " . $tokenCode,
                "cache-control" => "no-cache",
                "content-type" => "application/json"
            ])->post("https://api.payping.ir/v2/pay/verify", $data);
    
            $header = $response->headers();
            $statusCode = $response->status();
    
            if ($response->successful()) {
                $responseData = $response->json();
                if (isset($refId) && $refId != '') {
                    $msg = 'Transaction was successful: ' . $refId;
                } else {
                    $msg = 'Unfortunately, the system was unable to retrieve the tracking code. Response: ' . $statusCode;
                }
            } elseif ($statusCode == 400) {
                $msg = 'Transaction failed - Error: ' . $response->body();
            } else {
                $msg = 'Transaction failed - Error: ' . $statusCode;
            }
        } catch (\Exception $e) {
            $msg = 'Transaction failed - Error on your end: ' . $e->getMessage();
        }
        
        return view('payment_status', ['msg' => $msg]);
    }
}